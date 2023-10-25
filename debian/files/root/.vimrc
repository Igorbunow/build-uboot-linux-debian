set laststatus=2   " всегда показывать строку статуса
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,cp1251,cp866,koi8-r,ucs-2le,ucs-2be,iso-8859-2,8bit-cp855,ucs-bom

set tabstop=2 

" Время обновления окна = 0 миллисекунд ()делаем из vim "редактор реального
" времени")
set updatetime=0

syntax on

" Исправление отступов после вставки gpm'ом (и т.п.)
inoremap u:set paste.:set nopastegi

" Копирование/вставка в/из буфер обмена X
" " (этот буфер называется +)
"map "+y
"map "+p
"
" " Автозавершение скобок
"imap { {}
"imap [ []
"imap ( ()

"<F4> Find&Replace 
set  wildmenu
set  wcm=<Tab>
menu FR.LightF          :set hls!<CR>
menu FR.RegUnd          :set ic!<CR>
menu FR.FindForw        :/
menu FR.FindBack        :?
menu FR.RedoFF          n<CR>
menu FR.RedoFB          N<CR>
map  <F4> :emenu FR.<Tab>

nmap <F5> byei<<ESC>ea></<C-R>0><ESC>

"<F7> EOL format (dos <CR><NL>,unix <NL>,mac <CR>) 
set  wildmenu
set  wcm=<Tab>
menu EOL.unix :set fileformat=unix<CR>
menu EOL.dos  :set fileformat=dos<CR>
menu EOL.mac  :set fileformat=mac<CR>
map  <F7> :emenu EOL.<Tab>

"<F8> Change encoding 
set  wildmenu
set  wcm=<Tab>
menu Enc.utf-8       :e ++enc=utf-8<CR>
menu Enc.ucs-bom     :e ++enc=ucs-bom<CR>
menu Enc.cp1251      :e ++enc=cp1251<CR>
menu Enc.koi8-r      :e ++enc=koi8-r<CR>
menu Enc.cp866       :e ++enc=ibm866<CR>
menu Enc.8bit-cp855  :e ++enc=8bit-cp855<CR>
menu Enc.ucs-2le     :e ++enc=ucs-2le<CR>
menu Enc.ucs-2be     :e ++enc=ucs-2be<CR>
menu Enc.ucs-2       :e ++enc=ucs-2<CR>
menu Enc.ucs-4       :e ++enc=utf-32<CR>
menu Enc.ucs-4be     :e ++enc=ucs-4be<CR>
menu Enc.ucs-4le     :e ++enc=utf-32le<CR>
menu Enc.iso-8859-2  :e ++enc=iso-8859-2<CR>
map  <F8> :emenu Enc.<Tab>

"<Shift+F8> Convert file encoding 
set  wildmenu
set  wcm=<Tab>
menu FEnc.utf-8      :set fenc=utf-8<CR>
menu FEnc.ucs-bom    :set fenc=ucs-bom<CR>
menu FEnc.cp1251     :set fenc=cp1251<CR>
menu FEnc.koi8-r     :set fenc=koi8-r<CR>
menu FEnc.cp866      :set fenc=ibm866<CR>
menu FEnc.8bit-cp855 :set fenc=8bit-cp855<CR>
menu FEnc.ucs-2le    :set fenc=ucs-2le<CR>
menu FEnc.ucs-2be    :set fenc=ucs-2be<CR>
menu FEnc.iso-8859-2 :set fenc=iso-8859-2<CR>
map  <S-F8> :emenu FEnc.<Tab>
"
"
""<F12> Coding 
set  wildmenu
set  wcm=<Tab>
menu Coding.Make          :make<CR>
menu Coding.NextErr       :cn<CR>
menu Coding.PrivErr       :cp<CR>
menu Coding.ErrList       :cl!<CR>
menu Coding.ToHex         :%!xxd<CR>
menu Coding.FromHex       :%!xxd -r<CR>
menu Coding.SringNum      :set nu!<CR>
menu Coding.ShowHidS      :set list!<CR>
menu Coding.CStyle        :set cin!<CR>
menu Coding.TransfenStr   :set wrap!<CR>
menu Coding.SpacesExTab   :set et!<CR>
map  <F12> :emenu Coding.<Tab>

"<F10> Exit 
set  wildmenu
set  wcm=<Tab>
menu Exit.Exit_         :q<CR>
menu Exit.ExitAndSave   :wq<CR>
menu Exit.ExitNotSave   :q!<CR>
map  <F10> :emenu Exit.<Tab>

set  wildmenu
set  wcm=<Tab>
menu Ed.Undo         :u<CR>
menu Ed.Redo         :redo<CR>
menu Ed.Insert       "+gP<CR>
menu Ed.Copy         "+y
menu Ed.Cut          "+x
map  <F3> :emenu Ed.<Tab>

"<F2> Save 
set  wildmenu
set  wcm=<Tab>
menu Sv.Save            :w<CR>
menu Sv.ForseSave       :w!<CR>
menu Sv.SaveAs          :sav
map  <F2> :emenu Sv.<Tab>

" CTRL-Tab is Next tab
nmap <C-F12> :tabnext<CR>
nmap <C-F11> :tabprevious<CR>
nmap <C-F10> :tabnew<CR>


" CTRL-Shift-Tab is Previous tab
"nnoremap <C-S-Tab> :tabprevious<CR>
"
" Tab is Next window
nnoremap <Tab> <C-W>w

" Shift-Tab is Previous window
" nnoremap <S-Tab> <C-W>W
"
nnoremap <C-F5> :NERDTree<cr>
nnoremap <C-F6> :NERDTreeClose<cr>

"nnoremap <C-F6> :TlistToggle<cr>
