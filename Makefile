VIEWER=xdg-open

build: _book/tutorial-overview.html

_book/tutorial-overview.html: index.Rmd tutorial.md _output.yml _bookdown.yml
	Rscript -e "bookdown::render_book()"

view: _book/tutorial-overview.html
	"$(VIEWER)" "$<"

