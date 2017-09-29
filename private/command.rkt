#lang racket/base

(require
  racket/contract
  racket/format
  racket/list
  "arg.rkt"
  "option.rkt")
(provide cli-command
         cmd-by-group
         cmd-help-format
         (contract-out
          [make-cli-command (->*
                             (#:name string?
                              #:proc procedure?)
                             (#:group string?
                             #:description string?
                             #:args (listof (struct/dc cli-arg))
                             #:opts (listof (struct/dc cli-option)))
                             cli-command?)]
          [longest-cmd (-> (listof (struct/dc cli-command)) integer?)]))

(struct cli-command
  (group
   name
   description
   args
   opts
   proc)
  #:inspector #f)

(define
  (make-cli-command
   #:group [group "app"]
   #:name name
   #:description [description ""]
   #:args [args '()]
   #:opts [opts '()]
   #:proc proc)
  (cli-command
   group
   name
   description
   args
   opts
   proc))

(define (longest-cmd commands)
  (let ([longest (argmax
            (λ (cmd)
              (+ 1 (string-length (cli-command-group cmd)) (string-length (cli-command-name cmd))))
            commands)])
    (+ 1 (string-length (cli-command-group longest)) (string-length (cli-command-name longest)))))

;; sorted list of lists
;; each list has a group as its head and a sorted list of commands after
(define (cmd-by-group commands)
  ; for each group, add a sorted list of the commands having that group
  (for/list ([group (sort (map cli-command-group commands) string<?)])
    (cons group (sort (filter (λ (c) (equal? group (cli-command-group c))) commands) string<?))))

(define (cmd-help-format cmd width)
  ; return 2 spaces + group:name + padding spaces + description to output
  (string-append "  "
                 (~a (cli-command-group cmd) (cli-command-name cmd) #:separator ":" #:min-width width)
                 (cli-command-description cmd)
                 "\n"))

(module+ test
  (require rackunit)
  (let* ([cmds (list
               (make-cli-command #:group "alpha" #:name "test" #:proc (λ () "hello") #:description "A fake command")
               (make-cli-command #:group "beta" #:name "test-more" #:proc (λ () "again")))]
         [grouped (cmd-by-group cmds)])
    (check-equal? 14 (longest-cmd cmds))
    (check-equal? "alpha" (car (first grouped)))
    (check-equal? 1 (length (cdr (first grouped))))))
