" SECURITY
" ==============
set nomodeline " https://www.theregister.co.uk/2019/06/12/vim_remote_command_execution_flaw/
" TODO Vim private mode //vi.stackexchange.com/questions/834/prevent-vim-from-recording-events-for-certain-filetypes?lq=1 

" USAGE RULES
" ================
" don't be just vi, be vim
set nocompatible		" Vimwiki, 90% required
" enable syntax and plugins (for netrw)
filetype plugin on		" Vimwiki, nerdcommenter, 90% required
syntax enable				" on | enable Vimwiki, 90% required
set number				" Show line numbers
set list				" Show hidden charaters
set cursorline			" highlight cursor's line
set cursorcolumn		" yiss
set linebreak			" word wrap whole words
set modifiable			" for NERDtree
"set relativenumber		" gutter numbering |> meh, hard to use ex commands
"set mouse=a				" Enable mouse usage (all modes)
"set spell spelllang=en_us  " spell checking
"set so=999				" scroll off beyond document
"set fillchars+=vert:\
"set noswapfile
"set ignorecase			" Do case insensitive matching (issues with gd) 
"set showmatch			" Show matching brackets. (already using vim-surround)

" The following are commented out as they cause vim to behave a lot
" " differently from regular Vi. They are highly recommended though.
" set showcmd            " Show (partial) command in status line.
" set smartcase          " Do smart case matching
" set incsearch          " Incremental search
" set autowrite          " Automatically save before commands like :next and :make

"set hidden        " Hide buffers when they are abandoned
"set nobackup      " some servers have issues with backups
"set nowritebackup " some servers have issues with backups
"set cmdheight=2 " better display for messages

" Window Splits
set splitbelow " more natural split
set splitright " more natural split

" Tab Shifting
set tabstop=4 softtabstop=4		" existing tabs
set shiftwidth=4 noexpandtab	" indenting with '>'
set breakindent					" after wordwrap
"set breakindentopt=sbr
"" I use a unicode curly array with a <backslash><space>
"set showbreak=~\

