with import <nixpkgs> {};

vim-full.customize {
    vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
      # loaded on launch
      start = [
        # General Utility
        direnv-vim
        vim-commentary
        vim-git
        fugitive
        securemodelines
        ag-nvim
        fzf-vim

        # Figure out tabs
        vim-sleuth

        # Visual Stuff
        vim-airline
        dracula-vim

        # Language Tools
        vim-go
        ale
        YouCompleteMe
        copilot-vim

        # Language Syntax
        vim-nix
      ];
      # manually loadable by calling `:packadd $plugin-name`
      # however, if a Vim plugin has a dependency that is not explicitly listed in
      # opt that dependency will always be added to start to avoid confusion.
      # opt = [ phpCompletion elm-vim ];
      # To automatically load a plugin when opening a filetype, add vimrc lines like:
      # autocmd FileType php :packadd phpCompletion
    };
    vimrcConfig.customRC = ''
filetype plugin indent on
syntax on
" -----------------------------------------------------------------------------

" Set statements
" -----------------------------------------------------------------------------
set backspace=indent,eol,start "Backspace goes back over indents, \n, and start?
set expandtab "Tab button becomes spaces
set shiftwidth=4 "Tabs are always 4 spaces
set ts=4
set softtabstop=4
set tabstop=4
set et "Expand tabs
set tw=110 "Line width is now 99 chars
" autocmd FileType python set colorcolumn=110
set relativenumber "Relative Line Numbers
set autoindent "Pseudo-smart, uses parent indent level
set laststatus=2 "Give us a persistent status line
set shiftround " fancy tabbing so that we don't have irregular tabs
set encoding=utf-8 " For unicode glyphs
set pastetoggle=<F2> "Press to go into paste mode to avoid crazy tabbing
set clipboard=unnamed "Lets us use the macos clipboard from within vim
set autoread "Pull in new buffers when files changed behind the scenes (use :checktime after pulling)
set completeopt-=preview " Don't show the preview window when doing completions and shit.
" Whitespace alerts
au BufNewFile,BufRead * match ErrorMsg '\s\+$'
" AutoCommands for Events (event bindings)
" -----------------------------------------------------------------------------
au VimResized * :wincmd =
" Map keybindings for betterer awesomeness
" -----------------------------------------------------------------------------
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
" Changes leader to , instead of default: \
let mapleader = ","
" Never have I wanted that stupid window
map q: :q
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Clear match highlighting
nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>
nnoremap <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
"semi-colon is now colon
nnoremap ; :
nnoremap <leader>rtw :%s/\s\+$//e<CR>
nnoremap <leader>ftnl :%s/#012/\r/ge<CR>
nnoremap <leader>w :wall<CR>
nnoremap K <nop>
vnoremap K <nop>
cnoremap sudow w !sudo tee % >/dev/null
" vim-airline settings
" -----------------------------------------------------------------------------
let g:airline_powerline_fonts=1
let g:airline_section_c='%t'
" ZenCoding Settings
" -----------------------------------------------------------------------------
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = {'indentation' : '    '} " Set to 4 spaces for tabs
let g:use_zen_complete_tag=1
let g:user_zen_leader_key = '<c-e>'
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" vim-commentary settings
" -----------------------------------------------------------------------------
nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary
" -----------------------------------------------------------------------------

set noswf

set undodir=$TMPDIR/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Wildmenu Settings
set wildmenu " cmd line completion a-la zsh
set wildmode=list:longest " matches mimic that of bash or zsh
set wildignore+=node_modules                     " node_modules dir
set wildignore+=.ropeproject                     " py rope cache dir
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=compiled                         " compiled folder
set wildignore+=coverage                         " coverage folder
set wildignore+=licenses                         " licenses text folder
set wildignore+=npm_cache                        " npm_cache folder
set wildignore+=pyes
set wildignore+=docs
set wildignore+=django-piston
" -----------------------------------------------------------------------------
" pymode settings    (python)
" -----------------------------------------------------------------------------
let g:pymode_rope = 0 " just disable rope, it's not worth the pain
let g:pymode_rope_completion = 0 " Code Completion
let g:pymode_rope_complete_on_dot = 0 " Do code completion on '.'
let g:pymode_lint_config = '$HOME/pylint.rc'
let g:pymode_options_max_line_length = 110
let g:pymode_trim_whitespaces = 1 " Auto-trim whitespace on save
let g:pymode_options_colorcolumn = 1 " Show a colorcolumn at max line length
" -----------------------------------------------------------------------------
" ale settings
" -----------------------------------------------------------------------------
let g:ale_linters = {'ruby': ['rubocop']}
let g:ale_fixers = {'python': ['black'], 'go': ['gofmt'], 'terraform': ['terraform']}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
" -----------------------------------------------------------------------------
" vim-go
" -----------------------------------------------------------------------------
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" -----------------------------------------------------------------------------
" fzf.vim
" -----------------------------------------------------------------------------
nmap <C-P> :FZF<CR>
" -----------------------------------------------------------------------------
" vim-test.vim
" -----------------------------------------------------------------------------
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"
" -----------------------------------------------------------------------------
    '';
}
