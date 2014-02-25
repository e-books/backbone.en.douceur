#Backbone et Typescript

>*Sommaire*

>>- *Installation de Typescript ...*
>>- *... des Classes, des interfaces, des modules et du typage !!!*
>>- *La cohabitation avec Backbone*

>*A l'heure où j'écris, Microsoft vient, il y a peu, de présenter au monde son nouveau bébé : TypeScript, un transpiler javascript (un autre !) qui préfigure ce que sera la future version de javascript. Sur le même principe que Coffescript, Typescript apporte les concepts qui manquent tant à de nombreux développeurs "allergiques" à javascript. C'est à dire les, les Classes mais aussi les modules (pensez namespaces ou packages), les interfaces, les propriétés… Mais il y a un petit plus : on conserve les {}, les (), les ; ... tout ce qui contribue finalement à rendre le code lisible.*

L'objectif n'est pas de vous expliquer Typescript de A à Z (ça pourrait faire un autre bouquin, si ça vous intéresse faites moi signe), mais de vous montrer rapidement ce que ça pourrait vous apporter utilisé conjointement avec Backbone.


##TypeScript, on installe

Sachez le, Typescript fonctionne aussi bien sous Windows, Linux qu'OSX. Et oui Microsoft n'a pas fait du "fermé", et en plus c'est **opensource** et ça respecte au plus proche les spécifications d'Ecmascript 6 en transpilant aussi bien de l'Ecmascript 5 ou 3, donc compatible avec nos navigateurs actuels.

###Pré-requis

Avant toute chose, il faut installer **Node.js**, vous trouverez tout ce qu'il faut sur le site :

