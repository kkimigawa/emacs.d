(global-company-mode +1)

;; 自動補完を offにしたい場合は, company-idle-delayを nilに設定する
;; auto-completeでいうところの ac-auto-start にあたる.
(custom-set-variables
 '(company-idle-delay nil))

;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; 行頭の場合は通常のTAB処理
;; 2文字目以降はcompany-completeで補完する
(defun my-company-key ()
  (interactive)
  (if (equal (current-column) 0)
      (indent-for-tab-command)
    (company-complete)))
(global-set-key (kbd "TAB") 'my-company-key)
