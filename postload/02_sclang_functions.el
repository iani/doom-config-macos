;;; postload/01_sclang.el -*- lexical-binding: t; -*-

(require 'sclang)

; (add-hook 'sclang-mode-hook 'sclang-extensions-mode)

;; start jack
(defun sclang-start-jack ()
  "Start jackd."
  (interactive)
  (async-shell-command " jackd -r -d alsa -r 44100"))

(defun sclang-osc-trace-on ()
  "Turn on OSCFunc trace"
  (interactive)
  (sclang-eval-string "OSCFunc.trace(true)"))

(defun sclang-osc-trace-off ()
  "Turn off OSCFunc trace"
  (interactive)
  (sclang-eval-string "OSCFunc.trace(false)"))

(defun sclang-scundelify ()
  "Convert //: snippet blocks to regular style () sc blocks in document."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n//:" nil t)
      (replace-match "\n\)\n//:")
      (goto-char (line-end-position 2))
      (goto-char (line-beginning-position 1))
      (insert "\(\n")
      (goto-char (line-beginning-position 1))
      (delete-blank-lines))
    (goto-char (point-min))
    (re-search-forward "\)\n//:" nil t)
    (replace-match "\n://:")))

(defun sclang-server-plot-tree ()
  "Open plotTree for default server."
  (interactive)
  (sclang-eval-string "Server.default.plotTree"))

(defun sclang-server-meter ()
  "Open i/o meter for default server."
  (interactive)
  (sclang-eval-string "Server.default.meter"))

(defun sclang-server-scope (&optional chans)
  "Open scope for default server."
  (interactive "nHow many channels? ")
  (sclang-eval-string (format "Server.default.scope(%s, rate: \\audio)" chans))
  ;; (sclang-eval-string "Server.default.scope")
  )

(defun sclang-server-control-scope (&optional chans)
  "Open scope for default server at control rate."
  (interactive "nHow many channels? ")
  (message "Making control scope with %s channels" chans)
  (sclang-eval-string (format "Server.default.scope(%s, rate: \\control)" chans))
  )

(defun sclang-server-freqscope ()
  "Open frequency scope for default server."
  (interactive)
  (sclang-eval-string "Server.default.freqscope"))

(defun dired-play-soundfile-in-sclang ()
  "Play current file under cursor from dired in sclang, from disk."
  (interactive)
  (message (dired-get-file-for-visit))
  (sclang-play-soundfile (dired-get-file-for-visit)))

(defun sclang-play-soundfile (path)
  (sclang-eval-string
   (concat "\"" path "\".playAudioFile")))

;; ;; (define-key dired-mode-map (kbd "C-c C-p") 'dired-play-soundfile-in-sclang)

(defun sclang-stop-soundfile ()
  "Stop playing soundfile player."
  (interactive)
  (sclang-eval-string "\\diskplayback.stop"))

;; ;; (define-key dired-mode-map (kbd "C-c C-s") 'sclang-stop-soundfile)

(defun sclang-insert-+> ()
  "Insert +>."
  (interactive)
  (insert "+> \\"))

 (defun sclang-insert-comment-with-date ()
  "Insert /* datestamp nl */ "
  (interactive)
  (insert "/* ")
  (insert (format-time-string "%e %b %Y %H:%M"))
  (insert "\n\n*/")
  (backward-char 3)
  )

(defun sclang-insert-snippet-with-date ()
  "Insert //: datestamp nl /* */ "
  (interactive)
  (insert "//: ")
  (insert (format-time-string "%e %b %Y %H:%M"))

  (insert "\n/*\n\n*/")
  (previous-line 2))

(defun sclang-extensions-gui ()
  "Open gui for browsing user extensions classes and methods.
    Type return on a selected item to open the file where it is defined."
  (interactive)
  (sclang-eval-string "Class.extensionsGui;"))

(defun sclang-reset-server-options ()
  "Reset server options from scripts of sc-hacks.
Run all scd files found in ~/sc-hacks-config/serveroptions
or its subdirectories."
  (interactive)
  ;; TODO : implement this ...
  (sclang-eval-string "Hacks.serverConfig")
  )
