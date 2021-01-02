# `evernote-attachments-pdf`

Simple helper workflow to export all attachments in a note as a single PDF file.

Background: I use Evernote mostly as a document storage and the mobile app
to scan various documents. Doing so creates a new note with each individual scanned
page as image and none of the integrated methods of converting them to a single PDF worked for me:

1. The note title would still be printed
2. Evernote would add additional whitespace margin to each page, making the text smaller than it had to be.

See [this blog post](https://stex.codes/programming/2020/09/02/evernote-attachment-workflow.html) for more information about the problem.

**Note**: There is currently still a problem with notes that include PDF files.
Even though the PDF files are written to disk, `convert` isn't able to properly use them.  
When calling the `convert` command manually afterwards, everything works as expected. Do the files need some time to settle down
or are they not available to the current process?  
Not sure what's going on there.

## Installation

Just download the alfred workflow file and open it to install it.

Since the Evernote export format changed quite a bit, I needed a proper XML parser this time, meaning that the workflow depends on a gem (ox).

I set up the script to use `/usr/bin/ruby` instead of `/usr/bin/env ruby` as this would resolve to a Ruby version buried somewhere deep inside macOS. This way, we know for sure which version is used, so it's easier to install the necessary gem.

There are 2 ways to install `ox` for this version of ruby:

1. Install it via the `gem` executable (not the preferred way as you'll need `sudo`)

```ruby
sudo /usr/bin/gem install ox
```

2. Use a local `bundle` (preferred)
    1. Open the workflow folder by right-clicking on the workflow name in Alfred and choosing "Open in Terminal"
    2. Run `/usr/bin/bundle install --standalone`

This will install the necessary gem inside the workflow directory without adding it to your system gems.

## Variables

`CONVERT_PATH`  
To create the PDF document, you'll need `imagemagick` installed on your machine which comes with the `convert` command line tool.  
Usually, it will reside in `/usr/local/bin`, but you can change that path if needed.

`PDF_OUTPUT_FOLDER`  
The directory the workflow will put the generated PDFs in

`REVEIL_IN_FINDER`  
Can be either `true` or `false`. If set to `true`, Finder is opened
after creation
