;; namespace
(defun my-c-namespace-indent (langelem)
  (save-excursion
    (if (or (looking-at "[ \t]*namespace[ \t{]")
            (looking-at "[ \t]*namespace[ \t]+[_a-zA-Z]")
            (looking-at "[ \t]*}"))
        0
      (if (progn (goto-char (cdr langelem))
                 (skip-chars-backward " \t")
                 (bolp))
          4))))

;; ;; C
(add-hook 'c-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq c-basic-offset 4)
             (setq tab-width 4)
             ))

;; ;; C++
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq c-basic-offset 4)
             (setq tab-width 4)
             (c-set-offset 'innamespace 'my-c-namespace-indent)
             ))

;; .hpp と .h を C++ の拡張子とする
(setq auto-mode-alist
      (append
       '(("\\.hpp$" . c++-mode)
         ("\\.h$"   . c++-mode)
         ) auto-mode-alist))

;; Objective-C
(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))

;; perl
(add-hook  'cperl-mode-hook
           (lambda ()
             (require 'perl-completion)
             (add-to-list 'ac-sources 'ac-source-perl-completion)))
