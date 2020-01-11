" Bundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/jeff/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/home/jeff/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
NeoBundle 'flazz/vim-colorschemes'

NeoBundle 'stephpy/vim-yaml'

NeoBundle 'jiangmiao/auto-pairs'

NeoBundle 'bsdelf/bufferhint'
nnoremap - :call bufferhint#Popup()<CR>

NeoBundle 'zxqfl/tabnine-vim'

" LSP
" NeoBundle 'autozimu/LanguageClient-neovim', {'rev': 'next'}
" NeoBundle 'dense-analysis/ale'
NeoBundle 'prabirshrestha/async.vim'
NeoBundle 'prabirshrestha/vim-lsp'

" (Optional) Multi-entry selection UI.
NeoBundle 'junegunn/fzf'

NeoBundle 'luochen1990/rainbow'
let g:rainbow_active = 1

NeoBundle 'skywind3000/vim-terminal-help'
let g:terminal_shell = "fish"
let g:terminal_kill = "term"

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

set nu
set rnu
" set cc=88
set hlsearch
set incsearch

" filetype on
syntax on
set backspace=indent,eol,start

" Required for operations modifying multiple buffers like rename.
set hidden

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('gopls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })
endif

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gi :LspImplementation<CR>
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> df :LspDocumentFormat<CR>:w<CR>
nnoremap m :noh<CR><C-w>o
nnoremap <C-n> :LspNextDiagnostic<CR>
nnoremap <C-m>d :LspDocumentDiagnostics<CR>
