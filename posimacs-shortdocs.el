;;; posimacs-shortdocs.el --- Supplemental shortdocs  -*- lexical-binding: t -*-

;; Copyright (C) 2022 Positron Solutions

;; Homepage: https://github.com/positron-solutions/posimacs-shortdocs
;; Author: Psionik K <73710933+psionic-k@users.noreply.github.com>
;; Keywords: docs
;; Version: 0.1.0
;; Package-Requires: ((emacs "28.1"))

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Supplemental shortdocs for bootstrapping new users.
;; M-x shortdoc-display-group RET group RET
;; See the definitions below for the groups.

;;; Code:

(eval-when-compile
  (require 'shortdoc))

(define-short-documentation-group eieio
  "Introspecting classes and objects"
  (symbol-plist
   :no-eval (symbol-plist 'magit-dispatch)
   :eg-result-string "(transient--prefix #<transient-prefix transient-prefix-20997da>)")
  (eieio-object-class
   :no-manual t
   :eval (eieio-object-class (get 'magit-dispatch 'transient--prefix)))
  (eieio-object-class-name
   :no-manual t
   :eval (eieio-object-class-name (get 'magit-dispatch 'transient--prefix)))
  (eieio-class-slots
   :no-manual t
   :no-eval (eieio-class-slots 'transient-prefix)
   :eg-result-string "list of slots")
  (find-class
   :no-manual t
   :no-eval (find-class 'transient-prefix)
   :eg-result-string "class struct")
  (describe-function
   :no-eval (describe-function 'transient-prefix)
   :eg-result-string "displays class constructor options in help buffer")
  (object-write
   :no-manual t
   :eval (get 'magit-dispatch 'transient--prefix))
  (oref
   :no-manual t
   :eval (oref (get 'magit-dispatch 'transient--prefix) command)
   :eval (oref (get 'magit-dispatch 'transient--prefix) history-pos))
  (slot-value
   :no-manual t
   :eval (slot-value (get 'magit-dispatch 'transient--prefix) 'scope)
   :eval (slot-value (get 'magit-dispatch 'transient--prefix) 'command))
  (child-of-class-p
   :no-manual t
   :eval (child-of-class-p transient-argument transient-child))
  (slot-exists-p
   :no-manual t
   :eval (slot-exists-p transient-argument 'level)
   :eval (slot-exists-p transient-argument 'command)
   :eval (slot-exists-p transient-argument 'not-a-real-slot))
  (slot-boundp
   :no-manual t
   :eval (slot-boundp (get 'magit-dispatch 'transient--prefix) 'command))
  (eieio-browse
   :no-manual t
   :eg-result-string "Show hierarchy of classes")
  "Defining and Overriding Classes"
  ;; defining methods is in the manual, but defining classes is not.
  (defclass :no-manual t)
  (cl-defgeneric)
  (cl-defmethod)
  (oref :no-manual t)
  (oref-default :no-manual t)
  (oset :no-manual t)
  (oset-default :no-manual t)
  (cl-call-next-method
   :no-eval (call-next-method obj))
  (cl-next-method-p
   :no-eval (cl-next-method-p)))

(define-short-documentation-group transient
  "Macros for defining new instances."
  (transient-define-prefix :no-manual t)
  (transient-define-argument :no-manual t)
  (transient-define-infix :no-manual t)
  (transient-define-argument :no-manual t)
  (transient-define-groups :no-manual t)
  "Access during layout"
  (oref
   :no-manual t
   :no-eval (oref transient--prefix scope))
  "Access during suffix body"
  (transient-suffixes
   :no-eval (transient-suffixes 'magit-dispatch)
   :eg-result-string "List of suffix objects for arbitrary prefix"
   :no-eval transient-suffixes
   :eg-result-string "List of suffixes for `transient-current-prefix'.")
  (transient-args
   :no-manual t
   :eval (transient-args 'magit-dispatch))
  (transient-arg-value
   :no-manual t
   :no-eval (transient-arg-value "--flavor=" (transient-args transient-current-command))
   :eg-result-string "Remember most arguments use their argument representation as their key.")
  "Accessing other transients and their infixes"
  (transient-suffixes
   :no-manual t
   :no-eval (transient-suffixes 'magit-dispatch)
   :eg-result-string "Suffixes for an arbitrary prefix command."
   :no-eval (oref suffix-object value)
   :eg-result-string "Value of a suffix from `transient-suffixes'")
  (get
   :no-eval (get 'suffix-command 'transient--suffix)
   :eg-result-string "Suffix object for a suffix command."
   :no-eval (get 'prefix-command 'transient--prefix)
   :eg-result-string "Prefix object for a prefix command.")
  (oref
   :no-eval (oref (get 'magit-dispatch 'transient--prefix) scope)
   :eg-result-string "Value that would be used to re-populate suffixes."
   :eval (oref (get 'magit-dispatch 'transient--prefix) variable))
   ;; This would be great, but transient doesn't keep suffixes hydrated all the time.
   ;; :eval (oref (get 'magit:--gpg-sign 'transient--suffix) value)
   ;;:eg-result-string "This value may be nil in between prefix initalizations."

   "Flow control"
  (transient-setup
   :no-manual t
   :no-eval (transient-setup 'magit-dispatch)
   :eg-result-string "Transient set up for this prefix."
   :no-eval (transient-setup 'magit-dispatch nil nil :scope "value")
   :eg-result-string "Transient set up with custom scope.")
  (transient--do-stay
   :no-manual t
   :eg-result-string "Infixes that don't access variables and stay in the same prefix.")
  (transient--do-call
   :no-manual t
   :eg-result-string "Suffixes that need to access variables but stays in the same prefix.")
  (transient--do-replace
   :no-manual t
   :eg-result-string "Current prefix will be replaced and not left on the stack.")
  (transient--do-recurse
   :no-manual t
   :eg-result-string "Sub-prefix's suffixes will all return to current prefix.")
  (transient--do-return
   :no-manual t
   :eg-result-string "If there is a prefix on the stack, return to it before evaluating this command.")
  (transient--do-exit
   :no-manual t
   :eg-result-string "Pop the entire stack and exit transient before evaluating this command.")
  "Manipulating persistence & state"
  (transient-set
   :no-manual t
   :eg-result-string "Set for this session, on the prefix object.")
  (transient-save
   :no-manual t
   :eg-result-string "Save for future sessions, in `transient-values'.")
  (transient-reset
   :no-manual t
   :eg-result-string "Forget saved & set values.")
  (transient-history-next
   :no-manuat t
   :eg-result-string "Use previous value from `transient-history'")
  (transient-history-prev
   :no-manual t
   :eg-result-string "Use previous value from `transient-history'")
  "Readers for arguments"
  (transient-read-number-N+ :no-manual t)
  (transient-read-number-N0 :no-manual t)
  (transient-read-date :no-manual t)
  (transient-read-file :no-manual t)
  (transient-read-directory :no-manual t)
  (transient-read-existing-directory :no-manual t)
  (transient-read-existing-file :no-manual t)

  "Modifying Layouts"
  (transient-parse-suffix
   :no-manual t
   :eval (transient-parse-suffix 'magit-dispatch '("a" "argument" "--argument=")))
  (transient-parse-suffixes
   :no-manual t
   :eval (transient-parse-suffixes 'magit-dispatch [("a" "argument" "--argument=")]))
  (transient-get-suffix
   :no-manual t
   :eval (transient-get-suffix 'magit-dispatch "c")
   :eval (transient-get-suffix 'magit-dispatch 'magit-commit)
   :eval (transient-get-suffix 'magit-dispatch '(0 1 1)))
  (transient-remove-suffix :no-manual t)
  (transient-replace-suffix :no-manual t)
  (transient-insert-suffix :no-manual t)
  (transient-suffix-put :no-manual t)
  "Classes"
  (transient-prefix :no-manual t)
  (transient-suffix :no-manual t)
  (transient-infix :no-manual t)
  (transient-variable :no-manual t)
  (transient-child-variable :no-manual t)
  (transient-lisp-variable :no-manual t)
  (transient-argument :no-manual t)
  (transient-switches :no-manual t)
  (transient-option :no-manual t)
  (transient-files :no-manual t)
  (transient-switch :no-manual t)
  (transient-child :no-manual t)
  (transient-group :no-manual t)
  (transient-subgroups :no-manual t)
  (transient-columns :no-manual t)
  (transient-column :no-manual t)
  (transient-row :no-manual t))

(define-short-documentation-group plist
  "Plists"
  (list
   :eval '(bar t foo 4))
  (plist-put
   :eval (plist-put '(bar t foo 4) 'baz 1.0))
  (plist-get
   :eval (plist-get '(bar t foo 4) 'foo)))

;; Let's just have enough forms to recall search keys for the rest and at least
;; hit on the main concepts.
(define-short-documentation-group dash
  "A modern list API for Emacs."
  (->
   :eval (-> '(2 3 5))
   :eval (-> '(2 3 5) (append '(8 13)))
   :eval (-> '(2 3 5) (append '(8 13)) (-slice 1 -1)))
  (->>
   :eval (->> '(1 2 3) (-sum)))
  (-->
   :eval (--> "def" (concat "abc" it "ghi")))
  (-some->>
   :eval (-some->> '(1 2 3) (--filter (= 0 (% it 2))) (--map (+ it 100)))
   :eval (-some->> '(1 3 5) (--filter (= 0 (% it 2))) (--map (+ it 100))))
  (-when-let*
   :eval (-when-let* ((x 5) (y 3) (z (+ y 4))) (+ x y z)))
  (-partial
   :eval (funcall (-partial #'+ 5 2) 3))
  (-rpartial
   :eval (funcall (-rpartial #'- 5 2) 10))
  (-filter
   :eval (-filter (lambda (x) (> x 0)) '(-2 -1 0 1 2)))
  (--filter
   :eval (--filter (= 0 (% it 2)) '(1 2 3 4)))
  (-slice
   :eval (-slice '(1 2 3 4 5) 1)
   :eval (-slice '(1 2 3 4 5) 0 3)
   :eval (-slice '(1 2 3 4 5 6 7 8 9) 1 -1 2))
  (-distinct
   :eval (-distinct '(1 1 2 3 3)))
  (-remove
   :eval (-remove (lambda (x) (> x 0)) '(-2 -1 0 1 2)))
  (--remove
   :eval (--remove (= 0 (% it 2)) '(1 2 3 4)))
  (-reduce
   :eval (-reduce #'- '(1 2 3 4)))
  (-sum
   :eval (-sum '(1 2 3 4)))
  (-zip
   :eval (-zip '(1 2 3) '(4 5 6)))
  (-flatten
   :eval (-flatten '((1 (2 3) (((4 (5))))))))
  (--all?
   :eval (--all? (= 0 (% it 2)) '(2 4 6))))

(shortdoc-add-function
 'overlay "Overlay Properties"
 '(overlay-properties
  :noeval (overlay-properties (car (overlays-in (point-min) (point-max))))
  :eg-result-string "(display
 #(\".\" 0 1
   (face
    (:foreground \"#b4b4b4\"))))
"))

(shortdoc-add-function
 'alist "Manipulating Alists"
 '(add-to-list
   :no-eval (add-to-list 'display-buffer-alist '(height . 79))
   :eg-result ((height . 79)
               (width . 80)
               (height . 2))

   :no-eval (add-to-list 'minibuffer-frame-alist '(height . 3))
   :eg-result ((height . 3)
               (height . 79)
               (width . 80)
               (height . 2))))

(shortdoc-add-function
 'vector "Operations on Vectors"
 '(elt
   :eval (elt [foo bar baz] 0)))

(define-short-documentation-group key-bindings
  "Converting keys for various functions"
  (kbd
   :eval (kbd "C-x l")
   :eval (kbd "C-u 4 C-k"))
  (key-description
   :eval (key-description [?\C-x ?l])
   :eval (key-description (kbd "C-u 4 C-p C-k"))
   :eval (key-description (kbd "C-k") (kbd "C-u")))
  (vconcat
   :eval (vconcat (kbd "C-u 4 C-p C-k"))
   :eval (key-description [21 52 16 11])
   :eval (key-description (vconcat (kbd "C-u 4 C-p C-k"))))
  "Look up bindings."
  (lookup-key
   :eval (lookup-key (current-global-map) "\M-f")
   :eval (lookup-key (current-global-map) "")
   :eval (lookup-key (current-global-map) [6])
   :eval (lookup-key (current-global-map) (kbd "C-f"))
   :eval (lookup-key (current-global-map) (kbd "C-f") t))
  (key-binding
   :eval (key-binding [7])
   :eval (key-binding "")
   :eval (key-binding (kbd "C-x C-f"))
   :eval (key-binding [24 6])
   :eval (key-binding ""))
  (local-key-binding
   :eval (local-key-binding (vconcat (kbd "C-j")))
   :eval (local-key-binding [10]))
  (global-key-binding
   :eval (global-key-binding (kbd "C-x C-f")))
  (minor-mode-key-binding
   :eval (minor-mode-key-binding (kbd "C-c C-SPC"))
   :eg-result '(keymap (67108896 . erc-track-switch-buffer)))
  "Commands to display bindings."
  (describe-key
   :no-eval (describe-key)
   :eg-result-string "A help buffer with the corresponding command.")
  (describe-bindings
   :no-eval (describe-bindings)
   :eg-result-string "A help buffer with bindings formatted.")
  (where-is
   :no-eval (where-is 'execute-extended-command)
   :eg-result-string "execute-extended-command is remapped to counsel-M-x which is on <execute>, <menu>, M-x
nil")
  "Functions to get maps."
  (current-global-map
   :no-eval (current-global-map)
   :eg-result '(keymap …))
  (current-active-maps
   :no-eval (current-active-maps)
   :eg-result ((keymap …) (keymap …) … (keymap …)))
  "Define key in a specific map."
  (define-key
    :no-eval (define-key (current-global-map) (kbd "C-f") 'save-buffers-kill-terminal)))

(define-short-documentation-group binding-and-conditionals
  "Binding variables and conditional forms."
  (let
      :eval (let ((foo "a") (bar "b")) (concat foo bar))
      :eval (let ((foo "a") (bar nil)) (format "foo: %s bar: %s" foo bar)))
  (when
      :eval (when t "foo")
      :eval (when nil "foo"))
  (unless
      :eval (unless t "foo")
      :eval (unless nil "bar"))
  (when-let
      :eval (when-let ((foo "a") (bar "b")) (concat foo bar))
      :eval (when-let ((foo "a") (bar nil)) (format "foo: %s bar: %s" foo bar)))
  (if-let*
      :eval (if-let* ((a 4) (b (+ a 1)) (c (+ b 1))) `(,a ,b ,c))
    :eval (if-let* ((a 4) (b (+ a 1)) (c (+ b 1)) (x nil)) `(,a ,b ,c)))
  (when-let
      :eval (when-let ((foo "bar")) (format "I got a %s" foo))
      :eval (when-let ((foo "bar") (baz nil)) (format "I got a %s" foo))
      :eval (when-let ((foo "bar") (baz nil)))
      :eval (when-let ((foo "bar") (baz "4"))))
  (and-let*
      :eval (and-let* ((foo "bar")) (format "I got a %s" foo))
      :eval (and-let* ((foo "bar") (baz nil)) (format "I got a %s" foo))
      :eval (and-let* ((foo "bar") (baz nil)))
      :eval (and-let* ((foo "bar") (baz "boo")))
      :eval (and-let* ((foo "bar") (baz (concat foo "boo")))))
  (cond
   :eval (cond ((eq 'foo 'bar) (identity "baz")
                (t (identity "fallthrough")))))
  "Evaluate several forms but return one of the results."
  (progn
    :eval (progn (concat "a" "b") (concat "c" "d")))
  (prog1
    :eval (prog1 (concat "a" "b") (concat "c" "d")))
  (prog2
    :eval (prog2 (concat "a" "b") (concat "c" "d") (concat "e" "f"))))

(define-short-documentation-group advice
  "Checking advice on a function."
  (describe-function
   :no-eval (describe-function 'advice-function-member-p)
   :eg-result-string "help buffer describing `advice-function-member-p'.")
  (advice--symbol-function
   :eval (advice--symbol-function 'display-buffer))
  (advice--p
   :eval (advice--p (advice--symbol-function 'display-buffer))))

(provide 'posimacs-shortdocs)

;;; posimacs-shortdocs.el ends here
