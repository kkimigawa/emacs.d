(defun helm-grep-do-git-grep-all ()
  (interactive)
  (helm-grep-do-git-grep t))

;;(global-set-key (kbd "C-c g g") 'helm-git-grep)
(global-set-key (kbd "C-c g g") 'helm-grep-do-git-grep-all)
