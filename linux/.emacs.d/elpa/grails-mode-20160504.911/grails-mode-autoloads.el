;;; grails-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "grails-mode" "grails-mode.el" (0 0 0 0))
;;; Generated autoloads from grails-mode.el

(autoload 'grails-mode "grails-mode" "\
Grails Minor Mode.
     With no argument, this command toggles the mode.
     Non-null prefix argument turns on the mode.
     Null prefix argument turns off the mode.

If called interactively, enable Grails mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

     When Grails mode is enabled, several keys are enabled that
     will allow navigation around a typical grails project.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "grails-mode" '("anything-grails-project-files" "grails-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; grails-mode-autoloads.el ends here
