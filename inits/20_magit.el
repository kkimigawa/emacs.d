(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)

;; 変更点の表示を簡略化してパフォーマンスを上げる
(setq magit-diff-highlight-indentation nil)
(setq magit-diff-highlight-trailing nil)
(setq magit-diff-paint-whitespace nil)
(setq magit-diff-highlight-hunk-body nil)
(setq magit-diff-refine-hunk nil)

;; コミット時に変更点を表示しない(変更点が多いと重くなる)
(remove-hook 'server-switch-hook 'magit-commit-diff)

;; magit-statusを高速化
;; https://jakemccrary.com/blog/2020/11/14/speeding-up-magit/
(remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
(remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
;(remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
;(remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
(remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)

;; 同じウインドウでmagitを開く
(setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer
         buffer
         (cond ((and (derived-mode-p 'magit-mode)
                     (eq (with-current-buffer buffer major-mode)
                         'magit-status-mode))
                nil)
               ((memq (with-current-buffer buffer major-mode)
                      '(magit-process-mode
                        magit-revision-mode
                        magit-diff-mode
                        magit-stash-mode))
                nil)
               (t
                '(display-buffer-same-window))))))
