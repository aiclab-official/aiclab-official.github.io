# Posts Organization

This directory contains all blog posts organized by topic in subdirectories:


## Copying HTML-formatted content from a Markdown file to the clipboard 

```bash
pandoc -f markdown -t html5 File.md | xclip -selection clipboard -t text/html
```

## Code

Using a tool like [Carbon](https://carbon.now.sh), [Ray.so](https://ray.so), or [Snappify.io] to create a **code snippet image**.

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
