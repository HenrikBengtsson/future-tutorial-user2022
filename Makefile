VIEWER=xdg-open

build: docs/index.html

docs/index.html: index.md _output.yml _bookdown.yml
	Rscript -e 'bookdown::render_book("index.md", output_format = bookdown::gitbook())'

view: docs/index.html
	"$(VIEWER)" "$<"

