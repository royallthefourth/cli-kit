#lang racket/base

(require
  racket/stream
  racket/string
  "arg.rkt"
  "command.rkt"
  "option.rkt")
(provide cli-run)

; TODO write formatters for progressbar
; recommend using racket table lib: https://github.com/Metaxal/text-table
; TODO write question helper
; TODO write password input helper

(define (cli-run
         name
         commands
         [version ""])
  (displayln (greeting name version))
  (select-command commands (current-command-line-arguments)))

(define (select-command
         commands
         args)
  (let ([cmd (cmd-in-list commands args)])
    (cond
      [(equal? 0 (vector-length (current-command-line-arguments))) (show-help-general commands)]
    ))
  ; TODO check for presence of arg in list and print error if not found
  ; TODO if arg matches, execute command
  ; TODO catch and output exceptions
  'todo
  )

(define (show-help-general commands)
  (let ([maxlen (longest-cmd commands)])
    (for/fold ([output (stream "Available Commands:\n")])
              ([group (cmd-by-group commands)])
              (stream-append output (stream " " (car group) "\n")
                             (stream (for/fold ([cmd-desc ""])
                                       ([cmd (cdr group)])
                               (string-append cmd-desc (cmd-help-format cmd maxlen))))))))

(define (display-stream s)
  (for ([o (in-stream s)]) (display o)))

(define (greeting name version)
  (cond
    [(non-empty-string? version) (string-append name " v" version)]
    [else name]))
