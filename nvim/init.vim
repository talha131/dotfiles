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
Plug 'junegunn/vim-easy-align' " Vim alignment
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary' " toggle comments
Plug 'tpope/vim-endwise'
Plug 'kshenoy/vim-signature' " Shows marks
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
nnoremap <Leader>f :CocList files <CR>
nnoremap <Leader>b :CocList buffers <CR>
" enter word to search
nnoremap <Leader>g  :CocList --interactive grep<CR>
nnoremap <Leader>s  :CocList --interactive --ignore-case words<CR>

" Theme Settings                                                              {{{2
if has('mac')
    set guifont=Inconsolata:h14
    set background=dark
endif

function! SetStatusLineColor()
    highlight StatusLine ctermfg=231 ctermbg=61 cterm=bold guifg=#f8f8f2 guibg=#6272a4 gui=bold
    highlight StatusLineNC ctermfg=231 ctermbg=243 cterm=NONE guifg=#f8f8f2 guibg=#64666d gui=NONE
endfunction

function! SetLimelightConcealColor()
    if (&background ==# 'dark')
        " bg3 from gruvbox dark mode
        let g:limelight_conceal_ctermfg = '241'
        let g:limelight_conceal_guifg = '#665c54'
    else
        " bg3 from gruvbox light mode
        let g:limelight_conceal_ctermfg = '248'
        let g:limelight_conceal_guifg = '#bdae93'
    endif
endfunction

augroup theme_related_settings
    autocmd!
    " Preserve the custom colors set in SetStatusLineColor() whenever
    " colorscheme or background is changed
    autocmd ColorScheme * call SetStatusLineColor()
    autocmd ColorScheme * call SetLimelightConcealColor()
    autocmd BufEnter * call SetStatusLineColor()
augroup END

set cursorline
set cursorcolumn

" for coc-highlight
set termguicolors

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

" vim.fzf                                                                                  {{{2
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" vim-sneak                                                                                  {{{2
let g:sneak#label = 1

" vim-signature                                                                        {{{2
let g:SignatureMap = {
            \ 'Leader'             :  "m",
            \ 'PlaceNextMark'      :  "",
            \ 'ToggleMarkAtLine'   :  "m.",
            \ 'PurgeMarksAtLine'   :  "",
            \ 'DeleteMark'         :  "",
            \ 'PurgeMarks'         :  "",
            \ 'PurgeMarkers'       :  "",
            \ 'GotoNextLineAlpha'  :  "",
            \ 'GotoPrevLineAlpha'  :  "",
            \ 'GotoNextSpotAlpha'  :  "",
            \ 'GotoPrevSpotAlpha'  :  "",
            \ 'GotoNextLineByPos'  :  "",
            \ 'GotoPrevLineByPos'  :  "",
            \ 'GotoNextSpotByPos'  :  "m]",
            \ 'GotoPrevSpotByPos'  :  "m[",
            \ 'GotoNextMarker'     :  "",
            \ 'GotoPrevMarker'     :  "",
            \ 'GotoNextMarkerAny'  :  "",
            \ 'GotoPrevMarkerAny'  :  "",
            \ 'ListBufferMarks'    :  "m/",
            \ 'ListBufferMarkers'  :  ""
            \ }


" coc                                                                                  {{{2
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Better display for messages
set cmdheight=2

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" navigate diagnostic
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" show documentation
nmap <leader>dc :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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
            \'coc-ultisnips',
            \'coc-pyright',
            \]
let g:coc_snippet_next = '<tab>'

" navigate chunks of current buffer
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position. inline status
nmap <Leader>gis <Plug>(coc-git-chunkinfo)
" show commit contains current position. inline commit
nmap <Leader>gic <Plug>(coc-git-commit)
" git chuck stage
nnoremap <Leader>gcs  :CocCommand git.chunkStage<CR>
" git chuck undo
nnoremap <Leader>gcu  :CocCommand git.chunkUndo<CR>
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

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
