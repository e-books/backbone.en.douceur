#Backbone <3 Coffeescript

>*Sommaire*

>>- *Coffeescript*
>>- *On s'outille*
>>- *Traduction*


>*Depuis longtemps, les développeurs “serveur” ont de nombreux a priori vis-à-vis de Javascript : un modèle objet “particulier” difficile à comprendre après des années de programmation orientée classes,  un système d’héritage par prototype générant beaucoup d’effets de bord s’il n’est pas maîtrisé (sans compter la maintenabilité du code) et justement pas de classes en javascript, ce qui rend difficile l’organisation du code (toujours d’un point de vue approche “classique”).*

L’arrivée de CoffeeScript tend aujourd’hui à gommer ces problématiques et tout particulièrement par l’introduction d’un système de classes qui prend en charge (pour/à la place du développeur) toutes les problématiques liées au modèle objet Javascript, garantissant ainsi la réduction de l’apparition de bugs dus à la méconnaissance de javascript. Gardez cependant une chose à l’esprit : Coffeescript, cela reste du Javascript, mais avec une manière différente de l’écrire, plus simple, plus efficace et (à mon avis) avec moins d’erreurs. Coffeescript, vous aidera aussi à comprendre et mieux écrire le Javascript.

##Coffeescript qu’est-ce que c’est ?

