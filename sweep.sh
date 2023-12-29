directory="/Users/bober/Downloads"
imgpath="/Users/bober/Downloads/Images"
docpath="/Users/bober/Downloads/Docs"
miscpath="/Users/bober/Downloads/Misc"
ignored=""

if [ ! -d "$imgpath" ]; then
    mkdir $imgpath
fi

if [ ! -d "$docpath" ]; then
    mkdir $docpath
fi

if [ ! -d "$miscpath" ]; then
    mkdir $miscpath
fi

sweepdir() {
    while IFS="\n" read -r filename; do
        # Perform operations on each file (replace this with your desired action)
        if [[ $filename == .* ]]; then
            echo $filename
            continue
        fi
        filepath="$directory/$filename"
        if [[ -d "$filepath" ]]; then
            continue
        fi
        fileformat=$(file -I "$filepath" | awk -F '[:;]' '{print $2}')
        if [[ $(echo $fileformat | cut -f 1 -d '/') == "image" ]];then
            mv "$filepath" "$imgpath"
        elif [[ $(echo $fileformat | cut -f 1 -d '/') == "text" ]];then #TODO add more file formats
            mv "$filepath" "$docpath"
        else
            mv "$filepath" "$miscpath"
            
        fi
    done < <(ls $1)  # Change the find command options as needed
}

sweepdir "$directory"
sweepdir "$imgpath"
sweepdir "$docpath"


