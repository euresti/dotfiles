;; Make sure this path is in PATH otherwise it won't work on OSX.
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; No gross stuff
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; turn on font-lock mode and set colors.
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq-default show-trailing-whitespace t)
(setq column-number-mode t)
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "green")

;; enable visual feedback on selections
(setq transient-mark-mode t)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80)

;; set tab stops to 4
(setq default-tab-width 4)

;; No VC please
(setq vc-handled-backends nil)

;;
;; Delete takes out the selected region
;;
(delete-selection-mode t)

(global-set-key "\M-g" 'goto-line)

;; switch to the next window
(global-set-key [M-left] '(lambda () (interactive) (other-window -1)))
(global-set-key [M-right] '(lambda () (interactive) (other-window 1)))

;; C-tab swaps buffers
(global-set-key [(control tab)] 'mode-line-other-buffer)

(global-set-key '[C-backspace] 'backward-kill-word)

;; Function keys
(global-set-key '[f8] 'bury-buffer)

;; Disable stupid warnings
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; Always use utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(epy-setup-checker "pyflakes %f")
