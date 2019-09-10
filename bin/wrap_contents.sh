stem=$2
header="${stem}_header.html"
footer="${stem}_footer.html"

cat $header $1 $footer > "$3"
