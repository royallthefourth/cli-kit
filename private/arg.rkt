#lang racket/base

(require racket/contract)
(provide cli-arg
         (contract-out
          [make-cli-arg (->
                            #:name string?
                            #:variadic boolean?
                            #:required boolean?
                            #:description string?
                            cli-arg?)]))

(struct cli-arg
  (name
   variadic
   required
   description)
  #:inspector #f)

(define
  (make-cli-arg
   #:name name
   #:variadic [variadic #f]
   #:required [required #t]
   #:description [description ""])
  (cli-arg
   name
   variadic
   required
   description))