" FUZZY-FILE TAB COMPLETION
" ========================================
" Search down into subfolder
set path+=**
" Display all matching files when we tab complete
set wildmode=longest,list,full  " 1st tab: tab complete
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/node_modules/*,*/_build/*
set wildmenu					" 2nd tab: provide a list
								" 3rd tabs: cycle completion options
"set completeopt=longest,menuone

" Fold options
" ========================================
"augroup remember_folds
	"autocmd!
	"autocmd BufWinLeave ?* mkview 1
	"autocmd BufWinLeave ?* silent loadview 1
"augroup END
set foldmethod=manual			" manual indent syntax expr marker diff
"set foldmarker={{{,}}}			" defaults
set foldlevel=2					" start with some folds open
set foldlevelstart=2			" show fold level as default
"set foldnestmax=10
"set nofoldenable

" AUTOCMDS
" ==============
"autocmd BufWritePost * call system("ctags -R")
"autocmd HTMLfileEdit :setlocal foldmethod=syntax
" Remember elixir Filetypes

" MAPPINGS
" ==============
let mapleader = "\<Space>"

" Insert mode
imap <C-d> <Del>
imap <C-u> <Nop>
imap <C-f> <right>
"imap <C-a> <home>
imap <C-e> <end>

" Command line 
cmap <C-a> <home>
cmap <C-d> <Del>

" insert line and stay in Normal mode 
nnoremap <Leader>O moO<Esc>`o
nnoremap <Leader>o moo<Esc>`o

" [c]trl / Ctrl (soft keyboard)
"inoremap <Leader>cc <C-[>
nnoremap <Leader>cb <C-b>
nnoremap <Leader>cf <C-f>
" copy to buffer
vmap <C-c> :w! ~/tmp/.vimbuffer<CR>
nmap <C-c> :w! ~/tmp/.vimbuffer<CR>
" paste from buffer
inoremap <C-v> :r ~/tmp/.vimbuffer<CR>
" open new tab
noremap <C-t> :tabnew<CR>

"  [t]erminal / Terminal
noremap <Leader>td :bd!%<CR>
noremap <Leader>ts <C-w>s :terminal<CR>
noremap <Leader>tv <C-w>v :terminal<CR>
noremap <Leader>t. :terminal<CR>
" Terminal window navigation
tnoremap <Esc> <C-\><C-n>
tnoremap <C-[> <C-\><C-n>
tnoremap <C-w>q <C-\><C-n><C-w>q
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Elm
" <LocalLeader>t " Elm: Run the tests of the current buffer or 'tests/TestRunner'
" <LocalLeader>r " Elm: Opens an elm repl in a subprocess
" <LocalLeader>w " Elm: Opens the docs web page for the word under the cursor
" <LocalLeader>b " Elm: Compile the Main.elm file in the project
" <LocalLeader>d " Elm: Shows the type and docs for the word under the cursor
" <LocalLeader>e " Elm: Shows the detail of the current error or warning
" <LocalLeader>m " Elm: Compile the current buffer

" Start visual mode (eg. vipga)
xmap ga <Plug>(EasyAlign)
" Start motion/text object mode (eg. gaip)
nmap ga <Plug>(EasyAlign)

" [s]ystem System stuff
noremap <Leader>sS :e ~/.local/share/nvim/swap<CR>
noremap <Leader>s~ :e ~/.config/nvim/init.vim<CR>
noremap <Leader>sc :call ToggleColors()<CR>
noremap <Leader>sn :cnext<CR>
noremap <Leader>sp :cprev<CR>
noremap <Leader>st :pu=strftime('%c')<CR>
noremap <Leader>sv :loadview<CR>

" [b]uffer / Buffer
noremap <Leader>bd :bp<CR>:bdelete #<CR>
noremap <Leader>bl :ls<CR>:b
noremap gn :bn<CR>
noremap gp :bp<CR>
noremap <Leader>bx :%bd \| e#<CR>
noremap <Leader>bz :call CleanEmptyBuffers()<CR>

function! s:CleanEmptyBuffers()
	let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
	if !empty(buffers)
		exe 'bw ' . join(buffers, ' ')
	endif
endfunction

" [f]ile / File
map <Leader>ft :NERDTreeToggle<CR>
map <Leader>fb :NERDTreeFind<CR>
noremap <Leader>fo :e 
noremap <Leader>fc :q
noremap <Leader>fs :w<CR>
" copy file path to register
noremap <Leader>fp :let @" = expand("%")<cr>

" [g]it / Git
map <Leader>gv :GV<CR>
" Open fugitive in a new tab
map <Leader>gs :Gstatus<CR><C-w>T

" [w]iki / Wiki
nmap <Leader>wb :VimwikiGoBackLink<CR>
nmap <Leader>wx :VimwikiToggleListItem<CR>

" [C-w]indow / Window
noremap <up> :resize -5<CR>
noremap <down> :resize +5<CR>
noremap <left> :vertical resize -5<CR>
noremap <right> :vertical resize +5<CR>
" remap resize to expand window height
noremap <C-w>- <C-w>_
" remap resize to expand window width
noremap <C-w><Bslash> <C-w><Bar>
" delete buffer when not using :close
"noremap <C-w>q :bd %<CR>

" FUNCTION KEYS
" =================

" map <F1>		" system: help documentation
" map <F10>		" system: command menu activation

" COLORS
" ==============
" gruvbox 
" let g:gruvbox_italic=1 " load before colorscheme

" seoul256
colorscheme seoul256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1	" true color support

"hi Normal guibg=NONE ctermbg=NONE	" transparent-bg


" Dim inactive window
"hi def Dim cterm=none ctermbg=none ctermfg=LightGray

"function! s:DimInactiveWindow()
    "syntax region Dim start='' end='$$$end$$$'
"endfunction

"function! s:UndimActiveWindow()
    "ownsyntax
"endfunction

"autocmd WinEnter * call s:UndimActiveWindow()
"autocmd BufEnter * call s:UndimActiveWindow()
"autocmd WinLeave * call s:DimInactiveWindow()

" MARKDOWN
" ==============
"autocmd BufNewFile,BufRead *.md set spell | set lbr | set nonu
"let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']

" PLUGS
call plug#begin()
" INPUTS
" ====================
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround' " yes S
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'

"Plug 'davidhalter/jedi-vim' " code jump (go-to)
"Plug 'terryma/vim-multiple-cursors' " looks cool
"Plug 'jszameister/vim-togglecursor'
"Plug 'tmhedberg/SimpylFold'
"Plug 'terryma/vim-smooth-scroll' != terminal
"Plug 'christoomey/vim-tmux-navigator' != C-<hjkl>

" VISUALS
" ====================
Plug 'machakann/vim-highlightedyank' " very nice
let g:highlightedyank_highlight_duration = 3000

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='deus'

" INTERACTION
" ====================
Plug 'elixir-editors/vim-elixir' " code highlighting
Plug 'urbit/hoon.vim' " rtfm for autocomplete, syntax checking and rune snippets
Plug 'neomake/neomake' " mostly for the shellscript checking

"Plug 'slashmili/alchemist.vim' " not sure if necessary?
"Plug 'ctrlpvim/ctrlp.vim'
"let g:ctrlp_map = ''
Plug 'scrooloose/nerdcommenter'
"Plug 'sheerun/vim-polyglot'

" APPLICATIONS
" ====================
" vimwiki and calendar https://blog.mague.com/?p=602
"Plug 'mattn/calendar-vim' " for vimwiki

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '/home/$USER/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr' " Yisss, enable folding
let g:markdown_folding = 1 
"let g:vimwiki_list = [{'path': '/home/$USER/wikitest/'}]

Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1
" let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeArrows = 1
"autocmd VimEnter * if (0 == argc()) | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'tpope/vim-fugitive' " git, like a boss
Plug 'junegunn/gv.vim' " git log, like a boss

"Plug 'TweetVim' " this would be amazing
"Plug 'webapi-vim' " web surfing in vim, yes please

call plug#end()
call neomake#configure#automake('w') " When writing a buffer (no delay).

" SNIPPETS
" =================
" Read an empty HTML template and move cursor to title 
" '-1' moves the line up
" use 'gf' to jump to file
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
nnoremap ,dmod :-1read $HOME/.config/nvim/snippets/elixir.dmod<CR>ela
nnoremap ,def :-1read $HOME/.config/nvim/snippets/elixir.def<CR>ela
