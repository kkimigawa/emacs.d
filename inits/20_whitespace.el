(require 'whitespace)
(setq whitespace-style '(face ; faceで可視化
                         trailing ; 行末
                         spaces ; スペース
                         space-mark ; 表示のマッピング
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
