class HomeController < ApplicationController
  def index
    @trip = Trip.new
    @hp_hash = create_hash_according_traffic_source(params[:from])
  end



  private
  def create_hash_according_traffic_source(traffic_source)
    case traffic_source
    when "relief"
      return relief_hp_hash
    when "itinerary"
      return itinerary_hp_hash
    when "agency"
      return agency_hp_hash
    when "social"
      return social_hp_hash
    else
      return default_hp_hash
    end
  end

  def default_hp_hash
    return {
      title: 'Ton voyage commence ici',
      subtitle: 'Le meilleur du web pour organiser le voyage de tes rêves',
      description: 'EXPLORIZERS te permet de savoir "que faire" et "que voir" lors de ton prochain voyage en se basant sur les recommandations et services des principaux sites de voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionne les <strong>meilleures expériences</strong> à faire pendant ton voyage sur la base de milliers de notes et d'avis.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Inspire-toi des <strong>conseils les plus utiles</strong> des guides et voyageurs afin d'éviter attrapes-touristes et autres galères.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Récupère ton <strong>itinéraire personnalisé</strong>, partage-le avec tes amis et emmène-le dans tes valises.</div>"
      }
    }
  end

  def relief_hp_hash
    return {
      title: 'Préparez votre voyage en toute simplicité',
      subtitle: 'Organisez le voyage parfait en quelques minutes... sans prise de tête',
      description: "Explorizers simplifie l'organisation de votre voyage et vous permet de partir l'esprit tranquille avec un itinéraire complétement personalisé.",
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Selectionnez les <strong>meilleures expériences</strong> à vivre en fonction de vos envies et des recommandations des principaux sites de voyages (TripAdvisor, Lonely Planet, Le Guide du Routard).</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Evitez les attrapes-touristes et autres galères en vous inspirant des <strong>conseils de vos amis et d'autres voyageurs</strong>.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Votre <strong>itinéraire se calcule automatiquement</strong>, vous n'avez plus qu'à l'emener dans vos valises et partir l'esprit tranquille.</div>"
      }
    }
  end

  def itinerary_hp_hash
    return {
      title: 'Explorez le monde à votre façon',
      subtitle: "Créez facilement votre voyage sur-mesure, de la sélection des activités à l'élaboration de l'itinéraire",
      description: 'Explorizers propose des outils pratiques pour sélectionner des expériences inoubliables et élaborer facilement un itinéraire pour votre prochain voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-star'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionnez les meilleures expériences <strong>selon vos envies</strong> : reposantes, sportives, incontournables ou authentiques...</div>",
        two: "<div class='how-header'><i class='fa fa-bus'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Construisez <strong>votre itinéraire sur-mesure</strong> en fonction de vos contraintes de temps et de budget.</div>",
        three: "<div class='how-header'><i class='fa fa-book'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Conservez votre projet de voyage dans <strong>votre espace perso</strong> pour y accéder quand vous voulez.</div>"
      }
    }
  end

  def agency_hp_hash
    return {
      title: 'Votre agence de voyage digitale',
      subtitle: "Laissez-vous faire, on s'occupe de tout. Et c'est gratuit.",
      description: "Explorizers permet de concevoir son propre voyage de A à Z, du choix des destinations jusqu'aux réservations. Explorizers propose des expériences uniques, des informations pratiques et des outils pour l'explorateur connecté.",
      item: {
        one: "<div class='how-header'><i class='fa fa-globe'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Obtenez rapidement un <strong>parcours optimisé</strong> prenant en compte vos envies et vos contraintes.</div>",
        two: "<div class='how-header'><i class='fa fa-plane'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Réservez <strong>vos hôtels et vos transports</strong> depuis Explorizers.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Repartez avec une <strong>synthèse de votre parcours</strong> et vos résérvations.</div>"
      }
    }
  end

  def social_hp_hash
    return {
      title: 'Le voyage inspiré par ses amis',
      subtitle: 'Sauvegardez vos bons plans de voyage et accédez à ceux de vos amis',
      description: "Bonnes adresses, itinéraires, lieux à ne pas rater : les meilleurs conseils de voyage viennent souvent de nos amis. Explorizers permet de noter et d'échanger ces bons plans entre amis, de manière totalement privée.",
      item: {
        one: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Recupérez les <strong>conseils de vos amis</strong> pour votre prochain voyage.</div>",
        two: "<div class='how-header'><i class='fa fa-thumbs-up'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sauvegardez vos <strong>lieux préférés</strong> pour les recommander ensuite.</div>",
        three: "<div class='how-header'><i class='fa fa-users'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'><strong>Partagez vos bons plans</strong> entre amis, selon la confidentialité souhaitée.</div>"
      }
    }
  end
end
