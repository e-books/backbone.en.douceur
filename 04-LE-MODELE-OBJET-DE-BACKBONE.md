#Le modèle objet de Backbone

>*Sommaire*

>>- *Un petit tour dans le code*
>>- *Une classe de base*
>>- *Héritage*


>*Ce qui est souvent déstabilisant pour le développeur Java (PHP, .Net, etc.) c’est le modèle objet de javascript qui diffère du classique modèle orienté « classes » que nous connaissons tous (normalement). De nombreux ouvrages, articles… se sont attaqués au sujet, mais ce n’est pas l’objet de ce chapitre.*

Je vais vous présenter de quelle façon Backbone gère son « Orientation objet » et comment réutiliser cette fonctionnalité. L’objectif est double : mieux comprendre le fonctionnement de Backbone et vous donner un moyen de faire de l’objet en javascript sans être dépaysé (quelque chose qui ressemble dans sa logique, à ce que vous connaissez déjà).

##Un petit tour dans le code

Si vous avez la curiosité d’aller lire le code de Backbone (je vous engage à le faire, le code est clair et simple et avec le temps très instructif), vous « tomberez » sur une ligne particulièrement intéressante (vers la fin du code source dans `backbone.js` pour ceux qui iront réellement lire le code) :

```javascript
// Set up inheritance for the model, collection, and view.
Model.extend = Collection.extend = Router.extend = View.extend = extend;
```

Il existe une méthode (privée) `extend` dans Backbone qui permet à un objet d’hériter des membres d’un autre objet, par exemple, si j’écris:

```javascript
/*--- Modèle article ---*/

// une "sorte" de classe Article
var Article = Backbone.Model.extend({

});
```

Je signifie que je crée une “sorte” de classe `Article` qui hérite des fonctionnalités de `Model`. De la même façon je pourrais ensuite définir une autre classe `ArticleSpecial` qui héritera de `Article` (et qui conservera les spécificités (membres de classe) de `Model`):

```javascript
var ArticleSpecial = Article.extend({

});
```

Je vous expliquais que la méthode `extend` était privée, Backbone ne l’expose pas directement, mais il est tout à fait possible d’y accéder par un des composants de Backbone, de la façon suivante :

```javascript
var Kind = function() {};
Kind.extend = Backbone.Model.extend;
```

>>**Remarque 1** : J’ai utilisé « Kind » pour ne pas utiliser « Class » ou « class » qui est un terme réservé pour les futures versions de javascript.

>>**Remarque 2** : Je vais utiliser du français dans mon code. Je sais que c’est moche, promis j’essaye de ne plus le faire (à part dans les commentaires).

Nous pouvons donc maintenant écrire :

```javascript
var Personne = Kind.extend({});
```

##1ère "classe"

Voyons donc ce que nous apporte le modèle objet de Backbone.

###Un constructeur

La déclaration d’un constructeur se fait avec le mot clé `constructor` :

Utilisation de `Kind.extend()` et définition de `constructor()`

```javascript
var Personne = Kind.extend({
  constructor: function() {
    console.log("Bonjour, je suis le constructeur de Personne");
  }
});

var bob = new Personne();
```

Nous obtiendrons à l’exécution :

  Bonjour, je suis le constructeur de Personne

###Des propriétés

Les propriétés se déclarent dans le constructeur (elles sont générées à l’exécution)

Ajout de propriétés

```javascript
var Personne = Kind.extend({

  constructor: function(prenom, nom) {
  	this.prenom = "John";
  	this.nom = "Doe";
    if (prenom) { 
    	this.prenom = prenom; 
    } 
    if (nom) {
    	this.nom = nom;
    }

    console.log("Bonjour, je suis ", this.prenom, this.nom);
  }
});

var john = new Personne();
var bob = new Personne("Bob", "Morane");
```

**Warning:** ne jamais définir les propriétés en dehors du `constructor`


Nous obtiendrons à l’éxécution :

  Bonjour, je suis  John Doe
  Bonjour, je suis  Bob Morane


###Des méthodes

Les méthodes se déclarent de la même façon que le constructeur, ajoutons une méthode `bonjour()` :

Ajout d’une méthode

```javascript
var Personne = Kind.extend({

  constructor: function(prenom, nom) {
  	this.prenom = "John";
  	this.nom = "Doe";
    if (prenom) { 
    	this.prenom = prenom; 
    } 
    if (nom) {
    	this.nom = nom;
    }
  },
  bonjour: function() {
    console.log("Bonjour, je suis ", this.prenom, this.nom);
  }

});

var john = new Personne();
var bob = new Personne("Bob", "Morane");

john.bonjour();
bob.bonjour();
```

Nous obtiendrons à l’exécution :

  Bonjour, je suis  John Doe
  Bonjour, je suis  Bob Morane

###Des membres statiques

La méthode `extend` accepte un deuxième paramètre qui permet de déclarer des membres statiques :

