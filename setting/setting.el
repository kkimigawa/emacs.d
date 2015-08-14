(eval-when-compile (require 'cl))

;; package ---------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")  t)
(package-initialize)

(defvar installing-package-list
  '(
    auto-complete
    flycheck
    helm
    helm-core
    helm-ls-git
    helm-projectile
    helm-swoop
    lua-mode
    magit
    projectile
    shell-pop
    web-mode
    wgrep
    yasnippet
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))


;; wgrep -----------------------------------------------------------------------
(require 'wgrep)

;; wgrep終了時にバッファを保存
(setq wgrep-auto-save-buffer t)

;; C-x C-gでgrep-find
(global-set-key (kbd "C-x C-g") 'grep-find)
(global-set-key (kbd "C-x g") 'grep-find)


;; lua-mode --------------------------------------------------------------------
(require 'lua-mode)

(setq lua-indent-level 4)


;; web-mode --------------------------------------------------------------------
(require 'web-mode)

;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?$"      . web-mode))

;; インデント数
(defun web-mode-hook ()
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  )

(add-hook 'web-mode-hook  'web-mode-hook)

;; 色の設定
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face
   ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-html-attr-name-face
   ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face
   ((t (:foreground "#82AE46"))))
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))
)


;; helm ------------------------------------------------------------------------
(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c s") 'helm-swoop)
(global-set-key (kbd "C-c r") 'helm-resume)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-mini)

(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; helmのウインドウを今のウインドウの下に作成
(defun helm-split-window (buf)
  (split-window)
  (other-window 1)
  (switch-to-buffer buf))
(setq helm-display-function 'helm-split-window)

;; 新しいファイルを作成するときにyes/noを聞かずにすぐ作成
(setq helm-ff-newfile-prompt-p nil)

;; helm-swoopを同じウインドウに表示する
(setq helm-swoop-split-with-multiple-windows t)

;; バッファ名が短くなるので50に指定
(setq helm-buffer-max-length 50)

;; helm-miniが変な並び順になるのを防ぐ
(defadvice helm-buffers-sort-transformer (around ignore activate)
  (setq ad-return-value (ad-get-arg 0)))


;; yasnippet -------------------------------------------------------------------
(require 'yasnippet)

(setq yas-snippet-dirs '("~/.emacs.d/my-snippet"))
(yas-global-mode 1)

;; TABキーでyasnippet発動
(custom-set-variables '(yas-trigger-key "TAB"))


;; auto-complete ---------------------------------------------------------------
(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)
(setq ac-auto-start nil)

(push 'ac-source-filename ac-sources)

(global-auto-complete-mode t)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'lua-mode)

;; C-n C-pで候補選択
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; Tabキーの設定(行頭ではTAB本来のままで2文字目からはauto-completeを使用)
(defun my-auto-complete-key ()
  (interactive)
  (if (equal (current-column) 0)
    (indent-for-tab-command)
    (auto-complete)))
(define-key ac-mode-map (kbd "TAB") 'my-auto-complete-key)


;; projectile ------------------------------------------------------------------
(require 'projectile)

(setq projectile-enable-caching t)
(setq projectile-globally-ignored-directories (append '(".*") projectile-globally-ignored-directories))
(setq projectile-globally-ignored-files (append '("*.svn-base" "*.o" "*.pyc" "elc") projectile-globally-ignored-files))
(setq projectile-use-native-indexing t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)


;; shell-pop -------------------------------------------------------------------
(require 'shell-pop)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shell-pop-shell-type (quote ("ansi-term" "*shell-pop-ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-t")
 '(shell-pop-window-height 30)
 '(shell-pop-window-position "bottom"))


;; eww -------------------------------------------------------------------------
(require 'eww)
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil))

(setq eww-search-prefix "http://www.google.co.jp/search?q=")

;; キー
(define-key eww-mode-map "p" '(lambda () "" (interactive) (scroll-down 1)))
(define-key eww-mode-map "n" '(lambda () "" (interactive) (scroll-up 1)))
(define-key eww-mode-map "b" 'eww-list-bookmarks)
(define-key eww-mode-map "B" 'eww-add-bookmark)

;; 履歴をhelmで見る
(defvar eww-data)
(defun eww-current-url ()
  (if (boundp 'eww-current-url)
      eww-current-url                   ;emacs24.4
    (plist-get eww-data :url)))         ;emacs25
(defun eww-current-title ()
  (if (boundp 'eww-current-title)
      eww-current-title                 ;emacs24.4
    (plist-get eww-data :title)))

(require 'cl-lib)

(defun helm-eww-history-candidates ()
  (cl-loop with hash = (make-hash-table :test 'equal)
           for b in (buffer-list)
           when (eq (buffer-local-value 'major-mode b) 'eww-mode)
           append (with-current-buffer b
                    (clrhash hash)
                    (puthash (eww-current-url) t hash)
                    (cons
                     (cons (format "%s (%s) <%s>" (eww-current-title) (eww-current-url) b) b)
                     (cl-loop for pl in eww-history
                              unless (gethash (plist-get pl :url) hash)
                              collect
                              (prog1 (cons (format "%s (%s) <%s>" (plist-get pl :title) (plist-get pl :url) b)
                                           (cons b pl))
                                (puthash (plist-get pl :url) t hash)))))))
(defun helm-eww-history-browse (buf-hist)
  (if (bufferp buf-hist)
      (switch-to-buffer buf-hist)
    (switch-to-buffer (car buf-hist))
    (eww-save-history)
    (eww-restore-history (cdr buf-hist))))
(defvar helm-source-eww-history
  '((name . "eww history")
    (candidates . helm-eww-history-candidates)
    (migemo)
    (action . helm-eww-history-browse)))
(defvaralias 'anything-c-source-eww-history 'helm-source-eww-history)
(defun helm-eww-history ()
  (interactive)
  (helm :sources 'helm-source-eww-history
        :buffer "*helm eww*"))

(define-key eww-mode-map (kbd "H") 'helm-eww-history)


;; flycheck --------------------------------------------------------------------
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mod)
