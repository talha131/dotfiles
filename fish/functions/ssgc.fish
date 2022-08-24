function ssgc -d 'Download and backup SSGC bills'
   # create temp dir
   set temp (gmktemp -d)
   echo $temp
   set temp_file (gmktemp -p $temp)
   # pushd $temp

   for bill in (cat ~/.local/share/tm-ssgc/bills.txt)
      set entry (echo $bill | gsed 's/,/\n/g')
      set pdf_url (http --form POST "https://viewbill.ssgc.com.pk/web/bill.php" b=$entry[1] | rg -o billpdfs\/gasbill[0-9_]\+.pdf)
      set download_url (echo $pdf_url |gsed 's/^/https:\/\/viewbill.ssgc.com.pk\/web\//')

      # download file
      http -d $download_url
      tm_printMessage "file downloaded"
      # upload file
      set file (tm_split_path $pdf_url)
      rclone -v copy "$file[1].$file[2]" pcloud:$entry[2]
      tm_printMessage "file uploaded"

      if test $entry[3] = 1
         tm_printMessage "convert to text"
         pdftotext $file[1].$file[2]
         gsed '0,/^CURRENT READING$/d' $file[1].txt > $file[1]-.txt
         echo "*$entry[4]*" >> $temp_file
         echo "میٹر پڑھا گیا: " >> $temp_file
         echo (gsed -n 4p $file[1]-.txt) >> $temp_file
         echo "میٹر ریڈنگ: " >> $temp_file
         echo (gsed -n 8p $file[1]-.txt) >> $temp_file
         echo "یونٹ: " >> $temp_file
         echo (gsed -n 14p $file[1]-.txt) >> $temp_file
         echo \n >> $temp_file
      end
   end

   cat $temp_file | pbcopy
   tm_printSuccess "Text copied to the clipboard"
   # switch back
   open $temp
   # popd
end
