(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

(leaf common-settings
  :init
  ;; 起動時の画面を読み込まない
  (setq inhibit-startup-message t)
  ;; テーマ
  (load-theme 'wombat t)
  ;; メニューバーを消す
  (menu-bar-mode 0)
  ;; 行の表示
  (line-number-mode t)
  ;; 列の表示
  (column-number-mode t)
  ;; ツールバーを消す
  (tool-bar-mode 0)
  ;; スクロールバーを非表示
  (scroll-bar-mode 0)
  ;; モードラインからモード名を削除
  (delete 'mode-line-modes mode-line-format)
  ;; 文字コードはutf-8を優先させる
  (set-default-coding-systems 'utf-8-unix)
  (set-keyboard-coding-system 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)
  (set-buffer-file-coding-system 'utf-8-unix)
  (prefer-coding-system 'utf-8-unix)
  ;; 大文字、小文字変換を有効にする
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  ;; 画面端で折り返さない
  (auto-fill-mode 0)
  (setq-default truncate-lines t)
  (setq-default truncate-partial-width-windows t)
  ;; 改行コード表示
  (setq eol-mnemonic-dos "(CRLF)")
  (setq eol-mnemonic-mac "(CR)")
  (setq eol-mnemonic-unix "(LF)")
  ;; yes or noを y or nに
  (setopt use-short-answers t)
  ;; スクロールを1行ずつずらす
  (setq scroll-conservatively 35 scroll-margin 0 scroll-step 1)
  ;; バックアップファイルを作成しない
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq auto-save-list-file-prefix nil)
  (setq create-lockfiles nil))

(leaf common-key-binding
  :bind
  (("C-h"     . delete-backward-char)
   ("M-h"     . backward-kill-word)
   ("M-n"     . (lambda () (interactive) (scroll-up 1)))
   ("M-p"     . (lambda () (interactive) (scroll-down 1)))
   ("C-x g"   . magit-status-quick)
   ("C-x b"   . consult-buffer)
   ("C-x C-b" . consult-buffer)
   ("C-c s"   . consult-line)
   ("C-c i"   . consult-imenu)
   ("C-c l"   . consult-goto-line)
   ("C-c f"   . consult-ls-git-ls-files)
   ("C-c r"   . consult-recent-file)
   ("C-c g"   . consult-git-grep)
   ("C-c d"   . magit-diff-buffer-file)))

(leaf leaf-convert
  :emacs>= 26.1
  :ensure t
  :after leaf leaf-keywords ppp)

(leaf recentf
  :config
  (recentf-mode +1)
  (setq recentf-max-saved-items 100))

(leaf orderless
  :emacs>= 27.1
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
        completion-category-overrides nil)
  :after compat)

(leaf vertico
  :emacs>= 27.1
  :ensure t
  :bind
  ((:vertico-map
    ("C-l"     . vertico-directory-up)
    ("C-c C-o" . embark-export)))
  :after compat)

(leaf vertico-settings
  :init
  (vertico-mode))

(leaf consult
  :emacs>= 27.1
  :ensure t
  :config
  (setq consult-preview-partial-size 0)
  :after compat)

(leaf consult-ls-git
  :emacs>= 27.1
  :ensure t
  :after consult)

(leaf embark-consult
  :emacs>= 27.1
  :ensure t
  :after compat embark consult)

(leaf company
  :emacs>= 25.1
  :ensure t
  :config
  (global-company-mode +1)
  ;; 自動補完オフ
  (custom-set-variables '(company-idle-delay nil))
  ;; 先頭位置以外のTABキーで補完
  (defun my-company-complete ()
    (interactive)
    (if (equal (current-column) 0)
	(indent-for-tab-command)
      (company-complete)))
  (global-set-key (kbd "TAB") 'my-company-complete))

(leaf magit
  :emacs>= 26.1
  :ensure t
  :config
  ;; コミット時に変更点を表示しない(変更点が多いと重くなる)
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  ;; 同じウインドウでmagitを開く
  ;; https://idiomdrottning.org/magit-transients
  (defun magit-display-buffer-same-window (buffer)
    "Display BUFFER in the selected window like God intended."
    (display-buffer
     buffer '(display-buffer-same-window)))
  (setq magit-display-buffer-function 'magit-display-buffer-same-window)
  (setq magit-popup-display-buffer-action '((display-buffer-same-window)))
  :after compat git-commit magit-section with-editor)

(leaf markdown-mode
  :emacs>= 27.1
  :ensure t)

(leaf dart-mode
  :emacs>= 27.1
  :ensure t)

(leaf php-mode
  :emacs>= 26.1
  :ensure t)

(provide 'init)
