;;; postload/03_sclang_keybindings.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-c >") 'sclang-show-post-buffer)
(global-set-key (kbd "C-c M-w") 'sclang-switch-to-workspace)

(eval-after-load 'sclang
    (progn
      ;; these are disabled by sclang-bindings:
      ;; (define-key sclang-mode-map (kbd "C-c C-p t") 'sclang-server-plot-tree)
      ;; (define-key sclang-mode-map (kbd "C-c C-p m") 'sclang-server-meter)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; sc-hacks gui commands:
      (define-key sclang-mode-map (kbd "C-h g s") 'sclang-startupfiles-gui)
      (define-key sclang-mode-map (kbd "C-h g a") 'sclang-audiofiles-gui)
      (define-key sclang-mode-map (kbd "C-h g p") 'sclang-players-gui)
      (define-key sclang-mode-map (kbd "C-h g e") 'sclang-extensions-gui)
      (define-key sclang-mode-map (kbd "C-h g n") 'sclang-nevent-gui)
      (define-key sclang-mode-map (kbd "C-S-s") 'hydra-snippets/body)
      (define-key sclang-mode-map (kbd "C-S-l") 'hydra-sclang/body)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Server state visualisation utilities
      ;; TODO: Check and re-assign these commands for consistency with
      ;; default sclang commands C-c C-p x:
      (define-key sclang-mode-map (kbd "C-c P p") 'sclang-server-plot-tree)
      (define-key sclang-mode-map (kbd "C-c P m") 'sclang-server-meter)
      (define-key sclang-mode-map (kbd "C-c P s") 'sclang-server-scope)
      (define-key sclang-mode-map (kbd "C-c P f") 'sclang-server-freqscope)
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       ;;;;;;;;;;;;;;;;;;       snippet commands      ;;;;;;;;;;;;;;;;;;
      ;; eval current snippet               M-C-x
      ;; goto next snippet                  M-n
      ;; goto previous snippet              M-p
      ;; eval previous snippet              M-P
      ;; eval next snippet                  M-N
      ;; duplicate current snippet          M-D
      ;; copy current snippet               M-C
      ;; select region of current snippet   M-R
      ;; cut current snippet                M-T
      ;; transpose snippet down             C-M-N
      ;; transpose snippet up               C-M-P

      (define-key sclang-mode-map (kbd "M-X") 'sclang-eval-current-snippet)
      (define-key sclang-mode-map (kbd "C-<return>") 'sclang-eval-current-snippet)
      (define-key sclang-mode-map (kbd "C-M-x") 'sclang-eval-current-snippet)
      (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
      (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
      (define-key sclang-mode-map (kbd "M-N") 'sclang-eval-next-snippet)
      (define-key sclang-mode-map (kbd "M-P") 'sclang-eval-previous-snippet)
      ;; Shadowed by evil-multiple cursors:
      (define-key sclang-mode-map (kbd "M-D") 'sclang-duplicate-current-snippet)
      ;; alternative for M-D:
      (define-key sclang-mode-map (kbd "M-J") 'sclang-duplicate-current-snippet)
      (define-key sclang-mode-map (kbd "M-C") 'sclang-copy-current-snippet)
      (define-key sclang-mode-map (kbd "M-R") 'sclang-region-select-current-snippet)
      (define-key sclang-mode-map (kbd "M-T") 'sclang-cut-current-snippet)
      (define-key sclang-mode-map (kbd "C-M-N") 'sclang-transpose-snippet-down)
      (define-key sclang-mode-map (kbd "C-M-P") 'sclang-transpose-snippet-up)

      (define-key sclang-mode-map (kbd "C-M-S-t")
        'sclang-eval-current-snippet-with-timer)

      ;; (define-key sclang-mode-map (kbd "M-C-.") 'sclang-duplicate-current-snippet)
      ;; (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
      ;; (define-key sclang-mode-map (kbd "M-N") 'sclang-eval-next-snippet)
      ;; (define-key sclang-mode-map (kbd "M-C-S-n") 'sclang-move-snippet-down)
      ;; (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
      ;; (define-key sclang-mode-map (kbd "M-P") 'sclang-eval-previous-snippet)
      ;; (define-key sclang-mode-map (kbd "M-C-S-p") 'sclang-move-snippet-up)X

      (define-key sclang-mode-map (kbd "H-=") 'sclang-insert-snippet-separator+)
      (define-key sclang-mode-map (kbd "H-8") 'sclang-insert-snippet-separator*)
      (define-key sclang-mode-map (kbd "C-M-=") 'sclang-insert-+>)
      (define-key sclang-mode-map (kbd "C-M-;") 'sclang-insert-comment-with-date)

       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Miscellaneous
      (define-key sclang-mode-map (kbd "C-S-c c") 'sclang-clear-post-buffer)
      (define-key sclang-mode-map (kbd "C-M-=") 'sclang-insert-+>)
      (define-key sclang-mode-map (kbd "C-\"") 'sclang-insert-comment-with-date)
      (define-key sclang-mode-map (kbd "C-M-\"") 'sclang-insert-snippet-with-date)
      ;; under development:
      ;; : 8 Aug 2021 11:40

      ;; (define-key sclang-mode-map (kbd "C-c C-v") 'sclang-toggle-snippet-routine)

      ;; (key-chord-define sclang-mode-map "11" 'sclang-2-windows)
      ;; (key-chord-define sclang-mode-map "''" 'sclang-plusgt)
      ;; (key-chord-define sclang-mode-map ";;" 'sclang-ltplus)
      ;; (key-chord-define sclang-mode-map "\\\\" 'sclang-xgt)
      ))
