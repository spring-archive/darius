unitDef = {
  unitname            = [[armflea]],
  name                = [[Flea]],
  description         = [[All-Terrain Scout Bot]],
  acceleration        = 0.5,
  bmcode              = [[1]],
  brakeRate           = 0.5,
  buildCostEnergy     = 20,
  buildCostMetal      = 20,
  builder             = false,
  buildPic            = [[ARMFLEA.png]],
  buildTime           = 20,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  category            = [[LAND]],
  cloakCost           = 0,

  customParams        = {
    description_bp = [[Robô batedor escalador]],
    description_es = [[Robot All-Terrain de exploración]],
    description_fi = [[Maastokelpoinen tiedustelurobotti]],
    description_fr = [[Éclaireur tout terrain.]],
    description_it = [[Robot All-Terrain da ricognizione]],
    description_pl = [[Terenowy Robot Zwiadowczy]],
    helptext       = [[The Flea can hide in inaccessible locations where its sophisticate sensor suite allows it to see further than it can be seen. It can be used in small groups to effectively raid mexes early on, and in maps with tall cliffs can attack from unexpected angles. It does very little damage and dies to any form of opposition.]],
    helptext_bp    = [[Flea é o robô batedor escalador de Nova. Ele pode se esconder em locais inacessíveis onde seus sensores sofisticados permitem que ele veja mais longe do que pode ser visto. Pode ser usado em pequenos groups are atacar extratores de metais no começo do jogo, quando estao pouco defendidos, e em mapas com colinas elevadas pode atacar de ângulos inesperados. Porém ele tem muito pouco poder de fogo e resistencia, portanto morrendo frente a qualquer forma de resistencia.]],
    helptext_es    = [[El Flea puede esconderse en lugares inaccesibles donde sus sensores sofisticados le permiten ver m?s all? de que puede ser visto. Puede ser usado en grupos peque?os para efectivamente destruir mexes temprano en el juego, y en mapas con montes altos puede atacar de lugares inesperados. Hace poco da?o y muere contra qualquier tipo de oposici?n.]],
    helptext_fi    = [[Flea pystyy piileksim??n saavuttamattomissa paikoissa, joista se n?kee kehittyneen anturij?rjestelm?ns? avulla kauemmas, kuin mist? sit? pystyt??n havaitsemaan. Flea:ta voidaan k?ytt?? varhaisiin hy?kk?yksiin esimerkiksi metallikaivoksia p?in, mutta se tuhoutuu hetkess? mit? tahansa vastustusta kohdatessaan.]],
    helptext_fr    = [[Le Flea peut se cacher r des endroits inaccessibles d'ou il peut observer de loin grâce r ses capteurs sophistiqué sans etre vu. Il peut etre utilisé en petit groupe pour éffectuer des raid sur les éxtracteur de métal enemi en début de jeu, et peut attaquer par des endroit innatendus tel que les pentes raide. Il ne cause que tres peut de dégat et meurt contre toute opposition.]],
    helptext_it    = [[Il Flea pu? nascondersi in posti inaccessibili dove i suoi sensori sofisticati gli permettono vedere pi? lontano che possa essere visto. Pu? essere usato in piccoli gruppi per efficacemente distruggere mexes all'inizio del gioco, e in mappe con monti alti pu? attacare da angoli inaspettati. Fa poco danno e muore contro qualunque tipo di resistenza.]],
    helptext_pl    = [[Flea mo?e ukrywa? si? w niedost?pnych lokacjach gdzie jego sensory pozwalaj? mu obserwowa? jednocze?nie pozostaj?c niewidocznym. Mo?e by? u?ywany w ma?ych grupach aby skutecznie n?ka? ekonomiczne budynki wroga, a na mapach z wysokimi klifami mo?e zaskoczy? przeciwnika atakuj?c z zaskoczenia. Zadaje bardzo ma?e obra?enia i ginie przy jakimkolwiek oporze ze strony wroga.]],
  },

  defaultmissiontype  = [[Standby]],
  explodeAs           = [[TINY_BUILDINGEX]],
  footprintX          = 1,
  footprintZ          = 1,
  iconType            = [[spiderscout]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[640]],
  mass                = 10,
  maxDamage           = 40,
  maxSlope            = 72,
  maxVelocity         = 4.8,
  maxWaterDepth       = 15,
  minCloakDistance    = 50,
  movementClass       = [[TKBOT1]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[arm_flea.s3o]],
  pushResistant       = 1,
  seismicSignature    = 4,
  selfDestructAs      = [[TINY_BUILDINGEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:digdig]],
    },

  },

  side                = [[ARM]],
  sightDistance       = 500,
  smoothAnim          = true,
  steeringmode        = [[2]],
  TEDClass            = [[KBOT]],
  turninplace         = 0,
  turnRate            = 1672,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    LASER = {
      name                    = [[Tiny Laser]],
      areaOfEffect            = 8,
      beamlaser               = 1,
      beamTime                = 0.1,
      burstrate               = 0.2,
      coreThickness           = 0.5,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 8,
        planes  = 8,
        subs    = 0.4,
      },

      energypershot           = 0.2,
      explosionGenerator      = [[custom:FLASH1yellow2]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      laserFlareSize          = 3.22,
      lineOfSight             = true,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 140,
      reloadtime              = 0.25,
      renderType              = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[laserhit]],
      soundStart              = [[OTAunit/LASRFIR1]],
      soundTrigger            = true,
      targetMoveError         = 0.1,
      thickness               = 2.14476105895272,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 600,
    },

  },

}

return lowerkeys({ armflea = unitDef })
