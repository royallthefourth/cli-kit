#lang racket/base

(require racket/contract)
(provide cli-option
         (contract-out
          [make-cli-option (->
                            #:name string?
                            #:shortname string?
                            #:variadic boolean?
                            #:description string?
                            cli-option?)]))

(struct cli-option
  (name
   shortname
   variadic
   description)
  #:inspector #f)

(define
  (make-cli-option
   #:name name
   #:shortname [shortname ""]
   #:variadic [variadic #f]
   #:description [description ""])
  (cli-option
   name
   shortname
   variadic
   description))
