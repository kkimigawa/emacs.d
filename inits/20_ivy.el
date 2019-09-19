(ivy-mode 1)
(counsel-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-height 20)

;; C-kでバッファを閉じる
(define-key ivy-switch-buffer-map (kbd "C-k") 'ivy-switch-buffer-kill)

;; C-x bだけでなくC-x C-bでもバッファ変更できるようにする
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

(global-set-key (kbd "C-c s") 'swiper-thing-at-point)
(global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c f") 'counsel-git)
(global-set-key (kbd "C-c g") 'counsel-git-grep)
(global-set-key (kbd "C-c r") 'counsel-recentf)
(global-set-key (kbd "C-c h") 'counsel-command-history)

;; ripgrepが使用できる場合はgit grepではなくrgを使用する
(when (executable-find "rg")
  (global-set-key (kbd "C-c g") 'counsel-rg)
  )

;; counsel-M-xで「^」が入力された状態になっているので空の状態にする
(setq ivy-initial-inputs-alist nil)
