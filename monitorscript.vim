" Copyright (c) 2013-2024 Cumulocity GmbH, Duesseldorf, Germany and/or its affiliates and/or their licensors.
" 
" Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
" file except in compliance with the License. You may obtain a copy of the License at
" http://www.apache.org/licenses/LICENSE-2.0
" Unless required by applicable law or agreed to in writing, software distributed under the
" License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
" either express or implied. 
" See the License for the specific language governing permissions and limitations under the License.

" Custom syntax highlighting for Apama EPL files
" Language:	MonitorScript

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Keywords:
syn keyword msExternal  	package
syn keyword msBoolean  		false true
syn keyword msStatement		as on all action wait return monitor event import returns route emit to wildcard spawn die send enqueue print log at in unmatched completed currentTime from select using retain within partition by join where group having rstream aggregate every with unique bounded unbounded constant try catch static throw
syn keyword msOperator  	new not and xor equals or
syn keyword msRepeat		while for break continue
syn keyword msConditional	if then else ifpresent switch case default
syn keyword msType		integer string boolean float location sequence dictionary stream context chunk listener decimal optional any persistent

" Strings and characters:
syn region msString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region msString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match msNumber		"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn match msCommentCharacter contained "'\\[^']\{1,6\}'"
syn match msCommentCharacter contained "'\\''"
syn match msCommentCharacter contained "'[^\\]'"
syn region msComment start="/\*" skip="$" end="\*/" contains=msCommentCharacter,msNumber
syn region msComment start="//" skip="\\$" end="$" contains=msCommentCharacter,msNumber

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_ms_syn_inits")
  if version < 508
    let did_ms_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink msExternal 	Include
  HiLink msBoolean 	Boolean
  HiLink msStatement 	Statement
  HiLink msOperator 	Operator
  HiLink msRepeat 	Repeat
  HiLink msConditional 	Conditional
  HiLink msType 	Type
  HiLink msString 	String
  HiLink msNumber 	Number
  HiLink msComment 	Comment

  delcommand HiLink
endif

let b:current_syntax = "monitorscript"

" vim: ts=8
