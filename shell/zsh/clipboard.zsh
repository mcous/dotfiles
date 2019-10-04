# linux pbcopy and pbpaste
command -v pbcopy >/dev/null 2>&1 || alias pbcopy='xclip -selection clipboard'
command -v pbpaste >/dev/null 2>&1 || alias pbpaste='xclip -selection clipboard -o'
