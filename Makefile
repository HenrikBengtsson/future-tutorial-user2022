VIEWER=xdg-open

build: docs/index.html

docs/index.html: index.md _output.yml _bookdown.yml
	Rscript -e 'bookdown::render_book("index.md", output_format = bookdown::gitbook())'

view: docs/index.html
	"$(VIEWER)" "$<"

spelling:
	Rscript -e "spelling::spell_check_files(c('README.md', 'index.md'), ignore=readLines('WORDLIST', warn=FALSE))"
