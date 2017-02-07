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