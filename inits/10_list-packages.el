(defcustom dse/package-menu/package-column-width 48
  "Column width of package name in list-packages menu."
  :type 'number :group 'package)
(defcustom dse/package-menu/archive-column-width 12
  "Column width of archive name in list-packages menu."
  :type 'number :group 'package)
(defun dse/package-menu/fix-column-widths ()
  (let ((tlf (append tabulated-list-format nil)))
    (setf (cadr (assoc "Package" tlf)) dse/package-menu/package-column-width)
    (setf (cadr (assoc "Archive" tlf)) dse/package-menu/archive-column-width)
    (setq tabulated-list-format (vconcat tlf))))

(add-hook 'package-menu-mode-hook #'dse/package-menu/fix-column-widths)
