" Begin Plugins section                                                       {{{1
call plug#begin()

Plug 'dahu/bisectly'
Plug 'tpope/vim-speeddating'
" Plugins - File Explorer                                        {{{2
if has('mac')
    Plug '/opt/homebrew/opt/fzf'
    Plug 'junegunn/fzf.vim' " :Files :Marks :Windows
endif
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
" Plugins - Code Complete and Snippets                                        {{{2
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plugins - Motion Enhancements                                               {{{2
Plug 'justinmk/vim-sneak'
Plug 'chaoren/vim-wordmotion'
Plug 'danilamihailov/beacon.nvim'
" Plugins - Syntax files and Programming Languages                            {{{2
Plug 'sheerun/vim-polyglot'
" Plugins - Typing Utilities                                                  {{{2
Plug 'tpope/vim-rsi' " Readline key bindings
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary' " toggle comments
Plug 'tpope/vim-endwise'
Plug 'AndrewRadev/splitjoin.vim' " gS gJ to split and join lines
" Plugins - Utilities and Wrappers                                            {{{2
Plug 'tpope/vim-eunuch' " Wrapper for UNIX shell commands
Plug 'henrik/vim-indexed-search' " Show 'Match 123 of 456 <search term>' in Vim searches
Plug 'romainl/vim-qf' " a collection of settings, commands and mappings for the quickfix window
Plug 'romainl/vim-qlist' " make include-search and definition-search populate in the quickfix window
Plug 'mhinz/vim-startify' " A start screen for Vim
" Delete buffers and close files without messing up layout
" Why it is needed? See this discussion http://superuser.com/q/289285/42415
Plug 'moll/vim-bbye'
Plug 'wellle/targets.vim'
Plug 'kshenoy/vim-signature'
" Plugins - Version Control and File Comparison                               {{{2
Plug 'tpope/vim-fugitive'
            \ | Plug 'junegunn/gv.vim'
            \ | Plug 'tpope/vim-rhubarb'
" Plugins - Theme                                                             {{{2
Plug 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call plug#end()            " required
" End Plugins section }}}

" Custom Functions                                                            {{{1
" from https://www.vi-improved.org/recommendations/
function! StripTrailingWhitespace()
  if !&binary && &filetype !=# 'diff'
    let l:save = winsaveview() " Save cursor position
    " vint: -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
    %s/\s\+$//e
    call winrestview(l:save) " Restore cursor to saved position
  endif
endfunction

function! RemoveZeroWidthSpace()
  if !&binary && &filetype !=# 'diff'
    let l:save = winsaveview() " Save cursor position
    " vint: -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
    %s/\%u200b//g
    call winrestview(l:save) " Restore cursor to saved position
  endif
endfunction

function! JSONFormat()
    execute "%!python -m json.tool"
endfunction

" from https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/#showing-highlight-groups
function! s:SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunction

" Customize Vim                                                               {{{1
" Use <C-L> to clear the highlighting of :set hlsearch. From sensible.vim
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
set inccommand=split
" Python package for Neovim                                                   {{{2
if has('mac')
    " crtical setting
    let g:python3_host_prog = '/opt/homebrew/bin/python3'
endif

" Miscellaneous Variables                                                     {{{2
set expandtab
set guioptions+=b " make sure horizontal scroll bar is visible
set number
set shiftwidth=2
set softtabstop=4
set tabstop=4
set wrap
set ignorecase
set smartcase
set hlsearch " Highlight search results
set noerrorbells visualbell t_vb= " Disable Beeping
set relativenumber
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro rnu' " Except nu and rnu, all are netrw default values
set showcmd
" use Patience diff algorithm for generating diffs
set diffopt+=internal,algorithm:patience
if has('mac')
    " crtical setting
    set shell=/opt/homebrew/bin/bash
    set shellcmdflag=-c
endif

" Preserve file history                                                       {{{2
set undofile " write undo history to file so that undo history remains persistent
set backup " Make a backup before overwriting a file.  Leave it around after the file has been successfully written.
set writebackup " Make a backup before overwriting a file.  The backup is removed after the file was successfully written, unless the 'backup' option is also on.
set swapfile " Use a swap file for the buffer.

" Command Line Completion                                                     {{{2
" from [SO answer](http://stackoverflow.com/a/526940/177116)
" When you type the first tab hit will complete as much as possible, the
" second tab hit will provide a list, the third and subsequent tabs will cycle
" through completion options so you can complete the file without further keys
set wildignorecase
set wildmenu
" Show a list and then choose from the wild menu
set wildmode=list:full

" Insert Mode Completion                                                     {{{2
set completeopt-=preview

" :find                                                                       {{{2
" Add folder of current file and every folder under it to Vim's path
set path=.,**
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb
set wildignore+=*.png,*.pxm,*.psd,*.pdf,*.jpg,*.gif,*.rtf,*.ico,*.icns,*.tiff
set wildignore+=*.woff,*.ttf,*.eot,*.woff2
set wildignore+=*.exe,*.bin,*.crl,*.pem,*.crt
set wildignore+=*.plist,*.xcodeproj/**,*.framework/**/*
set wildignore+=*/.hg/**/*,*/.svn/**/*
set wildignore+=tags,cscope.*
set wildignore+=*.tar.*

" Key Mappings                                                                {{{2
" It is better to use <CR> instead or <C-R> instead of  in key mappings.
" It makes it easier to copy paste, makes the intetion clear that it's a
" single character. Sometimes when copy paste ^M gets translated into enter
" instead of being pasted as a literal
" Use <F7> to toggle spell check in the current buffer
if maparg('<F7>', 'n') ==# ''
  nnoremap <silent> <F7> :setlocal spell!<CR>
endif

" Use <F8> to toggle relative number in the current buffer
if maparg('<F8>', 'n') ==# ''
  nnoremap <silent> <F8> :setlocal relativenumber!<CR>
endif

" Leader Key                                                                  {{{2
" To map to space key, either use ' ' or "\<Space>"
" '<Space>' or '\<Space>' does not work
" For details see http://vi.stackexchange.com/a/282/5643
" :help expr-quote
" Some commands like map understand <Space> but for others you need "\<Space>"
let g:mapleader = ' '
" Open Gstatus in a new tab
nnoremap <Leader>gs :Git <CR> :wincmd T <CR> :-tabmove <CR>
nnoremap <Leader>gc :-tab Git commit -v<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gwq :Gwq <CR>
" vim-bbye
nnoremap <Leader>q :w \| Bdelete<CR>
" show highlight group
nnoremap <leader>hg :call <SID>SynStack()<CR>
nnoremap <Leader>f :Files <CR>
nnoremap <Leader>b :Buffers <CR>
nnoremap <Leader>g :Rg <CR>
nnoremap <Leader>s :Blines <CR>
nnoremap <Leader>r :Lines <CR>

" Theme Settings                                                              {{{2
if has('mac')
    set guifont=Inconsolata:h14
    set background=dark
endif

function! SetStatusLineColor()
    highlight StatusLine ctermfg=231 ctermbg=61 cterm=bold guifg=#f8f8f2 guibg=#6272a4 gui=bold
    highlight StatusLineNC ctermfg=231 ctermbg=243 cterm=NONE guifg=#f8f8f2 guibg=#64666d gui=NONE
endfunction

augroup theme_related_settings
    autocmd!
    " Preserve the custom colors set in SetStatusLineColor() whenever
    " colorscheme or background is changed
    autocmd ColorScheme * call SetStatusLineColor()
    autocmd BufEnter * call SetStatusLineColor()
augroup END

set cursorline
set cursorcolumn

colorscheme gruvbox

" Status line                                                                 {{{2
set statusline=%{winnr()} " window number. Useful for {count}<C-W>q
set statusline+=\ " separator
set statusline+=%f " relative path of current file
set statusline+=\ " separator
set statusline+=%{fugitive#statusline()} " the current branch and the currently edited file's commit
set statusline+=\ " separator
set statusline+=%m " modified flag
set statusline+=%r " read-only flag
set statusline+=%h " help buffer flag
set statusline+=%w " preview flag
" set statusline+=\ " separator
" set statusline+=[%L] " total number of lines in buffer
set statusline+=[%p%%] " percentage through file in lines
set statusline+=[%04l,%04v] " current line, current column
" set statusline+=\ " separator
" set statusline+=[%{&ff}] " current file format
set statusline+=%y " file type
" set statusline+=\ " separator

" Use rg instead of grep                                                      {{{2
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Terminal related settings                                                   {{{2
if (has('nvim'))
    autocmd TermOpen * set bufhidden=hide
endif

" File type Customizations                                                      {{{1
" Until https://github.com/sheerun/vim-polyglot/pull/318 is merged
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" Plugins Customizations                                                      {{{1

" startify                                                                                  {{{2
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let s:padding_left = repeat(' ', get(g:, 'startify_padding_left', 3))
let g:startify_list_order = [
        \ [s:padding_left .'Sessions'],       'sessions',
        \ [s:padding_left .'MRU'],            'files',
        \ [s:padding_left .'MRU '. getcwd()], 'dir',
        \ [s:padding_left .'Bookmarks'],      'bookmarks',
        \ [s:padding_left .'Commands'],       'commands',
        \ ]

" vim-sneak                                                                                  {{{2
let g:sneak#label = 1

" coc                                                                                  {{{2
let g:coc_global_extensions = [
            \'coc-git',    
            \'coc-go',    
            \'coc-yank',
            \'coc-highlight',
            \'coc-prettier',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tslint',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-snippets',
            \'coc-pyright',
            \]

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming. Rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CocList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" nnoremap <Leader>f :CocList files <CR>
" nnoremap <Leader>b :CocList buffers <CR>
" enter word to search
" nnoremap <Leader>g  :CocList --interactive grep<CR>
" nnoremap <Leader>s  :CocList --interactive --ignore-case words<CR>

" coc-git                                                                                  {{{2
" https://github.com/neoclide/coc-git#keymaps
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
"nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
" git chunk stage
nnoremap <Leader>gcs  :CocCommand git.chunkStage<CR>
" git chuck undo
nnoremap <Leader>gcu  :CocCommand git.chunkUndo<CR>

" coc-highlight                                                                               {{{2
set termguicolors
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" FileType related settings                                                   {{{1
augroup filetype_related_settings
    autocmd!
    autocmd FileType objc,objcpp,cpp,c setlocal foldmethod=syntax
    autocmd FileType objcpp setlocal cindent
    autocmd FileType gitcommit setlocal colorcolumn=72 spell" highlight 72nd column in git commit
    autocmd FileType markdown,text setlocal spell
    if (has('mac'))
        autocmd FileType gitcommit,markdown,text setlocal dictionary=/usr/share/dict/words
    endif
augroup END

" Vim modeline                                                                {{{1
" vim:set foldmethod=marker foldlevel=1:
