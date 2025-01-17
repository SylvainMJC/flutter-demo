final listProducts = [
  Product(
    id: 1,
    name: 'Ordinateur portable',
    description:
        'Boostez votre productivité avec cet ordinateur portable performant : écran Full HD, processeur puissant, grande autonomie et design ultra-fin. Idéal pour le travail, les études et le divertissement, il combine rapidité, élégance et fiabilité. Profitez d’un stockage généreux et d’une connectivité avancée pour rester connecté où que vous soyez.',
    category: 'Électronique',
    image: 'assets/images/laptop2.jpg',
    price: 420.69,
  ),
  Product(
    id: 2,
    name: 'Smartphone',
    description:
        'Capturez le monde qui vous entoure avec ce smartphone doté d\'un appareil photo exceptionnel, d\'un écran immersif et d\'une puissance inégalée. Profitez de performances fluides, d\'une connectivité ultra-rapide et d\'une batterie longue durée pour rester connecté toute la journée.',
    category: 'Électronique',
    image: 'assets/images/smartphone.png',
    price: 299.99,
  ),
  Product(
    id: 3,
    name: 'Tablette tactile',
    description:
        'Découvrez un monde de divertissement et de productivité avec cette tablette tactile élégante et polyvalente. Profitez d\'un écran haute résolution, d\'un son immersif et d\'une navigation fluide pour vos applications, jeux et contenus multimédias préférés.',
    category: 'Électronique',
    image: 'assets/images/tablet.jpg',
    price: 199.99,
  ),
  Product(
    id: 4,
    name: 'Écouteurs sans fil',
    description:
        'Immergez-vous dans votre musique préférée avec ces écouteurs sans fil offrant un son de qualité supérieure, un confort optimal et une liberté de mouvement totale. Profitez d\'une connexion Bluetooth stable, d\'une réduction de bruit active et d\'une autonomie prolongée pour une expérience audio exceptionnelle.',
    category: 'Électronique',
    image: 'assets/images/earphones.jpg',
    price: 79.99,
  ),
  Product(
    id: 5,
    name: 'Enceinte Bluetooth',
    description:
        'Diffusez votre musique partout avec cette enceinte Bluetooth portable et puissante. Profitez d\'un son clair et puissant, d\'une connexion sans fil stable et d\'une autonomie longue durée pour animer vos soirées et vos déplacements.',
    category: 'Électronique',
    image: 'assets/images/speakers.jpg',
    price: 99.99,
  ),
  Product(
    id: 6,
    name: 'Montre connectée',
    description:
        'Restez connecté et suivez votre activité physique avec cette montre connectée élégante et fonctionnelle. Profitez de notifications intelligentes, d\'un suivi précis de vos performances sportives et d\'une autonomie prolongée pour une expérience connectée optimale.',
    category: 'Électronique',
    image: 'assets/images/smartwatch.webp',
    price: 149.99,
  ),
  Product(
    id: 7,
    name: 'Appareil photo numérique',
    description:
        'Capturez des moments inoubliables avec cet appareil photo numérique offrant une qualité d\'image exceptionnelle, des fonctionnalités avancées et une ergonomie intuitive. Immortalisez vos souvenirs avec une précision et une créativité sans limites.',
    category: 'Électronique',
    image: 'assets/images/camera.jpg',
    price: 399.99,
  ),
  Product(
    id: 8,
    name: 'Console de jeux vidéo',
    description:
        'Plongez dans des univers virtuels captivants avec cette console de jeux vidéo offrant des graphismes époustouflants, une expérience de jeu immersive et une vaste bibliothèque de titres. Profitez de jeux en solo ou en multijoueur pour des heures de divertissement.',
    category: 'Électronique',
    image: 'assets/images/gameconsole.jpg',
    price: 299.99,
  ),
  Product(
    id: 9,
    name: 'Drone',
    description:
        'Explorez le ciel et capturez des vues aériennes spectaculaires avec ce drone performant et facile à piloter. Profitez d\'une caméra haute résolution, d\'une stabilisation d\'image avancée et d\'une autonomie prolongée pour des prises de vue aériennes professionnelles.',
    category: 'Électronique',
    image: 'assets/images/drone.jpg',
    price: 499.99,
  ),
  Product(
    id: 10,
    name: 'Imprimante 3D',
    description:
        'Donnez vie à vos idées avec cette imprimante 3D polyvalente et performante. Créez des objets personnalisés, des prototypes et des modèles en trois dimensions avec une précision et une facilité d\'utilisation exceptionnelles.',
    category: 'Électronique',
    image: 'assets/images/3Dprinter.jpg',
    price: 699.99,
  ),
];

class Product {
  int id;
  String name;
  String description;
  String category;
  String image;
  num price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  String displayPrice() => '${price.toStringAsFixed(2)}€';
}
