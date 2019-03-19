(require 'eww)

;; 色設定
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil))

(setq eww-search-prefix "http://www.google.co.jp/search?q=")

(define-key eww-mode-map "p" '(lambda () "" (interactive) (scroll-down 1)))
(define-key eww-mode-map "n" '(lambda () "" (interactive) (scroll-up 1)))
(define-key eww-mode-map "U" 'eww-copy-page-url)
