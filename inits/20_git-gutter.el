(global-git-gutter-mode t)

(setq git-gutter:added-sign " ")
(setq git-gutter:deleted-sign " ")
(setq git-gutter:modified-sign " ")

;; 色設定
(set-face-background 'git-gutter:added  "green")
(set-face-background 'git-gutter:deleted  "red")
(set-face-background 'git-gutter:modified "yellow")
