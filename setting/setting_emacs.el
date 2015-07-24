;; 背景色と文字色
(custom-set-faces
 '(default ((t
             (:background "black" :foreground "white")
             ))))

;; カーソルの色(白)
(set-cursor-color "white")
(setq default-frame-alist
      (append (list '(cursor-color . "white")) default-frame-alist))

;; C-c gで指定行ジャンプ
(define-key mode-specific-map "g" 'goto-line)

;; Home、EndをC-a、C-eと同じ動きにする
(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;; 起動時の画面を読み込まない
(setq inhibit-startup-message t)

;; メニューバーを消す
(menu-bar-mode 0)

;; 行の表示
(line-number-mode t)
;; 列の表示
(column-number-mode t)
;; ミニバッファを縦に広げない
(setq-default resize-mini-windows nil)

;; モードラインからモード名を削除
(delete 'mode-line-modes mode-line-format)

;; カーソルのアンダーライン
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
(global-hl-line-mode t)

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

;; dired ソート
(setq dired-listing-switches "-laX")

;; diredのバッファをひとつしか作らないようにする
(defun dired-open-in-accordance-with-situation ()
    (interactive)
    (cond ((string-match "\\(?:\\.\\.?\\)"
                         (format "%s" (thing-at-point 'filename)))
           (dired-find-alternate-file))
          ((file-directory-p (dired-get-filename))
           (dired-find-alternate-file))
          (t
           (dired-find-file))))
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)

;; scratch 閉じないようにする
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))