Coffeescript est un langage de script qui ressemble beaucoup au Python. Il a été créé par Jeremy Ashkenas, vous savez, le brillant développeur aussi à l’origine de frameworks connus tels Backbone.js et Underscore.js. Coffeescript, c’est aussi un “Transpiler” Javascript. C’est-à-dire, qu’au lieu de compiler pour obtenir un binaire, on “compile” le code Coffeescript en Javascript directement exécutable dans un navigateur (ou côté serveur avec Node.js). Classiquement, le transpiler Coffeescript s’exécute sous Node.js, mais vous pouvez très bien l’utiliser en mode “run-time” et insérer du code Coffeescript directement (inline) dans vos pages HTML. C’est moins performant, mais cela peut être utile pour debugger.
L’objet de ce chapitre n’est pas de vous apprendre Coffeescript, mais de vous le présenter rapidement et vous montrer à quoi pourrait ressembler le code de la partie cliente de notre blog traduite en Coffeescript. Vous trouverez les informations complémentaire ici : [http://coffeescript.org/](http://coffeescript.org/).

##Un code plus lisible ?

Donc, selon moi (et d’autres), Coffeescript permet de simplifier le javascript, générer du javascript « propre » et apporte des évolutions de langage qui vont simplifier et rendre le code plus lisible. Nous allons tenter de voir ça par le biais de quelques exemples.

###Les fonctions

Le terme `function` disparaît au profit d’une « flèche » ! `return` disparaît complètement !!! (par défaut c'est la dernière ligne qui fait office de return) et les parenthèses ne sont pas partout obligatoires (ce qui facilite l’écriture de DSL) ... Et plus de point-virgule.

*Fonction d’addition en javascript :*

```javascript
function addition(a, b) {
  return a + b
}

//Utilisation :

var c = addition(45, 12)
```

Deviendra :

*Fonction d’addition en Coffeescript :*

```python
  addition = (a,b)->
  a+b

  #Utilisation :

  c = addition 45, 12
```

###Interopérabilité

Coffeescript reste compatible avec les librairies existantes (pas besoin de ré-écrire jQuery ... ouf !)

*Attendre le chargement de la page pour lancer les commandes :*

```javascript
$(function() {
  some();
  init();
  calls();
});
```

*La même chose en Coffeescript :*

```python
$ ->
  some()
  init()
  calls()
```

###Interpolation et Chaînes de caractères

Imaginons un objet bob :

*En Javascript :*

```javascript
var bob = {
  firstName : "Bob",
  lastName  : "Morane",
  sayHello  : function() {
  return "Hello !"
  }
}
```

Nous voulons afficher un message à partir des propriétés de Bob, aujourd’hui nous faisons comme ceci :

*En Javascript :*

```javascript
console.log(
  "Firstname : " + bob.firstName +
  " Lastname : " + bob.lastName +
  "Hello : " +
  bob.sayHello()
) ;
```

Coffeescript introduit des nouveaux concepts à propos des chaînes de caractères et particulièrement `#{variable}` qui permet d’insérer la valeur de variable dans une chaîne. Nous aurons donc ceci :

*Version Coffeescript :*

```python
bob =
  firstName : "Bob"
  lastName : "Morane"
  sayHello : ->
  "Hello !"

console.log "
  Firstname : #{bob.firstName}
  Lastname : #{bob.lastName}
  Hello : #{bob.sayHello()}
"
```

>>**Remarquez au passage**, la possibilité d’écrire vos chaînes de caractères sur plusieurs lignes (dans ce cas les saut de lignes ne sont pas pris en comptes, pour les prendre en comptes utilisez des triples « doubles-quotes » : """)

###Jouez un peu avec les tableaux

Nous avons le tableau suivant (en Coffeescript) :

*Copains :*

```python
copains = [
  { nom : "Bob", age : 30 }
  { nom : "Sam", age : 50 }
  { nom : "John", age : 20 }
]
```

Nous voudrions obtenir tous les copains de moins de 50 ans :

*Jeunes copains :*

```python
  Result = (copain for copain in copains when copain.age < 50)
```

##Et enfin (et surtout ?) les classes

Maintenant, grâce à Coffeescript, nous pouvons écrire des classes. Il faut aussi savoir ceci : le mot clé `this` devient `@`, les « champs » (propriétés) de la classes sont déclarés dans le constructeur. Mais un exemple est souvent plus parlant que trop d’explications :

###Notre 1ère classe

*Classe “Human” :*

```python
class Human
  constructor : (firstName, lastName) ->
    #fields : @ = this
    @firstName = firstName
    @lastName = lastName

  #method
  hello : ->
    console.log "Hello #{@firstName} #{@lastName}"

#Utilisation
Bob = new Human "Bob", "Morane"

Bob.hello()
```

###Propriétés & valeurs par défaut

Vous pouvez aller encore plus vite et déclarer vos propriétés et leur valeur par défaut directement en paramètres du constructeur.

*Classe “Human”, autre version, même résultats :*

```python
class Human
  constructor : (@firstName = "John", @lastName = "Doe") ->
  hello : ->
  console.log "Hello #{@firstName} #{@lastName}"
```

###Comme en Java : Composition, Association, Encapsulation

La notion de classe apportée par Coffeescript (même s’il existe en javascript, comme nous avons pu le voir par exemple avec le modèle objet de Backbone) permet facilement de mettre en œuvre les différents concepts habituels en programmation « orientée classes » et plus facilement encore décliner les « design patterns ».

*Composition de classes :*

```python
class Dog
  constructor:(@name)->

class Human
  constructor:(@first, @last, @dog)->

Bob = new Human "Bob", "Morane", new Dog "Wolf"
console.log "Le chien de Bob s'appelle #{Bob.dog.name}"
```

*Encapsulation de classes :*

```python
class Human
  class Hand
    constructor:(@whichOne)->

  constructor:(@first, @last)->
    @leftHand = new Hand "left"
    @rightHand = new Hand "right"

console.log JSON.stringify new Human "Bob", "Morane"
```

###Comme en Java : les membres statiques

La définition/déclaration de membres statiques se fait pour les propriétés en dehors du constructeur cette fois-ci et pré-fixées par `@`, les méthodes statiques « commencent » elles aussi par `@` :

*Toujours et encore notre classe « Human » :*

```python
class Human
  @counter : 0 #static property

  constructor : (@firstName, @lastName) ->
    Human.counter += 1

  #static method
  @howMany : ->
    Human.counter

Bob = new Human "Bob", "Morane"
console.log "Human.counter #{Human.howMany()}"
```

###Mais aussi (comme en Java) : l’héritage !

Coffeescript introduit le mot clé `extends` pour permettre à une classe d’hériter d’une autre classe, et cela s’utilise de façon très intuitive :

*Un humain, et un super héros qui hérite d’humain … :*

```python
  class Human
    constructor : (@firstName, @lastName) ->

    hello : ->
      "Hello #{@firstName} #{@lastName}"

  class Superhero extends Human
    constructor : (@firstName, @lastName, @name) ->

    hello : ->
      super + " known as #{@name}"

SuperMan = new Superhero "Clark", "Kent", "SuperMan"
console.log SuperMan.hello()
```

>>**Notez au passage** l’apparition du mot-clé super qui permet « d’appeler » la méthode du « parent ».

Une première conclusion s’impose : Maintenant vous pouvez faire du javascript « orienté classes » tout en conservant les possibilités actuelles de javascript.


##J’aime / Je n’aime pas

Coffeescript fait beaucoup de bruit dans la communauté javascript, mais aussi du côtés des développeurs java, .Net, etc. ... Il a été assez bien adopté par les développeurs Ruby car il a une syntaxe assez proche.

Ce qui plaît beaucoup, plus particulièrement aux développeurs « non javascript », c’est le concept de classes, mais les développeurs javascript « puristes » ne voient pas l’intérêt d’utiliser des classes, les concepts objet de javascript apparaîssant largement suffisants.


>>Personnellement, si l’aspect classe doit contribuer à l’adoption de javascript, laissons les classes ! Il y a encore trop de développeurs rebutés par javascript pour de fausses raisons. Ce n’est probablement pas pour rien si le concept de classe apparaît dans la future version de javascript ES6.

Ce qui plaît beaucoup moins, et là les développeurs javascripts et java se rejoignent, c’est l’abscence de points virgule, d’accolades, et la notion d’indentation « significative » comme en python, rendant le code difficilement lisible s’il est trop long.

>>D’autres vous diront que la simplification du code grâce à Coffeescript contribue à sa lisibilité. Comme quoi, les goûts et les couleurs ...


Le plus gros défaut de Coffeescript, reste la difficulté à debbuger du code coffeescript, l’impossibilité de l’utiliser directement dans la console du navigateur. Cependant le projet **Source Map** devrait régler ce type de problème à l’avenir (et pour d’autres transpilers aussi) : [http://www.coffeescriptlove.com/2012/04/source-maps-for-coffeescript.html](http://www.coffeescriptlove.com/2012/04/source-maps-for-coffeescript.html).

On pourrait ensuite se demander, mais que va devenir Coffeescript dans le futur avec l’apparition de la nouvelle version de javascript ? Je vous répondrais, qu’avant que cette version soit déployée sur tous les postes de travail (donc que tout le monde dispose d’un navigateur de dernière génération) il va se passer plusieurs années et que Coffeescript génère du code javascript  qui fonctionne sur la majorité des navigateurs existants.

Brendan Heich (le papa de javascript) a officiellement donné sa bénédiction « publique » à Coffeescript, nul doute que Jeremy Ashkenas ne fasse évoluer Coffeescript en fonction des spécifications javascript pour garder une compatibilté ascendante et descendante. Pour rappel, en début de page du site de Coffeescript, il est écrit : **« The golden rule of CoffeeScript is: "It's just JavaScript" »**.

>>Pour ma part, je pense que c’est un excellent outil d’apprentissage (il génère du code javascript « propre ») mais sur un projet de réalisation professionnel, il est à réserver aux « gurus » qui maîtrise déjà javascript.

Attention, un challenger de poids vient de naître dans le monde des transpilers javascript : **TypeScript**, porté par Microsoft, développé entre autre par le papa de l’ancêtre du Turbo Pascal mais aussi du C# et qui tend à gommer une grande partie des défauts reprochés à Coffeescript. Cela fera l’objet d’un prochain chapitre, mais avant cela, passons à la ré-écriture de notre Blog en Coffeescript.

##Ré-écriture de notre blog ?! S'outiller

Avant toute chose, sauvegardez votre arborescence applicative à un autre emplacement pour pouvoir la réutiliser.

###Installation de Coffeescript

L’installation de Coffeescript est très simple, elle s’effectue en mode commande avec npm (installé en même temps que Node.js) :

  npm install –g coffee-script

>>**Remarque :** pour les utilisateurs sous OSX, vous devez normalement utiliser la commande `sudo npm install –g coffee-script`

A partir de maintenant, vous pouvez compiler/transpiler du code Coffeescript en javascript avec la commande suivante :

  coffee –compile Human.coffee

qui produira un fichier javascript `Human.js`.

Pour plus d’informations : [http://jashkenas.github.com/coffee-script/#usage](http://jashkenas.github.com/coffee-script/#usage).

###“Industrialisation” de la transpilation

Nous avons donc décidé de re-écrire la partie javascript cliente de notre blog. Pour cela dans le répertoire de notre application, créez un répertoire `public.coffee` avec un sous-répertoire `models` et un sous répertoire `views`. Ce répertoire et ces deux sous-répertoires contiendrons les fichiers source coffeescript (que vous pouvez d’ores et déjà créer “vides” dans les répertoires correspondants) :

  public.coffee\
      |-models\
      |        |-post.coffee
      |-views\
      |       |-AdminView.coffee
      |       |-LoginView.coffee
      |       |-MainView.coffee
      |       |-PostsListView.coffee
      |       |-PostView.coffee
      |       |-SidebarView.coffee
      |
      |-Blog.coffee
      |-main.coffee
      |-routes.coffee

Le “but du jeu” étant de transpiler tous les fichiers `.coffee` en fichier javascript `.js` dans le répertoire `public` (et ses sous-répertoire).
Faire ceci “à la main” en prenant les fichiers un par un peut devenir très rapidement fastidieux. Mais heureusement, l’installation de Coffeescript inclut un système simple de “build” qui s’appelle **Cake**, qui est capable d’effectuer des tâches simples décrites dans un fichier `Cakefile`. Plus d’information ici : [http://jashkenas.github.com/coffee-script/#cake](http://jashkenas.github.com/coffee-script/#cake).

Donc à la racine de votre application, créez un fichier `Cakefile` avec le contenu suivant :

*Cakefile :*

```python
fs = require 'fs'
{print} = require 'util'
{spawn} = require 'child_process'

build = (callback) ->
coffee = spawn 'coffee', ['-c', '-o', 'public', 'public.coffee']
coffee.stderr.on 'data', (data) ->
  process.stderr.write data.toString()
coffee.stdout.on 'data', (data) ->
  print data.toString()
coffee.on 'exit', (code) ->
  callback?() if code is 0

task 'build', 'Build public/ from public.coffee/', ->
build()
```

En fait nous expliquons à Cake que nous souhaitons transpiler en javascript tous les fichiers du répertoire source `public.coffee` vers le répertoire cible `public`. Et pour cela, il suffira, dans un terminal (ou une console) de lancer la commande : `cake build` (à la racine de notre application, là où est situé le fichier `Cakefile`).

##Ré-écriture / Traductions

Alors, l’objectif n’est pas d’apprendre Coffeescript (cela pourrait donner lieu à un ouvrage entier), mais de montrer comment il est possible d’écrire notre blog “autrement”, donc je vous livre ici la traduction en Coffeescript (pas forcément dans les règles de l’art) qui fonctionnera et assortie de quelques remarques.

###Blog.coffee

```python
window.Blog =
Models : {}
Collections : {}
Views : {}
Router : {}
```

###main.coffee

```python
yepnope
load:
  jquery: "libs/vendors/jquery-1.7.2.js"
  underscore: "libs/vendors/underscore.js"
  backbone: "libs/vendors/backbone.js"
  mustache: "libs/vendors/mustache.js"

  #NameSpace
  blog: "Blog.js"

  #Models
  posts: "models/post.js"

  #Controllers
  sidebarview: "views/SidebarView.js"
  postslistviews: "views/PostsListView.js"
  mainview: "views/MainView.js"
  loginview: "views/LoginView.js"
  postview: "views/PostView.js"
  adminview: "views/AdminView.js"

  #Routes
  routes: "routes.js"

callback:
  routes: ->
  console.log "routes loaded ..."

complete: ->
  $ ->
  console.log "Lauching application ..."
  window.blogPosts = new Blog.Collections.Posts()
  window.mainView = new Blog.Views.MainView(collection: blogPosts)

  #======= Admin =======
  window.adminView = new Blog.Views.AdminView(collection: blogPosts)


  #======= Authentification =======
  window.loginView = new Blog.Views.LoginView(adminView: adminView)

  window.postView = new Blog.Views.PostView()
  window.router = new Blog.Router.RoutesManager(collection: blogPosts)

  Backbone.history.start()
```

###post.coffee

```python
class Blog.Models.Post extends Backbone.Model
urlRoot:"/blogposts"

class Blog.Collections.Posts extends Backbone.Collection

model: Blog.Models.Post

all: ->
  @url = "/blogposts"
  @

query: (query) ->
  @url = "/blogposts/query/" + query
  @
```

###AdminView.coffee

```python
class Blog.Views.AdminView extends Backbone.View
el: $ "#admin"
initialize: ->
  @template = $("#admin_template").html()

  #je prévois de trier ma collection
  @collection.comparator = (model) ->
  -(new Date(model.get("date")).getTime())

render: ->
  renderedContent = Mustache.to_html(@template,
  posts: @collection.toJSON()
  )
  @$el.html renderedContent

events:
  "click  #btn_update": "onClickBtnUpdate"
  "click  #btn_create": "onClickBtnCreate"
  "click  #btn_send": "sendPost"

onClickBtnUpdate: ->
  selectedId = $("#post_choice").val()
  post = @collection.get(selectedId)

  #Je récupère les informations du post et les affiche
  $("#admin > [name='id']").html post.get("id")
  $("#admin > [name='author']").val post.get("author")
  $("#admin > [name='title']").val post.get("title")
  $("#admin > [name='message']").val post.get("message")

onClickBtnCreate: ->

  #je ré-initialise les zones de saisie
  $("#admin > [name='id']").html ""
  $("#admin > [name='author']").val ""
  $("#admin > [name='title']").val ""
  $("#admin > [name='message']").val ""

sendPost: -> #Sauvegarde
  #that = this #pour conserver le contexte
  id = $("#admin > [name='id']").html()
  post = undefined
  if id is "" #si l'id est vide c'est une création
  post = new Blog.Models.Post()
  else #l'id n'est pas vide c'est une mise à jour
  post = new Blog.Models.Post(id: $("#admin > [name='id']").html())
  post.save
  author: $("#admin > [name='author']").val()
  title: $("#admin > [name='title']").val()
  message: $("#admin > [name='message']").val()
  date: new Date()
  ,
  success: ->

  #Si la transaction côté serveur a fonctionné

  #je recharge ma collection
  @collection.fetch success: =>

  #mise à jour de la vue admin
  @render()



#La vue principale se re-mettra à jour
#automatiquement, car elle est "abonnée"
#aux changement de la collection
error: ->
```

  //TODO : parler de fat arrow =>

###LoginView.coffee

```python
class Blog.Views.LoginView extends Backbone.View
el: $ "#blog_login_form"
initialize: (args) ->
  that = this
  @adminView = args.adminView
  @template = $("#blog_login_form_template").html()

  #on vérifie si pas déjà authentifié
  $.ajax
  type: "GET"
  url: "/alreadyauthenticated"
  error: (err) ->
    console.log err

  success: (dataFromServer) ->
    if dataFromServer.firstName
    that.render "Bienvenue", dataFromServer
    else
    that.render "???",
      firstName: "John"
      lastName: "Doe"



render: (message, user) ->
  renderedContent = Mustache.to_html(@template,
  message: message
  firstName: (if user then user.firstName else "")
  lastName: (if user then user.lastName else "")

  #adminLink : user.isAdmin ? '#/admin' : "",
  adminLinkLabel:
    (if user then (if user.isAdmin then "Administration" else "") else "")
  )
  @$el.html renderedContent

events:
  "click  .btn-primary": "onClickBtnLogin"
  "click  .btn-inverse": "onClickBtnLogoff"
  "click #adminbtn": "displayAdminPanel"

displayAdminPanel: ->
  @adminView.render()

onClickBtnLogin: (domEvent) ->
  fields = $("#blog_login_form :input")
  #that = this
  $.ajax
  type: "POST"
  url: "/authenticate"
  data:
    email: fields[0].value
    password: fields[1].value

  dataType: "json"
  error: (err) ->
    console.log err

  success: (dataFromServer) =>
    if dataFromServer.infos
    @render dataFromServer.infos
    else
    if dataFromServer.error
      @render dataFromServer.error
    else
      @render "Bienvenue", dataFromServer


onClickBtnLogoff: =>
  #that = this
  $.ajax
  type: "GET"
  url: "/logoff"
  error: (err) ->
    console.log err

  success: (dataFromServer) ->
    console.log dataFromServer
    @render "???",
    firstName: "John"
    lastName: "Doe"
```

###PostsListView.coffee

```python
class Blog.Views.PostsListView extends Backbone.View
el: $ "#posts_list"
initialize: ->
  @template = $("#posts_list_template").html()

render: ->
  renderedContent = Mustache.to_html(@template,
  posts: @collection.toJSON()
  )
  @$el.html renderedContent
```

###PostView.coffee

```python
class Blog.Views.PostView extends Backbone.View
el: $ "#posts_list"
initialize: ->
  @template = $("#post_details_template").html()

render: (post) ->
  renderedContent = Mustache.to_html(@template,
  post: post.toJSON()
  )
  @$el.html renderedContent
```

###SidebarView.coffee

```python
class Blog.Views.SidebarView extends Backbone.View
el: $ "#blog_sidebar"
initialize: ->
  @template = $("#blog_sidebar_template").html()

render: ->
  renderedContent = Mustache.to_html(@template,
  posts: @collection.toJSON()
  )
  @$el.html renderedContent
```

###MainView.coffee

```python
class Blog.Views.MainView extends Backbone.View
initialize: ->
  @collection.comparator = (model) ->
  -(new Date(model.get("date")).getTime())

  _.bindAll this, "render"
  @collection.bind "reset", @render
  @collection.bind "change", @render
  @collection.bind "add", @render
  @collection.bind "remove", @render
  @sidebarView = new Blog.Views.SidebarView()
  @postsListView = new Blog.Views.PostsListView(collection: @collection)

render: ->

  @sidebarView.collection = new Blog.Collections.Posts(@collection.first(3))
  @sidebarView.render()
  @postsListView.render()
```

###routes.coffee

```python
class Blog.Router.RoutesManager extends Backbone.Router
initialize: (args) ->
  @collection = args.collection

routes:
  "post/:id_post": "displayPost"
  hello: "hello"
  "*path": "root"

root: ->
  @collection.all().fetch success: (result) ->

  #ça marche !!!
  console.log "fetching collection", result


hello: ->
  $(".hero-unit > h1").html "Hello World !!!"

displayPost: (id_post) ->
  tmp = new Blog.Models.Post(id: id_post)
  tmp.fetch success: (result) ->
  postView.render result
```

Ouf, c'est fini.

###Transpilons

Si vous lancez la commande : `cake build` vous obtiendrez de nouveau fichiers javascript dans le répertoire public. Relancez votre application, vous noterez qu’elle fonctionne comme avant.

###Conclusion(s)

Les conclusions sont très personnelles. J'aime beaucoup le principe de "classe" et je le trouve très utile pour organiser son code, tout particulièrement en ce qui concerne les modèles et les collections. Au passage, vous avez du remarquer que le modèle objet de Backbone se marie parfaitement avec celui de Coffeescript (on peut hériter directement d'un Backbone.Model par exemple). C'est normal, les 2 outils sont codés par le même auteur.

Ce que j'aime aussi, c'est les possibilités des chaînes de caractères.

Par contre, je trouve que pour des portions de code très longue, on perd en visibilité (cf. `AdminView` ou `LoginView`) (mais ça n'engage que moi).

Cependant, je ne peux m'empêcher d'aimer ce "petit" langage et les concepts qu'il apporte.

... A vous de voir ;)








