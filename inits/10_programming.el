;; .inoをc-modeで開く
(add-to-list 'auto-mode-alist '("\\.ino?$" . c-mode))

;; .mmをobjc-modeで開く
(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "k&r")
            (setq c-basic-offset 4)
            (c-set-offset 'case-label '+)
            (c-set-offset 'statement-cont 'c-lineup-math)))
