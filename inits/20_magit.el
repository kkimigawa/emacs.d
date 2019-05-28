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

;; ログの日時をYYYY-mm-dd HH:MM:SSで表示する
(eval-after-load "magit-log"
  '(progn
     (custom-set-variables
      '(magit-log-margin '(t "%Y-%m-%d %H:%M:%S      " magit-log-margin-width t 18)))))
