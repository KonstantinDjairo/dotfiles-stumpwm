(in-package :stumpwm)

(set-prefix-key (kbd "s-x"))

(define-key *top-map* (kbd "s-F12") "exec amixer sset Master 5%+")
(define-key *top-map* (kbd "s-F11") "exec amixer sset Master 5%-")
(define-key *top-map* (kbd "s-F10") "exec amixer sset Master toggle")

(run-shell-command "pidof emacs || emacs --daemon")

(defvar *emacs*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "RET") "exec emacsclient -c -a ''")
    (define-key m (kbd "d") "exec emacsclient -c -a '' -e '(dired nil)'")
    (define-key m (kbd "e") "exec emacsclient -c -a '' -e '(eshell)'")
    (define-key m (kbd "a") "exec emacsclient -c -a '' -e '(org-agenda)'") m))

(define-key *top-map* (kbd "s-e") '*emacs*)

(defvar *music*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "t") "exec mpc toggle")
    (define-key m (kbd "n") "exec mpc next")
    (define-key m (kbd "p") "exec mpc prev")
    (define-key m (kbd "-") "exec mpc seek -10")
    (define-key m (kbd "=") "exec mpc seek +10")
    (define-key m (kbd "c") "exec nowplaying") m))

(define-key *top-map* (kbd "s-m") '*music*)

(defvar *upload*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "s") "exec shot us")
    (define-key m (kbd "a") "exec shot ua") m))

(defvar *print*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "s") "exec shot s")
    (define-key m (kbd "a") "exec shot a")
    (define-key m (kbd "u") '*upload*) m))

(define-key *top-map* (kbd "Print") '*print*)

(run-shell-command "xsetroot -mod 20 20 -bg '#d7d7d7' -fg '#999999'")
(run-shell-command "pgrep urxvtd || urxvtd")

(define-key *top-map* (kbd "s-RET") "exec urxvtc")
(define-key *root-map* (kbd "l") "exec slock")

(defvar *apps*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "t") "exec telegram-desktop")
    (define-key m (kbd "g") "exec gimp")
    (define-key m (kbd "b") "exec chrome") m))

(define-key *top-map* (kbd "s-a") '*apps*)

(setf *window-format* "%n%s%25t")

(define-key *root-map* (kbd "b") "windowlist")

(define-key *top-map* (kbd "s-TAB") "other-window")

(define-key *top-map* (kbd "s-S-Left") "move-window left")
(define-key *top-map* (kbd "s-S-Up") "move-window up")
(define-key *top-map* (kbd "s-S-Right") "move-window right")
(define-key *top-map* (kbd "s-S-Down") "move-window down")

(define-key *top-map* (kbd "s-[") "prev")
(define-key *top-map* (kbd "s-]") "next")

(defcommand kill-windowlist (&optional (fmt *window-format*) window-list) (:rest)
  "Delete window from menu list"
  (if-let ((window-list (or window-list
                            (sort-windows-by-number (group-windows (current-group))))))
      (if-let ((window-to-kill (select-window-from-menu window-list fmt)))
          (when window-to-kill (delete-window window-to-kill))
        (throw 'error :abort))
    (message "No Managed Windows")))

(define-key *root-map* (kbd "k") "kill-windowlist")

(define-key *root-map* (kbd "0") "remove-split")
(define-key *root-map* (kbd "1") "only")
(define-key *root-map* (kbd "2") "vsplit")
(define-key *root-map* (kbd "3") "hsplit")

(define-key *root-map* (kbd "o") "fselect")

(define-key *top-map* (kbd "s-Left") "move-focus left")
(define-key *top-map* (kbd "s-Up") "move-focus up")
(define-key *top-map* (kbd "s-Right") "move-focus right")
(define-key *top-map* (kbd "s-Down") "move-focus down")

(define-key *groups-map* (kbd "b") "grouplist")
(define-key *groups-map* (kbd "v") "vgroups")

(define-key *top-map* (kbd "s-ISO_Left_Tab") "gother")

(define-key *top-map* (kbd "s-{") "gnext")
(define-key *top-map* (kbd "s-}") "gprev")

(when *initializing*
  (grename "dev")
  (gnewbg "msg")
  (gnewbg "misc"))

(clear-window-placement-rules)

(define-frame-preference "dev" (0 t t :class "Chromium"))
(define-frame-preference "msg" (0 t t :class "TelegramDesktop"))

(define-key *root-map* (kbd "s-c") "quit-confirm")

(define-key *root-map* (kbd "r") "loadrc")

(setf *time-format-string-default* (format nil "%k:%M:%S~%%A~%%d %B~%%d/%m/%Y")
      *timeout-wait* 10)

(define-key *root-map* (kbd "d") "echo-date")

(defvar col0 "#000000")
(defvar col1 "#a60000")
(defvar col2 "#005e00")
(defvar col3 "#813e00")
(defvar col4 "#0031a9")
(defvar col5 "#721045")
(defvar col6 "#00538b")
(defvar col7 "#bfbfbf")
(defvar col8 "#595959")
(defvar col9 "#ffffff")

(setf *colors*
      `(,col0   ;; 0 black
        ,col1   ;; 1 red
        ,col2   ;; 2 green
        ,col3   ;; 3 yellow
        ,col4   ;; 4 blue
        ,col5   ;; 5 magenta
        ,col6   ;; 6 cyan
        ,col7)) ;; 7 white

(update-color-map (current-screen))

(set-bg-color col9)
(set-fg-color col0)

(set-border-color col0)
(set-float-focus-color col0)
(set-float-unfocus-color col9)
(set-win-bg-color col9)

(setf *maxsize-border-width* 0
      *normal-border-width* 0
      *transient-border-width* 0
      *float-window-border* 3
      *float-window-title-height* 3
      *window-border-style* :thin)

(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *message-window-padding* 10)

(setf *mouse-focus-policy* :click)

(setf *mode-line-background-color* col9
      *mode-line-foreground-color* col0
      *time-modeline-string* "%F %H:%M")

(setf *screen-mode-line-format* "[%n] %W ^> %d")

;; (when *initializing*
;;   (mode-line))
