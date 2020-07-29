(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")  t)
(package-initialize)

(eval-when-compile (require 'cl))

(defvar installing-package-list
  '(
    company
    counsel
    csharp-mode
    dired-single
    docker
    dockerfile-mode
    dumb-jump
    exec-path-from-shell
    git-gutter
    google-c-style
    google-this
    init-loader
    ivy
    kotlin-mode
    magit
    markdown-mode
    omnisharp
    rust-mode
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


(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
