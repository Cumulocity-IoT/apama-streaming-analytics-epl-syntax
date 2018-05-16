;; Copyright (c) 2018 Software AG, Darmstadt, Germany and/or its licensors
;; 
;; Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
;; file except in compliance with the License. You may obtain a copy of the License at
;; http://www.apache.org/licenses/LICENSE-2.0
;; Unless required by applicable law or agreed to in writing, software distributed under the
;; License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
;; either express or implied. 
;; See the License for the specific language governing permissions and limitations under the License.

;; Custom syntax highlighting for Apama EPL files

(defvar ApamaEPL-mode-hook nil)
(defvar ApamaEPL-mode-map
  (let ((ApamaEPL-mode-map (make-keymap)))
    (define-key ApamaEPL-mode-map "\C-j" 'newline-and-indent)
    ApamaEPL-mode-map)
  "Keymap for ApamaEPL mode")
(add-to-list 'auto-mode-alist '("\\.mon\\'" . ApamaEPL-mode))
(add-to-list 'auto-mode-alist '("\\.evt\\'" . ApamaEPL-mode))

;; define several class of keywords
(setq ApamaEPL-keywords '("as" "on" "all" "persistent" "action" "wait" "return" "monitor" "event" "import" "returns" "route" "emit" "to" "wildcard" "spawn" "die" "enqueue" "at" "in" "within" "unmatched" "completed" "currentTime" "from" "select" "in" "retain" "within" "partition" "by" "join" "in" "where" "group" "having" "rstream" "aggregate" "every" "with" "unique" "largest" "smallest" "bounded" "unbounded" "constant" "send" "static") )
(setq ApamaEPL-types '("float" "integer" "string" "decimal" "boolean" "sequence" "dictionary" "stream" "location" "any" "chunk" "listener" "context"))
(setq ApamaEPL-builtins '("new" "not" "and" "xor" "equals" "or"))
(setq ApamaEPL-constants '("true" "false"))
(setq ApamaEPL-events '("package" "using"))
(setq ApamaEPL-functions '("if" "then" "else" "while" "for" "break" "continue" "print" "log" "throw" "catch" "try" "ifpresent" "switch" "case" "default"))

;; create the regex string for each class of keywords
(setq ApamaEPL-keyword-regexp (regexp-opt ApamaEPL-keywords 'words))
(setq ApamaEPL-type-regexp (regexp-opt ApamaEPL-types 'words))
(setq ApamaEPL-builtin-regexp (regexp-opt ApamaEPL-builtins 'words))
(setq ApamaEPL-constant-regexp (regexp-opt ApamaEPL-constants 'words))
(setq ApamaEPL-event-regexp (regexp-opt ApamaEPL-events 'words))
(setq ApamaEPL-function-regexp (regexp-opt ApamaEPL-functions 'words))

;; clear memory
(setq ApamaEPL-keywords nil)
(setq ApamaEPL-types nil)
(setq ApamaEPL-builtins nil)
(setq ApamaEPL-constants nil)
(setq ApamaEPL-events nil)
(setq ApamaEPL-functions nil)

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq ApamaEPL-font-lock-keywords
      `(
                (,ApamaEPL-type-regexp . font-lock-type-face)
                (,ApamaEPL-constant-regexp . font-lock-constant-face)
                (,ApamaEPL-builtin-regexp . font-lock-builtin-face)
                (,ApamaEPL-function-regexp . font-lock-builtin-face)
                (,ApamaEPL-event-regexp . font-lock-function-name-face)
                (,ApamaEPL-keyword-regexp . font-lock-keyword-face)
                ;; note: order above matters. $-1òüApamaEPL-keywords-regexpòý goes last because
                ;; otherwise the keyword $-1òüstateòý in the function òüstate_entryòý
                ;; would be highlighted.
                ))

(defvar ApamaEPL-mode-syntax-table
  (let ((ApamaEPL-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" ApamaEPL-mode-syntax-table)

    (modify-syntax-entry ?/ ". 124b" ApamaEPL-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" ApamaEPL-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" ApamaEPL-mode-syntax-table)
    
    ApamaEPL-mode-syntax-table)
  "Syntax table for ApamaEPL-mode")

(defun ApamaEPL-mode ()
  "Major mode for editing Workflow Process Description Language files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table ApamaEPL-mode-syntax-table)
  (use-local-map ApamaEPL-mode-map)

  (set (make-local-variable 'font-lock-defaults) '(ApamaEPL-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'insert-tab)
  (setq major-mode 'ApamaEPL-mode)
  (setq mode-name "APAMAEPL")

  ;; clear memory
  (setq ApamaEPL-keyword-regexp nil)
  (setq ApamaEPL-type-regexp nil)
  (setq ApamaEPL-builtin-regexp nil)
  (setq ApamaEPL-constant-regexp nil)
  (setq ApamaEPL-event-regexp nil)
  (setq ApamaEPL-function-regexp nil)

  (run-hooks 'ApamaEPL-mode-hook))


(provide 'ApamaEPL-mode)

