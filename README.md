# refac-el

simple refactoring tools for editing common lisp with emacs

## Functions
### refac-extract-defun
extracts a region of code and turns it into a function
#### before
```lisp
(defun foo (x y)
  (print (+ x y)) 
  (print (* x y 2)))
```
#### after
```lisp
(defun bar (y x)
  (* x y 2))
      
(defun foo (x y)
  (print (+ x y)) 
  (print (bar y x)))
```
### refac-extract-let
extracts the sexp at the cursor and creates a 'let' call to represent it
#### before
```lisp
(defun foo (x y)
  (print (+ x y)) 
  (print (* x y 2)))
```
#### after
```lisp
(defun foo (x y)
  (let ((bar (+ x y)))
    (print bar))
  (print (* x y 2)))
```
