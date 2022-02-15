;; https://lisperblog.blogspot.com/2010/09/emacsunicode.html

;; #+:Emacs
(defun unicode-unescape-region (start end)
  "指定した範囲のUnicodeエスケープ文字(\\uXXXX)をデコードする."
  (interactive "*r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "\\\\u\\([[:xdigit:]]\\{4\\}\\)" nil t)
      (replace-match (string (unicode-char
                              (string-to-number (match-string 1) 16)))
                     nil t))))

(defun unicode-escape-region (&optional start end)
  "指定した範囲の文字をUnicodeエスケープする."
  (interactive "*r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "." nil t)
      (replace-match (format "\\u%04x"
                             (char-unicode
                              (char (match-string 0) 0)))
                     nil t))))

;; #+:Emacs
;; こちらも参照→ http://github.com/kosh04/emacs-lisp > xyzzy.el
(defun char-unicode (char) (encode-char char 'ucs))
(defun unicode-char (code) (decode-char 'ucs code))

;; #+:xyzzy
(defun unicode-unescape-region (&optional from to)
  (interactive "*r")
  (or (< from to)
      (rotatef from to))
  #+NIL
  (save-excursion
    (goto-char from)
    (while (scan-buffer "\\\\u\\([A-Za-z0-9_]\\{4\\}\\)" :regexp t :limit to)
      (let ((str (match-string 1)))
        (delete-region (match-beginning 0) (match-end 0))
        (insert (unicode-char (parse-integer str :radix 16))))))
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (goto-char (point-min))
      (while (re-search-forward "\\\\u\\([A-Za-z0-9_]\\{4\\}\\)" t)
        (replace-match (string (unicode-char
                                (parse-integer (match-string 1) :radix 16)))
                       :literal t))))
  )
