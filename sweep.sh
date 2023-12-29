#!/opt/homebrew/share/man/man1/bash.1

directory="$HOME/Downloads"
imgpath="$HOME/Downloads/Images"
docpath="$HOME/Downloads/Docs"
miscpath="$HOME/Downloads/Misc"
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
        filepath="$1/$filename"
        if [[ -d "$filepath" ]]; then
            continue
        fi
        fileformat=$(file -I "$filepath" | awk -F '[:;]' '{print $2}' | tr -d '[:space:]')
        if [[ $(echo $fileformat | cut -f 1 -d '/') == "image" ]];then
            if [[ "$1" != "$imgpath" ]]; then
                mv "$filepath" "$imgpath"
            fi
        elif [[ $fileformat == "application/pdf" ]];then #TODO add more file formats
            if [[ "$1" != "$docpath" ]]; then
                mv "$filepath" "$docpath"
            fi
        else
            if [[ "$1" != "$miscpath" ]]; then
                mv "$filepath" "$miscpath"
            fi
        fi
    done < <(ls $1)  # Change the find command options as needed
}

sweepdir "$directory"
sweepdir "$imgpath"
sweepdir "$docpath"
sweepdir "$miscpath"


