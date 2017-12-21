;; -*- mode: elisp -*-

(add-to-list 'load-path "~/Tech/Emacs Packages") ;;External packages

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)
(require 'xah-fly-keys)

(xah-fly-keys-set-layout "qwerty") ; required if you use qwerty
;; (xah-fly-keys-set-layout "workman") ; required if you use workman
;; (xah-fly-set-layout "dvorak") ; by default, it's dvorak

(xah-fly-keys 1)
(global-set-key (kbd "`") 'xah-fly-command-mode-activate)


;; Added by Package.el.  This must come before configurations of
;; installed packages. 
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)



;;Emacs General

    ;; key bindings
        ;;Org
            (global-set-key                 "\C-cl"         'org-store-link)
            (global-set-key                 "\C-ca"         'org-agenda)
            (global-set-key                 "\C-cb"         'org-iswitchb)
            (global-set-key                 "\C-cp"         'org-mobile-push)
            (global-set-key                 "\C-cu"         'org-mobile-pull)
            (define-key global-map          "\C-cl"         'org-store-link)
            (define-key global-map          "\C-ca"         'org-agenda)
            (global-set-key                 (kbd "<f12>")   'org-agenda)
            ;;Following links anywhere
            (global-set-key                 "\C-c L"        'org-insert-link-global)
            (global-set-key                 "\C-c o"        'org-open-at-point-global)
            (define-key global-map          "\C-cc"         'org-capture)
        ;;General
            (global-set-key                 "\C-xc"         'copy)
    ;;Visual Settings


    ;;Directories
    
        ;; Save all tempfiles in $TMPDIR/emacs$UID/                                                        
        (defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) "~/.emacs.d/temp"))
        (setq backup-directory-alist
            `((".*" . ,emacs-tmp-dir)))
        (setq auto-save-file-name-transforms
            `((".*" ,emacs-tmp-dir t)))
        (setq auto-save-list-file-prefix
            emacs-tmp-dir)
    
    
        ;;(setq backup-directory-alist '(("." . "~/.emacs.d/auto-save-files"))) ;;Autosave custom
        ;;(setq auto-save-file-name-transforms '((".*" , "~/.emacs.d/auto-save-files" t)))

        (setq default-directory "~/Org/" )
		
;; Disable the splash screen 
	(setq inhibit-splash-screen t) ;;(to enable:replace the t with 0)

;; Echo keystrokes immediately.
		(setq echo-keystrokes 0.02)

;; Typography

    ;Use 78 characters for a text document
    ;    Column 0 is the first possible character
    ;    Column 77 is the last possible character
    ;    Column 78 will always be empty
    ;        This is the fill column
    ;        This gives some spacing between the text body and the 80 column indicator
    ;    Column 79 will always be the fill column indicator
    ;        It isn’t the fill column though
    ;        I want it to indicate 80 chars, typically the maximum number of columns for a line, to know how to size the window itself
    ;        Fci-Mode supports this
    ;    Store this as the fill column because all supporting functions will do the right thing here
    ;
	(defconst help/column-width 78)
	(setq-default fill-column help/column-width)
	
;;=============Dictionary / spelling===============
(setq ispell-program-name "~/Tech/Hunspell/bin/hunspell.exe")
;; "en_US" is key to lookup in `ispell-local-dictionary-alist`, please note it will be passed to hunspell CLI as "-d" parameter
(setq ispell-local-dictionary "en_US") 
(setq ispell-local-dictionary-alist
      '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
	
(defun endless/org-ispell ()
  "Configure `ispell-skip-region-alist' for `org-mode'."
  (make-local-variable 'ispell-skip-region-alist)
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
(add-hook 'org-mode-hook #'endless/org-ispell)
	
;;=============Yasnippet================
		(require 'yasnippet)
		(yas-global-mode 1)

		(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        "~/Tech/Emacs Packages/snippets" ;; the default collection
        ))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
        
;;=============ORG================

;; Enable Org mode
    (require 'org)

; (require 'org-brain)


  ; (setq org-brain-path "~/Org/brain")
  ; :config
  ; (setq org-id-track-globally t)
  ; (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  ; (push '("b" "Brain" plain (function org-brain-goto-end)
          ; "* %i%?" :empty-lines 1)
        ; org-capture-templates)
  ; (setq org-brain-visualize-default-choices 'all)
  ; (setq org-brain-title-max-length 12)
;; Folding
(setq org-startup-folded nil)

;; Opening Attachments
  (setq org-file-apps
    '(("\\.docx\\'" . default)
      ("\\.mm\\'" . default)
      ("\\.x?html?\\'" . default)
      ("\\.pdf\\'" . default)
      (auto-mode . emacs)))

    
;; Make Org mode work with files ending in .org
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    
;; Org Directories/files
    (setq org-default-notes-file "~/Org/working.org")
    (setq org-directory "~/Org")
;; Org Mobile Directories/files
    (setq org-mobile-directory      "~/MobileOrg")
;    (setq org-mobile-files          "~/Org/working.org");;push_to_mobile.org")
    (setq org-mobile-inbox-for-pull "~/Org/inbox.org") ;; Set to the name of the file where new notes will be stored

;; TODO workflow
    (   setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
    (setq org-log-done t) ;;https://www.gnu.org/software/emacs/manual/html_node/org/Closing-items.html

;; TAGS to all
    ;;(setq org-tag-alist '(("working" . ?w) ("@home" . ?h) ("laptop" . ?l)))

;; Custom Agenda Commands
	     (setq org-agenda-custom-commands
           '(("x" agenda)
             ("y" agenda*)
             ("w" todo "WAITING")
             ("W" todo-tree "WAITING")
             ("u" tags "+pray")
             ("U" tags-tree "+pray")
             ("f" occur-tree "\\<FIXME\\>")
))
;; Hide Properties 

(require 'org)

(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
             (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp
                    (point-min)
                    (point)))
             (end (if globalp
                    (point-max)
                    (if (eq state 'children)
                      (save-excursion
                        (outline-next-heading)
                        (point))
                      (org-end-of-subtree t)))))
        (goto-char beg)
        (while (re-search-forward org-drawer-regexp end t)
          (save-excursion
            (beginning-of-line 1)
            (when (looking-at org-drawer-regexp)
              (let* ((start (1- (match-beginning 0)))
                     (limit
                       (save-excursion
                         (outline-next-heading)
                           (point)))
                     (msg (format
                            (concat
                              "org-cycle-hide-drawers:  "
                              "`:END:`"
                              " line missing at position %s")
                            (1+ start))))
                (if (re-search-forward "^[ \t]*:END:" limit t)
                  (outline-flag-region start (point-at-eol) t)
                  (user-error msg))))))))))

				  

;; Custom Set Variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("5acb6002127f5d212e2d31ba2ab5503df9cd1baa1200fbb5f57cc49f6da3056d" "2a739405edf418b8581dcd176aaf695d319f99e3488224a3c495cb0f9fd814e3" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files (quote ("~/Org/")))
 '(org-capture-templates
   (quote
    (("n" "Generic Note" plain
      (file+olp "~/Org/working.org" "Captured Notes")
      "String" :empty-lines-before 1 :empty-lines-after 1))))
 '(package-selected-packages
   (quote
    (org-plus-contrib org org-brain org-bullets which-key xah-fly-keys espresso-theme zenburn-theme noctilux-theme solarized-theme yasnippet)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
        
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
    
