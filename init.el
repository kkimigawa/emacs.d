(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")  t)
(package-initialize)

(eval-when-compile (require 'cl))

(defvar installing-package-list
  '(
    company
    company-c-headers
    counsel
    csharp-mode
    docker
    dockerfile-mode
    dumb-jump
    exec-path-from-shell
    git-gutter
    google-c-style
    init-loader
    ivy
    kotlin-mode
    lua-mode
    magit
    markdown-mode
    neotree
    omnisharp
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
