# Alfred Evernote Helpers

Small helpers for Evernote I'll create over time, currently only one helper
to export all images attached to the currently opened note (e.g. scanned through the Evernote mobile app)
as a PDF document.

## Installation

Just download the alfred workflow file and open it to install it.

## Helpers

### `evernote-attachments-pdf`

Creates a PDF file from all images attached to the currently opened node.  
I created this as just printing the note to PDF lead to 2 side effects I didn't want:

1. The note title would still be printed
2. Evernote would add additional whitespace margin to each page, making the text smaller than it had to be.

**Variables**

`CONVERT_PATH`  
To create the PDF document, you'll need `imagemagick` installed on your machine which comes with the `convert` command line tool.  
Usually, it will reside in `/usr/local/bin`, but you can change that path if needed.

`PDF_OUTPUT_FOLDER`  
The directory the workflow will put the generated PDFs in

`REVEIL_IN_FINDER`  
Can be either `true` or `false`. If set to `true`, Finder is opened
after creation