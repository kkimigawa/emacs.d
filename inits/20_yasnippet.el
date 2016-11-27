(require 'yasnippet)

(setq yas-snippet-dirs '("~/.emacs.d/my-snippet"))
(yas-global-mode 1)

;; TABキーでyasnippet発動
(custom-set-variables '(yas-trigger-key "TAB"))