Ajout & utilisation de membres statiques

```javascript
var Personne = Kind.extend({

  constructor: function(prenom, nom) {
  	this.prenom = "John";
  	this.nom = "Doe";
    if (prenom) { 
    	this.prenom = prenom; 
    } 
    if (nom) {
    	this.nom = nom;
    }

    //Utilisation de la propriété statique
    Personne.compteur += 1;
  },
  bonjour: function() {
    console.log("Bonjour, je suis ", this.prenom, this.nom);
  }

}, { //ici les membres statiques
  compteur: 0,
  combien: function() {
    return Personne.compteur;
  }
});

var john = new Personne();
var bob = new Personne("Bob", "Morane");

console.log("Il y a ", Personne.combien(), " personnes");
```

Nous avons donc une propriété statique `compteur` et une méthode statique `combien()`. Nous obtiendrons ceci à l’exécution :

  Il y a  2  personnes

##Sans héritage point de salut ! … ?

Même s’il ne faut pas abuser de l’héritage en programmation objet (mais c’est un autre débat), il faut avouer que cela peut être pratique pour la structuration de notre code. Dès le départ, dans ce chapitre nous avons fait de l’héritage :

  var Personne = Kind.extend({ });

Donc `Personne` hérite de `Kind`. Mais essayons un exemple plus complet pour bien appréhender les possibilités de Backbone. `Personne` héritant de `Kind` possède donc aussi une méthode `extend`, nous allons donc pouvoir créer une `Femme` et un `Homme` :

```javascript
var Homme = Personne.extend({
  getSexe: function() { return "male"; }
});

var Femme = Personne.extend({
  getSexe: function() { return "femelle"; }
});

var angelina = new Femme("Angelina", "Jolie");
var bob = new Homme("Bob", "Morane");

angelina.bonjour();
bob.bonjour();

console.log("Il y a ", Personne.combien(), " personnes");
```

A l’exécution nous obtiendrons ceci :

  Bonjour, je suis  Angelina Jolie
  Bonjour, je suis  Bob Morane
  Il y a  2  personnes

Nous pouvons donc vérifier que l’on a bien hérité de la méthode `bonjour()`, du constructeur `constructor()` et de `nom` et `prenom` (ainsi que de leurs valeurs par défaut). Nous remarquons aussi que l’incrémentation des “personnes” continue puisque `Homme` et `Femme` héritent de `Personne`.
Voyons maintenant, comment surcharger les méthodes du parent et continuer à appeler les méthodes du parent.


##Surcharge & super

Modifions le code des “pseudo-classes” de la façon suivante :

Surcharge et utilisation de `super()`

```javascript
var Homme = Personne.extend({
    getSexe: function() { return "male"; },
  //surcharge du constructeur
  constructor: function(prenom, nom) {
    //appeler le constructeur de Personne
    Homme.__super__.constructor.call(this, prenom, nom);
    console.log("Hello, je suis un ", this.getSexe());
  },
  bonjour: function() {
    //appeler la methode bonjour() du parent
    Homme.__super__.bonjour.call(this);
    console.log("Bonjour, je suis un garçon");
  }
});

var Femme = Personne.extend({
  getSexe: function() { return "femelle"; },
  //surcharge du constructeur
  constructor: function(prenom, nom) {
    //appeler le constructeur de Personne
    Femme.__super__.constructor.call(this, prenom, nom);
    console.log("Hello, je suis une ", this.getSexe());
  },
  bonjour: function() {
    //appeler la methode bonjour() du parent
    Femme.__super__.bonjour.call(this);
    console.log("Bonjour, je suis une fille");
  }
});

var angelina = new Femme("Angelina", "Jolie");
var bob = new Homme("Bob", "Morane");

angelina.bonjour();
bob.bonjour();
```

Nous avons surchargé les constructeurs pour pouvoir afficher un message au moment de l’instanciation et nous avons appelé le constructeur du parent pour continuer à permettre l’affectation de `nom` et `prenom`. Nous avons appliqué le même principe pour la méthode `bonjour()`. Donc l’appel d’une méthode du parent se fait de la manière suivante : `Nom_de_la_classe_courante.__super__.methode.call(this, paramètres)`.

A l’exécution nous obtiendrons donc :

  Hello, je suis une  femelle
  Hello, je suis un  male
  Bonjour, je suis  Angelina Jolie
  Bonjour, je suis une fille
  Bonjour, je suis  Bob Morane
  Bonjour, je suis un garçon

##Conclusion

Nous venons de voir comment continuer à programmer objet sans trop bouleverser vos habitudes (cela ne doit pas vous empêcher d’étudier le modèle objet de javascript plus en profondeur). Vous pourrez mieux structurer votre code (et en javascript, c’est important) mais aussi vos idées, mieux comprendre le fonctionnement de Backbone, et aussi écrire des extensions à Backbone plus facilement.


