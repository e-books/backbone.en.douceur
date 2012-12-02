#HTML version
pandoc -s --toc --highlight-style pygments -c style.css -N -o backbone.en.douceur.html \
	00-PREAMBULE.md \
	01-PRESENTATION.md \
	02-MAINS-DANS-LE-CAMBOUIS.md \
	03-1ERS-CONTACTS-AVEC-BACKBONE.md \
	04-LE-MODELE-OBJET-DE-BACKBONE.md \
	05-IL-NOUS-FAUT-UN-SERVEUR.md \
	06-MODELES-ET-COLLECTIONS.md \
	07-VUES-ET-TEMPLATING.md \
	08-ROUTEUR.md \
	09-ORGANISATION-CODE.md \
	10-SECURISATION.md \
	11-BACKBONE-SYNC.md \
	12-BB-COFFEESCRIPT.md

#PDF version
pandoc -s --toc --latex-engine=xelatex --template=latex.template.tex -N \
	--variable=version:"alpha du 2.12.2012 | Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License." \
	--variable=monofont:Consolas \
	--variable=mainfont:Georgia \
	--variable fontsize=12pt \
	--variable=sansfont:Georgia \
	--variable=paper:a4paper \
	--variable=hmargin:2cm \
	--variable=vmargin:2cm \
	--variable=geometry:portrait \
	--variable=nohyphenation:true \
	--variable=author-meta:"Philippe Charrière" \
	--variable=title-meta$:"Backbone.en.douceur" \
	-o backbone.en.douceur.pdf \
	00-PREAMBULE.md \
	01-PRESENTATION.md \
	02-MAINS-DANS-LE-CAMBOUIS.md \
	03-1ERS-CONTACTS-AVEC-BACKBONE.md \
	04-LE-MODELE-OBJET-DE-BACKBONE.md \
	05-IL-NOUS-FAUT-UN-SERVEUR.md \
	06-MODELES-ET-COLLECTIONS.md \
	07-VUES-ET-TEMPLATING.md \
	08-ROUTEUR.md \
	09-ORGANISATION-CODE.md \
	10-SECURISATION.md \
	11-BACKBONE-SYNC.md \
	12-BB-COFFEESCRIPT.md


#Epub version
pandoc -S --epub-metadata=epub-metadata.xml -o backbone.en.douceur.epub \
	epub-title.txt \
	00-PREAMBULE.md \
	01-PRESENTATION.md \
	02-MAINS-DANS-LE-CAMBOUIS.md \
	03-1ERS-CONTACTS-AVEC-BACKBONE.md \
	04-LE-MODELE-OBJET-DE-BACKBONE.md \
	05-IL-NOUS-FAUT-UN-SERVEUR.md \
	06-MODELES-ET-COLLECTIONS.md \
	07-VUES-ET-TEMPLATING.md \
	08-ROUTEUR.md \
	09-ORGANISATION-CODE.md \
	10-SECURISATION.md \
	11-BACKBONE-SYNC.md \
	12-BB-COFFEESCRIPT.md

