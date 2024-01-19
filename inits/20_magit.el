(require 'magit)
(require 'magit-lfs)

(global-set-key (kbd "C-x g") 'magit-status)

;; 変更点の表示を簡略化してパフォーマンスを上げる
(setq magit-diff-highlight-indentation nil)
(setq magit-diff-highlight-trailing nil)
(setq magit-diff-paint-whitespace nil)
(setq magit-diff-highlight-hunk-body nil)
(setq magit-diff-refine-hunk nil)

(setq magit-refresh-status-buffer nil)
(setq magit-revision-insert-related-refs nil)

;; コミット時に変更点を表示しない(変更点が多いと重くなる)
(remove-hook 'server-switch-hook 'magit-commit-diff)

;; 同じウインドウでmagitを開く
;; https://idiomdrottning.org/magit-transients
(defun magit-display-buffer-same-window (buffer)
  "Display BUFFER in the selected window like God intended."
  (display-buffer
   buffer '(display-buffer-same-window)))

(setq magit-display-buffer-function 'magit-display-buffer-same-window)
(setq magit-popup-display-buffer-action '((display-buffer-same-window)))
