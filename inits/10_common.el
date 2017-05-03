;; テーマ
(load-theme 'wombat t)

;; C-c gで指定行ジャンプ
(define-key mode-specific-map "l" 'goto-line)

;; Home、EndをC-a、C-eと同じ動きにする
(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;; 起動時の画面を読み込まない
(setq inhibit-startup-message t)

;; メニューバーを消す
(menu-bar-mode 0)

;; ツールバーを消す
(tool-bar-mode 0)

;; スクロールバーを非表示
(scroll-bar-mode 0)

;; 行をハイライト
(global-hl-line-mode t)
(set-face-background 'hl-line "darkslategray")
(set-face-attribute hl-line-face nil :underline nil)

;; 行の表示
(line-number-mode t)
;; 列の表示
(column-number-mode t)
;; ミニバッファを縦に広げない
(setq-default resize-mini-windows nil)

;; M-n M-pでカーソル移動せずにスクロール
(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))

;; モードラインからモード名を削除
(delete 'mode-line-modes mode-line-format)

;; Tabをスペースに変える
(setq-default indent-tabs-mode nil)
;; タブ幅
(custom-set-variables '(tab-width 4))

;; 対応するカッコをハイライト表示する
(show-paren-mode t)

;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
;; Linux用
(custom-set-variables '(read-file-name-completion-ignore-case t))

;; 同名のファイルを開いたとき親ディレクトリを表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 新規ファイル作成時に確認しない
(setq ffap-newfile-prompt t)

;; スクロールを1行ずつずらす
(setq scroll-conservatively 35 scroll-margin 0 scroll-step 1)

;; バックアップファイルを作成しない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; 言語を日本語にする
(set-language-environment 'Japanese)

;; 文字コードはutf-8を優先させる
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; ビープ音を消す
(setq visible-bell t)
;; 消した際に発生する画面のフラッシュも消す
(setq ring-bell-function 'ignore)

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
(fset 'yes-or-no-p 'y-or-n-p)

;; 行末の空白を強調
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

(defun my/disable-trailing-mode-hook ()
  "Disable show tail whitespace."
  (setq show-trailing-whitespace nil))

(defvar my/disable-trailing-modes
  '(comint-mode
    eshell-mode
    eww-mode
    term-mode
    twittering-mode))

(mapc
 (lambda (mode)
   (add-hook (intern (concat (symbol-name mode) "-hook"))
             'my/disable-trailing-mode-hook))
 my/disable-trailing-modes)

;; C-hで削除
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; 縦に分割しないようにする
(setq split-height-threshold nil)
