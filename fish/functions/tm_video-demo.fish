function tm_video-demo -d 'Prepare demo videos'
    set f $argv[1]
    set imageP ~/"Downloads/VideoTitlesPNG/"
    set demoP ~/"Documents/Project - Podcast/Demo Videos/"

    set name (echo "$f" | sed 's/\.[^.]*$//')
    set ext (echo "$f" | sed 's/.*\.//')

    if test $ext != "wav"
        set_color -o red
        echo 'Not wav file' $f
        set_color normal
        return
    end

    for i in (seq 1 100)
        set afr "$name "$i
        set af $afr.wav
        set imagef "$imageP$afr".png
        if test -f "$af" && test -f "$imagef"
            set_color yellow
            echo 'Found' $af $imagef
            echo "Converting to m4a"

            set_color -b white
            set_color -o red
            printf 'Convert wav to m4a'
            set_color normal
			printf '\n'

            ffmpeg -i "$af" -c:a libfdk_aac -b:a 32k -movflags +faststart "$afr".m4a

            set_color -b white
            set_color -o red
            printf 'Add Audio to Video'
            set_color normal
			printf '\n'

            ffmpeg -i "$demoP$i".mp4  -i "$afr".m4a -codec copy -shortest "$afr".avi
            
            set_color -b white
            set_color -o red
            printf 'Add Image to Video'
            set_color normal
			printf '\n'

            ffmpeg -i "$afr".avi -i "$imagef" -filter_complex "[0:v][1:v] overlay=0:0" -pix_fmt yuv420p -c:a copy "$afr".mp4

            set_color -b white
            set_color -o red
            printf 'Reduce Video Size'
            set_color normal
			printf '\n'

            HandBrakeCLI --preset-import-file ~/Dropbox/Podcast\ Project/HandBrake\ Presets/WhatsApp.json -Z "WhatsApp" -i "$afr".mp4 -o "$afr"-WhatsApp.mp4

            set_color -b white
            set_color -o red
            printf 'Remove intermediate files'
            set_color normal
			printf '\n'

            trash "$afr".mp4
            trash "$afr".avi
            trash "$afr".m4a

        else
            set_color -o red
            echo 'Not found' $af $imagef
            break;
        end
    end

    say "Done"
    set_color normal
end

