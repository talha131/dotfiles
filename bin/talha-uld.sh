#!/bin/bash
echo "Uploading published HTML files to Dropbox"

rsync -vauP --stats ~/Repos/org-notes/publish/*.html ~/Dropbox/Notes/
rsync -vauP --stats ~/Repos/org-notes/publish/css ~/Dropbox/Notes/

echo "Execution completed"
