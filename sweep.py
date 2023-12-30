import os
from pathlib import Path
import mimetypes
import shutil

DOWNLOADS = "Downloads"
MISC = "Misc"
MEDIA = "Media"
DOCS = "Docs"

DOCFILE = [
    "application/pdf",
    "text/plain",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]

MEDIAFILE = [
    "image/jpeg",
    "image/png",
    "video/mp4",
    "audio/mp3",
    "audio/x-wav",
]

def sweep_files(dir: str, downloads_dir)-> None:
    absolute_paths = [os.path.join(dir, f) for f in os.listdir(dir) if not f.startswith('.')]
    for item in absolute_paths:
        if os.path.isfile(item):
            mimetype = mimetypes.guess_type(item)[0]
            if mimetype in DOCFILE:
                if not os.path.exists(f"{downloads_dir}/{DOCS}"):
                    os.mkdir(f"{downloads_dir}/{DOCS}")
                if dir == f"{downloads_dir}/{DOCS}":
                    continue
                shutil.move(item, f"{downloads_dir}/{DOCS}")
            elif mimetype in MEDIAFILE:
                if not os.path.exists(f"{downloads_dir}/{MEDIA}"):
                    os.mkdir(f"{downloads_dir}/{MEDIA}")
                if dir == f"{downloads_dir}/{MEDIA}":
                    continue
                shutil.move(item, f"{downloads_dir}/{MEDIA}")
            else:
                if not os.path.exists(f"{downloads_dir}/{MISC}"):
                    os.mkdir(f"{downloads_dir}/{MISC}")
                if dir == f"{downloads_dir}/{MISC}":
                    continue
                shutil.move(item, f"{downloads_dir}/{MISC}")
            
def main():
    downloads_dir = str(Path.home() / "Downloads")
    subdirs = [f"{downloads_dir}/{DOCS}",
               f"{downloads_dir}/{MEDIA}",
               f"{downloads_dir}/{MISC}"]
    for subdir in subdirs:
        if not os.path.exists(subdir):
            os.mkdir(subdir)
    sweep_files(downloads_dir, downloads_dir)
    for subdir in subdirs:
        sweep_files(subdir, downloads_dir)

if __name__ == "__main__":
    main()