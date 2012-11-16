#PDF version
pandoc -s --toc --latex-engine=xelatex --template=latex.template.tex -N \
	--variable=version:alpha \
	--variable=monofont:Consolas \
	--variable=mainfont:Georgia \
	--variable=sansfont:Georgia \
	--variable=paper:a4paper \
	--variable=hmargin:3cm \
	--variable=vmargin:3cm \
	--variable=geometry:portrait \
	--variable=nohyphenation:true \
	--variable=author-meta:"Philippe Charrière" \
	--variable=title-meta$:"TYPESCRIPT ROCKS" \
	-o backbone.en.douceur.pdf \
	00-PREAMBULE.md \
	01-PRESENTATION.md \
	02-MAINS-DANS-LE-CAMBOUIS.md \
	03-1ERS-CONTACTS-AVEC-BACKBONE.md \
	04-LE-MODELE-OBJET-DE-BACKBONE.md

