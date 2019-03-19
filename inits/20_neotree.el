(require 'neotree)

;; アイコンを使用しないモード
(setq neo-theme 'ascii)

;; カレントディレクトリを表示
(setq neo-smart-open t)

(defun neo-open-file-hide (full-path &optional arg)
  "Open a file node and hides tree."
  (neo-global--select-mru-window arg)
  (find-file full-path)
  (neotree-hide))

(defun neotree-enter-hide (&optional arg)
  "Enters file and hides neotree directly"
  (interactive "P")
  (neo-buffer--execute arg 'neo-open-file-hide 'neo-open-dir))

;; 選択後にneotreeを閉じる
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key neotree-mode-map (kbd "RET") 'neotree-enter-hide)))

(global-set-key "\C-o" 'neotree-toggle)
