(add-hook 'csharp-mode-hook 'omnisharp-mode)

;; company-modeで補完できるようにする
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-omnisharp))
