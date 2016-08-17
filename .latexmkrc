$pdf_previewer = "start xpdf -remote %R %O %S";
$pdf_update_method = 4;
$pdf_update_command = "xpdf -remote %R -reload";

add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
        system("makeindex -s '$_[0]'.ist -t '$_[0]'.glg -o '$_[0]'.gls '$_[0]'.glo");
}

$pdflatex = 'pdflatex --shell-escape %O %S';
