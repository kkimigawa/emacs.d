(ivy-mode 1)
(counsel-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-height 20)

;; C-x bだけでなくC-x C-bでもバッファ変更できるようにする
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

(global-set-key (kbd "C-r") 'counsel-recentf)

(global-set-key (kbd "C-c s") 'swiper)
(global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c f") 'counsel-git)
(global-set-key (kbd "C-c g") 'counsel-git-grep)
(global-set-key (kbd "C-c r") 'ivy-resume)

;; ripgrepが使用できる場合はgit grepではなくrgを使用する
(when (executable-find "rg")
  (global-set-key (kbd "C-c g") 'counsel-rg)
  )

;; counsel-M-xで「^」が入力された状態になっているので空の状態にする
(setq ivy-initial-inputs-alist nil)
