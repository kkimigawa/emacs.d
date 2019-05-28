;; 属性、所属等の情報を非表示にする
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
(setq dired-listing-switches "-alG")
