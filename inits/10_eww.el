(require 'eww)

(setq eww-search-prefix "http://www.google.co.jp/search?q=")

(define-key eww-mode-map "p" '(lambda () "" (interactive) (scroll-down 1)))
(define-key eww-mode-map "n" '(lambda () "" (interactive) (scroll-up 1)))
(define-key eww-mode-map "U" 'eww-copy-page-url)
