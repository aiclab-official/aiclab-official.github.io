# Jekyll server

## Install dependencies

```bash
bundle install
```

## Run the Jekyll server

```bash
bundle exec jekyll serve
```

# Copying HTML-formatted content from a Markdown file to the clipboard 

```bash
pandoc -f markdown -t html5 File.md | xclip -selection clipboard -t text/html
```

# Code

Using a tool like [Carbon](https://carbon.now.sh), [Ray.so](https://ray.so), or [Snappify.io] to create a **code snippet image**.

# Exporting a post as PDF

`_scripts/post-pdf.sh` prints a post to an A4 PDF with headless Chrome. Links stay clickable, the headings become PDF bookmarks, and every page has the post title, link, and page number in the footer. The print styles are in `assets/css/main.scss` (print section) and `_includes/head/custom.html` (`@page` footer).

1. Render the **live** post, so that every link in the PDF points to aic-lab.com:

   ```bash
   _scripts/post-pdf.sh https://aic-lab.com/rtl/learn-fpga/
   ```

   This writes `assets/pdf/learn-fpga.pdf`, named after the last part of the URL. To check the layout before publishing, render the local server instead (`_scripts/post-pdf.sh http://localhost:4000/rtl/learn-fpga/ /tmp/draft.pdf`). Its links point to localhost, so don't publish that file.

2. Check the PDF, then look through the pages for gaps or cut-off images:

   ```bash
   pdfinfo -url assets/pdf/learn-fpga.pdf | grep -c localhost   # expect 0
   pdftotext assets/pdf/learn-fpga.pdf - | grep -c '(https://'   # expect 0, no printed URLs
   mutool show assets/pdf/learn-fpga.pdf outline | head          # bookmarks
   ```

3. Add the download button to the post, and commit it together with the PDF:

   ```liquid
   {% include pdf-download.html src="/assets/pdf/learn-fpga.pdf" %}
   ```

   The button only appears once the file exists, and it is hidden in print.

Regenerate and recommit the PDF whenever you change the post.

Without the script: open the post in Chrome, press Ctrl+P, choose "Save as PDF", and untick "Headers and footers". You get the same PDF without bookmarks.

## Sharing the PDF on LinkedIn

- Post it as a document: Start a post → document icon → upload the PDF → give it a title. LinkedIn shows the pages as a carousel, and page 1 is what people see in the feed.
- Links inside the PDF are not reliably clickable in LinkedIn's viewer, especially on mobile. Readers who download the PDF (full screen → Download) get working links. Put the post URL in the caption or the first comment.
- You can't replace the document after posting, so check it first.
- A shared post URL gets its preview image from `header.teaser`; 1200 x 630 fits LinkedIn's link preview. [Post Inspector](https://www.linkedin.com/post-inspector/) refreshes a cached preview.


# Posts Organization

This directory contains all blog posts organized by topic in subdirectories:

## Subdirectories

### `systemverilog/`
Contains posts about SystemVerilog, FPGA, ASIC design, and related digital design topics.

### `sta/`
Contains posts about Static Timing Analysis (STA), timing constraints, and timing closure.

## Adding New Posts

When creating new posts:

1. **SystemVerilog posts**: Place in `_posts/systemverilog/`
2. **STA posts**: Place in `_posts/sta/`
3. **New topics**: Create a new subdirectory (e.g., `_posts/verification/`, `_posts/uvm/`, etc.)

## File Naming Convention

All posts should follow Jekyll's naming convention:
```
YYYY-MM-DD-title-with-hyphens.md
```

## Front Matter

Ensure each post has proper front matter with:
- `title`: Post title
- `date`: Publication date
- `categories`: Main category (e.g., SystemVerilog, STA)
- `tags`: Relevant tags
- `excerpt`: Brief description for homepage display
- `header.teaser`: Path to teaser image

Example:
```yaml
---
title: "Your Post Title"
date: 2025-05-26
categories:
  - SystemVerilog
tags:
  - FPGA
  - RTL
excerpt: "Brief description of the post content..."
header:
  teaser: /assets/images/your-image.png
---
```
