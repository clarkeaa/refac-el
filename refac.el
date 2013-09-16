;;; refac.el
;;; Aaron Clarke 2013
;;;
;;;

(defun refac-symbols-in-code (code-string)
  "given a string of code it will extract all the symbols"
  (let ((code (car (read-from-string code-string)))
        (answer nil))
    (flet ((process (loc)
                    (if (sequencep loc)
                        (dolist (item (cdr loc))
                          (process item))
                      (pushnew loc answer))))
      (process code)
      (remove-if-not 'symbolp answer))))

(defun refac-extract-defun (name)
  "extracts a region of code and turns it into a function"
  (interactive "Mfunction name:")
  (kill-region (mark) (point))
  (let* ((syms (refac-symbols-in-code (car kill-ring)))
         (sym-strings (mapcar 'symbol-name syms))
         (args-list (reduce (lambda (x y) (concat x " " y)) sym-strings)))
    (insert "(" name " " args-list ")")
    (save-excursion 
      (beginning-of-defun)
      (insert "(defun " name " (")
        (insert args-list)
        (insert ")\n  ")
        (yank)
        (insert ")\n\n"))))

(defun refac-extract-let (name)
  "extracts the sexp at the cursor and creates a 'let' call to represent it"
  (interactive "Mvar name:")
  (kill-sexp)
  (save-excursion
    (insert name)
    (save-excursion 
      (end-of-line)
      (insert ")"))
    (search-backward "(")
    (insert "(let ((" name " ")
    (yank)
    (insert "))\n")
    (indent-according-to-mode)))


