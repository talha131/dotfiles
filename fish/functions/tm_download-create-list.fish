# WIP. This function is for downloading files in seq
# It checks URL. If it is present then it is written to success.txt
#
# You can later download the files in parallel using
# parallel --jobs 4 < success.txt
for i in (seq -w 1 114)
    set url "http://media.midad.com/ar/recitations//666/35063/56/$i.mp3"
    tm_printMessage "testing $url"
    wget --spider $url 2> /dev/null
    if test $status = 0
        tm_printSuccess "Success"
        echo "wget \"$url\"" >> success.txt
    else
        tm_printWarning "Failed"
        echo "wget \"$url\"" >> failed.txt
    end
end

