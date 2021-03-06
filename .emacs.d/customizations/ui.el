;; These customizations change the way emacs looks and disable/enable
;; some user interface elements. Some useful customizations are
;; commented out, and begin with the line "CUSTOMIZE". These are more
;; a matter of preference and may require some fiddling to match your
;; preferences

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;; Fix margins when font is scaled with C-x C-+ or C-x C--
;; https://www.emacswiki.org/emacs/LineNumbers#toc14
(require 'linum)
(defun linum-update-window-scale-fix (win)
"fix linum for scaled text"
(set-window-margins win
                    (ceiling (* (if (boundp 'text-scale-mode-step)
                                    (expt text-scale-mode-step
                                          text-scale-mode-amount) 1)
                                (if (car (window-margins))
                                    (car (window-margins)) 1)))))
(advice-add #'linum-update-window :after #'linum-update-window-scale-fix)

;; Remove the graphical toolbar at the top. After awhile, you won't need the toolbar.
(when (fboundp 'tool-bar-mode)
(tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
(scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")

; (load-theme 'tomorrow-night-bright t)

;; Sam wants solarized, dammit!
;(load-theme 'solarized-dark t)
;; Set cursor to solarized red
;(set-cursor-color "#dc322f")

;; Override default "box" cursor
(setq-default cursor-type 'bar)

;; Use alternative theme for terminal (solarized is wonky in term)
(if (display-graphic-p)
  (load-theme 'solarized-dark t)
  ;(load-theme 'zenburn t)
  ;(load-theme 'subatomic256 t)
  (load-theme 'clues-sam t)
  ;(load-theme 'material t)
  )

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
(setq initial-frame-alist '((top . 0) (left . 0) (width . 100) (height . 44)))

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
    x-select-enable-clipboard t

    ;; I'm actually not sure what this does but it's recommended?
    x-select-enable-primary t

    ;; Save clipboard strings into kill ring before replacing them.
    ;; When one selects something in another program to paste it into Emacs,
    ;; but kills something in Emacs before actually pasting it,
    ;; this selection is gone unless this variable is non-nil
    save-interprogram-paste-before-kill t

    ;; Shows all options when running apropos. For more info,
    ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
    apropos-do-all t

    ;; Mouse yank commands yank at point instead of at click.
    mouse-yank-at-point t)

;; No cursor blinking, it's distracting
; (blink-cursor-mode 0)
(blink-cursor-mode 1)

;; Blink cursor forever (defaults to 10 blinks)
(setq blink-cursor-blinks 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

;; Enable which-key
(which-key-mode)

;; Taken from https://www.emacswiki.org/emacs/ToggleWindowSplit
(load "ui/toggle-window-split.el")

;; Taken from https://www.emacswiki.org/emacs/TransposeWindows
(load "ui/transpose-windows.el")

;; Configure buffer-move
(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; Enable Wind Move (Shift and arrow keys to move point between "windows")
(when (fboundp 'windmove-default-keybindings)
 (windmove-default-keybindings))


;; https://stackoverflow.com/questions/5710334/how-can-i-get-mouse-selection-to-work-in-emacs-and-iterm2-on-mac
;; Enable mouse reporting for terminal emulators
(unless window-system
 (xterm-mouse-mode 1)
 (global-set-key [mouse-4] (lambda ()
                             (interactive)
                             (scroll-down 1)))
 (global-set-key [mouse-5] (lambda ()
                             (interactive)
                             (scroll-up 1))))
