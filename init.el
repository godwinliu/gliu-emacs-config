;; emacs configuration

;; General configuration
(column-number-mode)

;; [2017-Mar-15 GYL] Handy keyboard macro for commenting code
(defun current-date ()
  "get today's date as string"
  (shell-command-to-string "echo -n $(date +%Y-%b-%d)"))
(defun insert-dated-comment-tag ()
  "Insert a comment tag of the form [date-GYL(my initials)]"
  (interactive)
  (insert (concat "[" (current-date) " GYL]")))
(global-set-key (kbd "C-c c") 'insert-dated-comment-tag)

;; [2017-Mar-15 GYL] configuration of linum-mode
(setq linum-format "%d ")

;; [2019-Oct-06 GYL] need to set up emacs to default to dark background
(setq frame-background-mode 'dark)

;; start package manager
(require 'package)
(package-initialize)

;; add marmalade repo [2015-apr-10 GYL]
;;   this may not be needed later when package.el and knowledge
;;   on how to package properly for it is more widespread.  For now
;;   marmalade is an interim repo solution which enables access to
;;   a much broader set of tools than available in the vanilla elpa repo
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; [2017-Mar-15 GYL] add a hook for line numbering in ruby-mode
(add-hook 'ruby-mode-hook' (lambda () (linum-mode 1)))

;; [2017-Mar-15 GYL] add recognition of Gemfiles, etc for ruby
(add-to-list 'auto-mode-alist
	     '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; [2019-Oct-06 GYL] this didn't load in GCP - so attempting to add subdir to the load path
(add-to-list 'load-path "~/.emacs.d/web-mode/")

;; [2017-Mar-15 GYL] add support for web-mode - can't seem to get this to work at the moment
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (linum-mode 1)
  )
(add-hook 'web-mode-hook 'my-web-mode-hook)

