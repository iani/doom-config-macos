;;; postload/01_input_encoding.el -*- lexical-binding: t; -*-

(defun set-encoding-greek ()
  "Set input encoding to greek."
  (interactive)
  (set-input-method 'greek))

(defun set-encoding-ucs ()
  "Set input encoding to english (ucs)."
  (interactive)
  (set-input-method 'ucs))

(defun toggle-encoding ()
  "Toggle encoding between greek and ucs."
  (interactive)
  (if (equal current-input-method "greek")
      (set-input-method 'ucs)
    (set-input-method 'greek)))
