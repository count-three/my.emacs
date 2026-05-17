(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
;(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(package-initialize)

(setq python-shell-interpreter "python")
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))


;; バックアップを一箇所に集約
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))

;; 自動保存ファイル(#xxx#)もまとめたい場合
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-saves/" t)))

;; ------------------------
;; Python interpreter for pyvenv
;; ------------------------
;(setq pyvenv-default-python
;      "~/AppData/Local/Programs/Python/Python312/python.exe")
;(setq pyvenv-virtualenvwrapper-python
;      "~/AppData/Local/Programs/Python/Python312/python.exe")

(let ((python-path
       (or (executable-find "python")
           (expand-file-name "~/AppData/Local/Programs/Python/Python312/python.exe"))))
  (setq pyvenv-default-python python-path)
  (setq pyvenv-virtualenvwrapper-python python-path))

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode 1)
  ;; pyvenv-create もこの Python を使う
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(arduino-mode magit pyvenv)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (setenv "PATH" (concat pyvenv-virtual-env "/Scripts;" (getenv "PATH")))
            (setq exec-path (cons (concat pyvenv-virtual-env "/Scripts") exec-path))))

;;;(add-hook 'pyvenv-post-deactivate-hooks
;;;          (lambda ()
;;;            (setenv "PATH" "C:/Windows/System32")
;;;            (setq exec-path (delete (concat pyvenv-virtual-env "/Scripts") exec-path))))


;; ------------------------------------------------------------
;; Package / use-package bootstrap
;; ------------------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ------------------------------------------------------------
;; PATH backup for pyvenv
;; ------------------------------------------------------------
(defvar my/original-path (getenv "PATH"))
(defvar my/original-exec-path exec-path)

(add-hook 'pyvenv-post-deactivate-hooks
          (lambda ()
            (setenv "PATH" my/original-path)
            (setq exec-path my/original-exec-path)))

;; ------------------------------------------------------------
;; Git: Magit
;; ------------------------------------------------------------
(use-package magit
  :bind (("C-x g" . magit-status)))

;; ------------------------------------------------------------
;; Arduino
;; ------------------------------------------------------------
(use-package arduino-mode
  :mode "\\.ino\\'")

(defvar my/arduino-fqbn "arduino:avr:uno")
(defvar my/arduino-port "COM9")

(defun my/arduino-compile ()
  "Compile current Arduino sketch using arduino-cli."
  (interactive)
  (compile
   (format "arduino-cli compile --fqbn %s ."
           my/arduino-fqbn)))

(defun my/arduino-upload ()
  "Upload current Arduino sketch using arduino-cli."
  (interactive)
  (compile
   (format "arduino-cli upload -p %s --fqbn %s ."
           my/arduino-port
           my/arduino-fqbn)))

(defun my/arduino-monitor ()
  "Open Arduino serial monitor using arduino-cli."
  (interactive)
  (compile
   (format "arduino-cli monitor -p %s -c baudrate=9600"
           my/arduino-port)))

(global-set-key (kbd "C-c a c") 'my/arduino-compile)
(global-set-key (kbd "C-c a u") 'my/arduino-upload)
(global-set-key (kbd "C-c a m") 'my/arduino-monitor)

;; ------------------------------------------------------------
;; Eshell aliases
;; ------------------------------------------------------------
(defun my/eshell-setup ()
  (eshell/alias "ac" "arduino-cli compile --fqbn arduino:avr:uno .")
  (eshell/alias "au" "arduino-cli upload -p COM9 --fqbn arduino:avr:uno .")
  (eshell/alias "am" "arduino-cli monitor -p COM9 -c baudrate=9600")
  (eshell/alias "gs" "git status")
  (eshell/alias "gd" "git diff")
  (eshell/alias "ga" "git add $*")
  (eshell/alias "gc" "git commit -m $*")
  (eshell/alias "codex" "codex $*"))

(add-hook 'eshell-first-time-mode-hook 'my/eshell-setup)

;; ------------------------------------------------------------
;; Codex helper
;; ------------------------------------------------------------
(defun my/codex ()
  "Run Codex CLI in eshell."
  (interactive)
  (eshell)
  (insert "codex")
  (eshell-send-input))

(global-set-key (kbd "C-c x") 'my/codex)
