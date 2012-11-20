#Vues & Templating

>*Sommaire*

>>- *1ère vue*
>>- *Mise à jour automatique de l’affichage*
>>- *Sous-vues*
>>- *Templating*
>>- *évènements*

>*Nous avons joué avec les données dans le chapitre précédent, nous allons maintenant voir comment les afficher dynamiquement dans notre page web.*


Le composant View de Backbone est peut-être celui qui génère le plus de polémiques. Est-ce vraiment une vue ? Ne serait-ce pas plutôt un contrôleur ? Il se trouve que dans une version plus ancienne de Backbone, le composant Controller existait, aujourd’hui il est le devenu le composant Router que nous verrons par la suite … Cependant, un routeur est-il réellement un contrôleur ?... Mais, rappelez-vous que l’on est dans un contexte client (navigateur) et que le concept MVC « classique » n’est pas forcément « portable » en l’état. L’essentiel est que cela fonctionne, et si les contrôleurs vous manquent à ce point, nous verrons comment en créer quelques chapitres plus loin.

	//En préparation, un peu de patience ...