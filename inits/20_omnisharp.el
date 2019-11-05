(add-hook 'csharp-mode-hook 'omnisharp-mode)

;; company-modeで補完できるようにする
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-omnisharp))

;; 補完時に大文字小文字を区別する
(setq omnisharp-company-ignore-case nil)