[http://nodejs.org/download/](http://nodejs.org/download/).

Pensez aussi à installer **Npm** (node package manager) dans le cas de linux.

###Installation de Typescript

C'est extrêment simple :

- sous Windows : `npm install -g typescript`
- sous Linux : `sudo npm install -g typescript`
- sous OSX : `sudo npm install -g typescript`

###Comment transpiler ?

Sous Windows vous pouvez utiliser le plugin Typescript pour Visual Studio 2012 (existe aussi en version express) mais nous, on va le faire à l'ancienne, à la mimine :

  tsc nom_de_mon_script.ts

Et vous obtiendrez un fichier `nom_de_mon_script.js`.

>>Vous l'aurez donc compris, l'extension d'un fichier typescript est `.ts`

###IDE ?

En plus de Visual Studio vous pouvez aussi utiliser **Vim**, **Emacs** ou **SublimeText2** pour lesquels vous trouverez "la colorisation syntaxique" ici [http://blogs.msdn.com/b/interoperability/archive/2012/10/01/sublime-text-vi-emacs-typescript-enabled.aspx](http://blogs.msdn.com/b/interoperability/archive/2012/10/01/sublime-text-vi-emacs-typescript-enabled.aspx).

###TypeScript, quoi de plus que Javascript ou Coffeescript ?

Sachez le, Typescript, c'est du javascript. Vous pouvez mettre du "pur" javascript dans un code Typescript sans problème, cela fonctionnera. Typescript apporte juste quelques notions supplémentaires, comme les types (qui sont juste vérifiés à la transpilation), les classes, les interfaces, mais aussi les modules qui sont très pratiques pour organiser votre code.

>>le typage n'est pas obligatoire, c'est juste finalement très utile pour vérifier que l'on n'a pas codé n'importe quoi (je reste poli ;) ). Je n'en voyais pas l'utilité au début (je faisais juste une fixette sur les classes), mais finalement cela m'a évité pas mal d'erreur.

##Le (petit) tour de TypeScript en 1 exemple

Commencez par créer (dans un répertoire de travail) l'arborecence suivante (avec les fichiers correspondants) :

  mon_repertoire_de_travail---|
        |-core\
        |      |-core.ts
        |
          |-models\   <-- je mettrais mes fichiers modèles ici
          |        |-Animal.ts
          |        |-Human.ts
          |-index.html
          |-app.ts

###core.ts

Nous allons définir notre 1er module avec le mot clé `module`, notre 1ère classe `Model` qui implémente les interfaces `Persistable` et `Entity`. Notre classe `Model` dispose d'une variable `public` & `static` appelée `store` de type `Entity[]` initialisé à vide ` = [];`. Le modèle aura une méthode lui permettant de "s'ajouter" au store. La classe `Model` aura une méthode statique `getAll(kind:string)` qui permettra de retourner un tableau de modèles (d'un certain type).

>>**Pourquoi Entity ?** En fait je souhaite ajouter dans le même tableau `store` différents type de modèles, donc je leur ferais implémenter la même interface pour pouvoir tous les "pousser" à mon tableau.

>>Notez au passage la notion de "fat arrow" ou `=>` appelée aussi "arrow function expression" (fonctionnalité prévue pour Ecmascript 6). Ca vous rappelle quelque chose ;) ?

>>Notez aussi au passage, par contre que mon code ne fonctionnera que pour des navigateur Ecmascript 5 "compliant", puisque j'utilise le `filter` des `Array`, par contre j'ai un code plus "sympa" avec `=>`.

>>Remarquez le mot clé `export` qui permet de rendre la classe accessible à partir du module : `Core.Model`

```javascript
module Core {

  interface Persistable {
  saved : bool;
  addToStore() : void;
  }

  export interface Entity {
  kind : string;
  }

  export class Model implements Persistable, Entity {
  saved : bool = false;
  kind : string = "kindOfModel";
  public static store : Entity[] = [];

  public addToStore() : void {
    if(!this.saved) {
    this.saved = true
    Model.store.push(this);
    }
  }

  public static getAll(kind:string) : Entity[] {
    return Model.store.filter((model:Entity) => {
      return model.kind == kind;
    });
  }
  }

}
```

###Allons créer nos modèles

Nous allons créer 2 modèles : Animal and Human (je sais ce n'est pas très original, un orignal, à Montréal ...).

- Pour hériter, nous utilisons `extends`
- Pour référencer notre module `Core`, nous utilisons ceci en en-tête de fichier : `///<reference path='../core/core.ts'/>`

*Animal.ts :*

```javascript
///<reference path='../core/core.ts'/>
module Models {
  export class Animal extends Core.Model implements Core.Entity {
  kind = "Animal";
  constructor(public name?="Wolf"){
    super();
  }
  }
}
```

>> l'utilisation de `public name?="Wolf"` dans le constructeur est un raccourci pour déclarer la propriété `name` tout en l'initialisant, la notation `?=` permet aussi de donner une valeur par défaut.

De la même manière, codons notre modèle Human :

*Human.ts :*

```javascript
///<reference path='../core/core.ts'/>
///<reference path='Animal.ts'/>
module Models {
  export class Human extends Core.Model implements Core.Entity {
  kind = "Human";
  animal : Models.Animal;
  constructor(public name?="John Doe"){
    super();
  }
  }
}
```

>>J'explique que le modèle Human a une propriété `animal` de type `Models.Animal`, si j'avais voulu être propre, j'aurais du faire la même chose pour `kind` avec `kind:string="Human"`, mais bon ... Notez aussi l'utilisation de `super` pour appeler le constructeur de la "maman".

>>**Vous avez du vous apercevoir que nous pouvions utiliser le même nom de module dans 2 fichiers distincs, ce qui est extrêment pratique !**

###Utilisons tout cela

Créez un fichier `index.html` avec le code ci-dessous :

```html
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>TypeScript</title>
  </head>

  <body>
  <ul></ul>
  </body>
  <script src="core/core.js"></script>
  <script src="models/Animal.js"></script>
  <script src="models/Human.js"></script>
  <script src="app.js"></script>
</html>
```

>>**Attention** vous devez référencer les fichiers `.js` et non pas `.ts`

Et enfin codons notre fichier principal `app.ts` :

```javascript
///<reference path='models/Animal.ts'/>
///<reference path='models/Human.ts'/>

var bob = new Models.Human("Bob Morane");
var wolf = new Models.Animal("Wolf");
var john = new Models.Human("John Doe");

bob.animal = wolf;

bob.addToStore();
john.addToStore();
wolf.addToStore();

var ul = document.querySelector('ul');

Core.Model.getAll("Human").forEach((model:Models.Human)=>{
  var li = document.createElement('li');
  li.innerHTML = model.name
  if(model.animal) li.innerHTML+= " / " + model.animal.name;
  ul.appendChild(li);
  });
```

Nous avons donc :

- Référencé nos 2 modèles en en-tête de fichier
- instancié 2 humains et un animal
- affecté l'animal `wolf` à `bob`
- "enregistré" tous ces modèles dans le `Core.Model.store`
- puis demandé d'afficher la liste des humains (`Core.Model.getAll("Human")`) dans une liste (`<ul></ul>`).

et pour afficher tout ça, il va falloir transpiler :

  tsc --target ES5 app.ts

Et maintenant, vous pouvez ouvrir votre page dans le navigateur, vous aurez la liste de vos Humains.

##Et Backbone dans tout ça ?

Après ce bref aperçu, voyons comment nous pouvons profiter des possibilités de Typescript avec Backbone. Comme je le disais au début du chapitre, Typescript reste du javascript et est donc compatible avec les librairies existantes telles **jQuery** ou **Underscore**. pour les utiliser dans tu Typescript il suffit de les déclarer comme ceci :

  declare var $: any;
  declare var _: any;

>>le type `any` est un peu à javascript ce que le Variant est à Visual Basic.

Côté Backbone, nous pourrions aussi écrire `declare var Backbone`, mais ça serait dommage de ne pas pouvoir utiliser la notation de classe de TypeScript et continuer "à l'ancienne" avec le modèle objet de Backbone.

Il est en fait possible de décrire des déclarations plus complexes pour que TypeScript "comprennent" Backbone, comme ceci par exemple :

```javascript
declare module Backbone {

  export class Model {
  constructor (attr? , opts? );
  intialize (attr? , opts? );
  get(name: string): any;
  set(name: string, val: any): void;
  set(obj: any): void;
  save(attr? , opts? ): void;
  destroy(): void;
  bind(ev: string, f: Function, ctx?: any): void;
  toJSON(): any;
  }
}
```

Et ensuite vous pourrez écrire votre code Backbone en TypeScript de la façon suivante :

```javascript
class Human extends Backbone.Model {
  intialize () {
    console.log("Hello from Human constructor.");
  }
}

var Bob = new Human({firstName:"Bob", lastName:"Morane"});
console.log(Bob.get("firstName"), Bob.get("lastName"));
```

>>*J'utilise `initialize` car en fait dans Backbone c'est une méthode appelée par le constructeur et je préfère ne pas modifier le fonctionnement intrinsèque de Backbone.*

Dans la “vraie vie”, il faudra déclarer toutes les méthodes des autres composants Backbone. Mais pas de panique, il existe un repository GitHub avec les déclarations des librairies javascript les plus courantes : [https://github.com/borisyankov/DefinitelyTyped](https://github.com/borisyankov/DefinitelyTyped). Il suffit ensuite d'y faire référence dans le code de cette manière `/// <reference path="backbone-0.9.d.ts" />`.

De mon point de vue, TypeScript a un potentiel énorme, si ce n'est pour son côté typé, cela peut être pour sa contribution à l'adoption de javascript par les réfractaires. En tous les cas, j'aime beaucoup, et j'avais très envie de vous en parler.

Si vous voulez aller plus loin, d'un point de vue outillage par exemple, vous pouvez lire un de mes article ici qui explique comment préparer sont environnement de "transpilation continue en TypeScript" avec Grunt : [http://k33g.github.com/2012/11/12/TSTRANSPIL.html](http://k33g.github.com/2012/11/12/TSTRANSPIL.html).

