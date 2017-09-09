#lang racket/base

(require
  racket/contract
  "arg.rkt"
  "option.rkt")
(provide cli-command
         (contract-out
          [make-cli-command (->
                             #:group string?
                             #:name string?
                             #:description string?
                             #:args (listof (struct/dc cli-arg))
                             #:opts (listof (struct/dc cli-option))
                             #:proc procedure?
                             cli-command?)]
          [sort-commands (-> (listof (struct/dc cli-command)) (listof (struct/dc cli-command)))]))

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

(define (sort-commands commands)
  'default)

(module+ test
  (require rackunit)
  (check-equal? 1 1.0 "not equal?"))