$pdf_previewer = "start evince";
$pdf_update_method = 0;

if (defined ${'TEXINPUTS'}) {
    $ENV{'TEXINPUTS'}='~/dotfiles/texmf//:' . $ENV{'TEXINPUTS'};
} else {
    $ENV{'TEXINPUTS'}='~/dotfiles/texmf//:';
}
