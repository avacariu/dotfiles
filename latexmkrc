$pdf_previewer = "start evince";
$pdf_update_method = 0;

if (defined ${'TEXINPUTS'}) {
    $ENV{'TEXINPUTS'}='~/dotfiles/texmf//:' . $ENV{'TEXINPUTS'};
} else {
    $ENV{'TEXINPUTS'}='~/dotfiles/texmf//:';
}

# .bbl files assumed to be regeneratable, safe as long as the .bib file is available
$bibtex_use = 2;
# User biber instead of bibtex
$biber = 'biber --debug %O %S';
# Extra file extensions to clean when latexmk -c or latexmk -C is used
$clean_ext = '%R.run.xml %R.synctex.gz';
