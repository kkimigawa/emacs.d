(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)
(setq ac-auto-start nil)

(push 'ac-source-filename ac-sources)

(global-auto-complete-mode t)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'lua-mode)

;; C-n C-pで候補選択
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; Tabキーの設定(行頭ではTAB本来のままで2文字目からはauto-completeを使用)
(defun my-auto-complete-key ()
  (interactive)
  (if (equal (current-column) 0)
    (indent-for-tab-command)
    (auto-complete)))
(define-key ac-mode-map (kbd "TAB") 'my-auto-complete-key)
