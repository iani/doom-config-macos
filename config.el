;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Iosevka SS04" :size 24 :weight 'light
;;                            )
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; this is not needed for latex. see also: https://www.emacswiki.org/emacs/ExecPath
;; (setq exec-path (cons "/Library/TeX/texbin" exec-path))

(setenv
 "PATH"
 (concat
  "/Library/TeX/texbin" ":" ;; latex
  "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS" ;; sclang
  ":"
  "/Applications/SuperCollider/SuperCollider.app/Contents/Resources" ;; scsynth
  ":"
  (getenv "PATH")))

(setq exec-path
      (append
       exec-path
       '(
         "/Library/TeX/texbin" ;; latex
         "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS" ;; sclang
         "/Applications/SuperCollider/SuperCollider.app/Contents/Resources" ;; scsynth
         )))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; extra package configs
(use-package! projectile
  :init
  (setq projectile-switch-project-action #'projectile-commander))

;; (use-package! counsel-projectile)
;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :init
;;   (setq
;;          org-super-agenda-group-property-name
;;          "ProjectId"
;;          org-super-agenda-groups
;;          '(
;;            (:auto-group t);
;;            (:name "Today" :time-grid t :scheduled today)
;;            (:name "Due today" :deadline today)
;;            (:name "Important" :priority "A")
;;            (:name "Overdue" :deadline past)
;;            (:name "Due soon" :deadline future)))
;;   :config
;;   (org-super-agenda-mode))

(use-package! undo-tree
  :config
  (global-undo-tree-mode))

;; Special work directory configs

(setq org-roam-directory "~/roam")
(setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
(setq org-agenda-files '("~/org" "~/roam" "~/roam/daily"))
(setq org-agenda-include-diary t)
(setq diary-file "~/roam/etc/diary")
;; (map!
;;  ;mode dired
;;  :desc "create symbolic link" "S" #'dired-do-symlink
;;  )

(map! :leader
      :desc "org-mark-ring-goto" "m g o" #'org-mark-ring-goto
      :desc "calendar" "o c" #'calendar
      :desc "calendar" "o C" #'calc
      ; :desc "find folder in project" "p F" #'projectile-find-dir
      :desc "org mark element" "o m" #'org-mark-element
      ;; (:prefix-map ("e" . "input encoding")
       :desc "toggle input encoding method" "e" #'toggle-encoding
       ;; :desc "toggle" "t" #'toggle-encoding
       ;; :desc "english ucs" "e" #'set-encoding-ucs)
       (:prefix-map ("v" . "various iani")
       :desc "projectile commander" "p" #'projectile-use-commander
       :desc "undo tree" "t" #'undo-tree-mode)
       (:prefix-map ("k" . "scsynth")
       :desc "boot server" "b" #'sclang-server-boot
       :desc "start jack" "j" #'sclang-start-jack
       :desc "server meter" "m" #'sclang-meter
       :desc "server tree" "t" #'sclang-server-plot-tree
       :desc "record" "r" #'sclang-server-record
       :desc "stop recording" "R" #'sclang-server-stop-recording
       :desc "stop recording" "f" #'sclang-server-stop-recording
       :desc "server scope audio" "s a" #'sclang-scope-audio
       :desc "server scope control" "s c" #'sclang-scope-audio
       :desc "quit server" "q" #'sclang-server-quit
       :desc "reset server options" "o" #'sclang-reset-server-options)
      (:prefix-map ("j" . "SuperCollider")
       (:prefix ("l" . "sclang")
       :desc "start sclang" "s" #'sclang-start
       :desc "stop sclang" "q" #'sclang-stop
       :desc "recompile library" "l" #'sclang-recompile
       :desc "show post buffer" "p" #'sclang-show-post-buffer
       :desc "clear post buffer" "c" #'sclang-clear-post-buffer
       :desc "switch to workspace" "w" #'sclang-switch-to-workspace
       )
       (:prefix ("e" . "eval")
       :desc "eval line" "l" #'sclang-eval-line
       :desc "eval snippet" "." #'sclang-eval-current-snippet
       )
       (:prefix ("o" . "OSC")
       :desc "start tracing" "s" #'sclang-osc-trace-on
       :desc "quit tracing" "q" #'sclang-osc-trace-off
       )
       (:prefix ("j" . "server")
       :desc "boot server" "b" #'sclang-server-boot
       :desc "start jack" "j" #'sclang-start-jack
       :desc "server meter" "m" #'sclang-meter
       :desc "server tree" "t" #'sclang-server-plot-tree
       :desc "record" "r" #'sclang-server-record
       :desc "stop recording" "R" #'sclang-server-stop-recording
       (:prefix ("s" . "scope")
       :desc "server scope audio" "s a" #'sclang-scope-audio
       :desc "server scope control" "s c" #'sclang-scope-audio
       )
       :desc "quit server" "q" #'sclang-server-quit
       :desc "reset server options" "o" #'sclang-reset-server-options)
       ;; :desc "run server config scripts" "c" #'sclang-server-config
       :desc "browse builtin classes" "B" #'sclang-browse-definitions
       :desc "browse user extension classes" "E" #'sclang-extensions-gui)
      (:prefix-map ("l" . "latex")
       (:prefix ("b" . "buffer")
        ;;; TODO : replace org-journal-new-entry with real commands
        :desc "pdflatex -> pdf" "p" #'pdflatex-compile-buffer
        :desc "xelatex -> pdf" "x" #'xelatex-compile-buffer
        :desc "lualatex -> pdf" "l" #'lualatex-compile-buffer
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search)
       (:prefix ("s" . "subtree")
        :desc "pdflatex -> pdf" "p" #'org-journal-new-entry
        :desc "xelatex -> pdf" "x" #'org-journal-new-entry
        :desc "lualatex -> pdf" "l" #'org-journal-new-entry
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search))
      (:prefix ("b" . "buffer")
        :desc "pdflatex -> pdf" "p" #'org-journal-new-entry
        :desc "xelatex -> pdf" "x" #'org-journal-new-entry
        :desc "lualatex -> pdf" "l" #'org-journal-new-entry
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search))
