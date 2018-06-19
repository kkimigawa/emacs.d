(global-company-mode +1)

;; 自動補完を offにしたい場合は, company-idle-delayを nilに設定する
;; auto-completeでいうところの ac-auto-start にあたる.
(custom-set-variables
 '(company-idle-delay nil))

(global-set-key (kbd "<C-tab>") 'company-complete)

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "<C-tab>") 'company-complete)

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
