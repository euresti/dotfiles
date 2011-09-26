;; Use my super awesome .emacs.d
(add-to-list 'load-path "~/.emacs.d")

;; turn on font-lock mode with lots of colors.
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; set tab stops to 4
(setq default-tab-width 4)

;;
;; Delete takes out the selected region
;;
(delete-selection-mode t)
(menu-bar-mode -1)

(global-set-key "\M-g" 'goto-line)

;; switch to the next window
(global-set-key [M-left] '(lambda () (interactive) (other-window -1)))
(global-set-key [M-right] '(lambda () (interactive) (other-window 1)))
(global-set-key (quote [27 right]) '(lambda () (interactive) (other-window 1)))
(global-set-key (quote [27 left]) '(lambda () (interactive) (other-window -1)))

;; C-tab swaps buffers
(global-set-key [(control tab)] 'mode-line-other-buffer)

(global-set-key '[C-backspace] 'backward-kill-word)

;cscope customizations
(autoload 'cscope-find-functions-calling-this-function "xcscope" "cscope-find" t)
(autoload 'cscope-find-this-symbol "xcscope" "find this symbol" t)
(autoload 'cscope-find-this-text-string "xcscope" "find text string" t)

(global-set-key [f2] 'cscope-find-functions-calling-this-function)
(global-set-key [f3] 'cscope-find-this-symbol)

;etags customizations
(global-set-key [f4] 'find-tag)


(global-set-key '[f8] 'bury-buffer)

;(require 'highlight-beyond-fill-column)


(setq inhibit-startup-message t)
(setq-default show-trailing-whitespace t)

(defun axels-mail-mode-hook ()
  (turn-on-auto-fill)  ;;; Auto-Fill is necessary for mails
  (turn-on-font-lock)  ;;; Font-Lock is always cool *g*
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*")
	                   ;;; Kills quoted sigs.
  (not-modified)       ;;; We haven't changed the buffer, haven't we? *g*
  (mail-text)          ;;; Jumps to the beginning of the mail text
  (setq make-backup-files nil)
               ;;; No backups necessary.
  )

(or (assoc "mutt-" auto-mode-alist)
    (setq auto-mode-alist (cons '("mutt-" . mail-mode) auto-mode-alist)))
(add-hook 'mail-mode-hook 'axels-mail-mode-hook)

(defun insert-date ()
  "Insert a nicely formatted date string."
  (interactive)
  (insert (format-time-string "%m/%d")))




(defun general-c-mode()
  (c-set-style "stroustrup")
  (setq c-basic-offset 4)
  (c-set-offset 'inclass '++)
  (c-set-offset 'innamespace '0)
  (c-set-offset 'access-label '-)
  (c-set-offset 'case-label '+)
  (c-set-offset 'topmost-intro '0)
  (c-set-offset 'inline-open '+)
  (c-set-offset 'member-init-intro '+)
  ;;(turn-on-auto-fill)
  ;;(setq auto-fill-function 'c-do-auto-fill)
  (setq fill-column 80)
  ;;(auto-fill-mode t)
  (if (save-excursion (search-forward  "\t" nil t))
      ;; old broadware code with tabs in it.  Keep using tabs.
      (progn
        (setq indent-tabs-mode t)
        (tab-mode))
    ;; new code uses spaces.  And highlight at 80.
    (progn (highlight-beyond-fill-column)
           (highlight-tab-mode)))
)


(add-hook 'c-mode-hook 'general-c-mode)
(add-hook 'c++-mode-hook 'general-c-mode)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((indent-tabs-mode . 1))))
 '(which-func-modes (quote (emacs-lisp-mode c-mode c++-mode perl-mode cperl-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode python-mode)))
 '(which-function-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(highlight-beyond-fill-column-face ((t (:background "red")))))


(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
(setq-default fill-column 80)



(defface highlight-tab-face '((t (:background "pale green"))) "Used for tabs" )
(defvar  highlight-tab-face 'highlight-tab-face)

(defface highlight-space-face '((t (:background "red"))) "Used for spaces" )
(defvar  highlight-space-face 'highlight-space-face)

(defvar  highlight-tab-mode nil)
(defvar  highlight-tab-alist '(("\t"  0 highlight-tab-face append)))

(defvar  highlight-space-alist '(("^\t* +"   0 highlight-space-face append)))

(defun highlight-tab-mode () (interactive)
   "Highlights TABs."
   ;;(cond ((setq highlight-tab-mode (not highlight-tab-mode))
   (progn
     (font-lock-add-keywords nil highlight-tab-alist)
     (message "Enabled show tabs")
     (font-lock-fontify-buffer)
))

(defun untabify-buffer ()
  "Untabify current buffer"
  (interactive)
  (untabify (point-min) (point-max)))


(define-minor-mode tab-mode
  "Toggle Old Broadware mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Tab"
)

(defun progmodes-write-hooks ()
  "Hooks which run on file write for programming modes"
  (message "hook running")
  (if (not tab-mode)
      (progn
        (set-buffer-file-coding-system 'utf-8-unix)
        (untabify-buffer)
        (delete-trailing-whitespace))))


(defun progmodes-hooks ()
  "Hooks for programming modes"
  (add-hook 'before-save-hook 'progmodes-write-hooks nil t))

(add-hook 'c-mode-hook 'progmodes-hooks)
(add-hook 'c++-mode-hook 'progmodes-hooks)


(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "green")

(tool-bar-mode -1)
(scroll-bar-mode -1)



