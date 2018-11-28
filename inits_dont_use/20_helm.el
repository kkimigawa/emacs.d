(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c s") 'helm-swoop)
(global-set-key (kbd "C-c r") 'helm-resume)
(global-set-key (kbd "C-c m") 'helm-mark-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-mini)

(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; C-kでバッファを消せるようにする
(define-key helm-buffer-map (kbd "C-k") 'helm-buffer-run-kill-buffers)

;; helmのウインドウを今のウインドウの下に作成
(defun helm-split-window (buf options)
  (split-window)
  (other-window 1)
  (switch-to-buffer buf))
(setq helm-display-function 'helm-split-window)

;; 新しいファイルを作成するときにyes/noを聞かずにすぐ作成
(setq helm-ff-newfile-prompt-p nil)

;; helm-swoopを同じウインドウに表示する
(setq helm-swoop-split-with-multiple-windows t)

;; helm-miniの詳細表示をせずにバッファー名のみの表示にする
(setq helm-buffer-details-flag nil)

;; helm-miniが変な並び順になるのを防ぐ
(defadvice helm-buffers-sort-transformer (around ignore activate)
  (setq ad-return-value (ad-get-arg 0)))
