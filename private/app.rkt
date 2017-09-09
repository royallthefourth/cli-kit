#lang racket/base

(require
  racket/contract
  racket/string
  "arg.rkt"
  "command.rkt"
  "option.rkt")
(provide cli-run!)

; TODO write formatters for table, progressbar
; TODO write question helper

(define (cli-run!
         name
         commands
         [version ""]
         [input (current-input-port)]
         [output (current-output-port)])
  (displayln (greeting name version) output))

(define (run-commands!
         commands
         input
         output
         args)
  ; TODO check for presence of arg
  ; TODO if arg present, execute command
  ; TODO if arg absent, display help
  ; TODO catch and output exceptions
  )

(define (show-help-general commands output)
  ; TODO create categories based on commands
  ; TODO output commands by category
  ; TODO indent output by counting spaces
  )

(define (greeting name version)
  (cond
    [(non-empty-string? version) (string-append name " v" version)]
    [else name]))
