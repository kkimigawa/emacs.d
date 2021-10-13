(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")  t)
(package-initialize)

(eval-when-compile (require 'cl))

(defvar installing-package-list
  '(
    company
    counsel
    csharp-mode
    dart-mode
    dired-single
    docker
    dockerfile-mode
    git-gutter
    groovy-mode
    init-loader
    ivy
    kotlin-mode
    magit
    magit-lfs
    markdown-mode
    omnisharp
    rust-mode
    smex
    swiper
    symbol-overlay
    typescript-mode
    web-mode
    wgrep
    whitespace
    yaml-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;; C-h置き換え
;; init.elに書かないとうまく動作しなかったのでここで定義
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
