function! CompileMarkdown(open_pdf)
   let cur_file = expand('%:p')
   let pdf_folder = $NOTES_FOLDER_PDF
   let file_root = expand('%:t:r')
   write

   let instruction = "! pandoc " . cur_file .
               \ " -f markdown -t latex -s --toc -V geometry:margin=1in -o " .
               \ pdf_folder . file_root . ".pdf"

   if a:open_pdf == 1
       let instruction = instruction . " && evince " . pdf_folder . file_root . ".pdf &" 
   endif

   silent !clear
   execute instruction

endfun

map <Leader>lp :call CompileMarkdown(1)<CR>
map <Leader>ll :call CompileMarkdown(0)<CR>
