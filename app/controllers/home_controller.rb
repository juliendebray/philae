class HomeController < ApplicationController
  def index
    @trip = Trip.new
    @coming_from_campaign = false
    session[:from] = params[:from] if params[:from]
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
      tag: true,
      title: 'Planifiez votre voyage sans prise de tête',
      subtitle: 'Organisez le voyage parfait en toute simplicité avec les informations les plus fiables du web, des conseils terrain de voyageurs et des outils pratiques qui font gagner du temps',
      description: "Explorizers simplifie l'organisation de votre voyage et vous permet de partir l'esprit tranquille avec un itinéraire complétement personalisé.",
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Selectionnez les <strong>meilleures expériences</strong> à vivre en fonction de vos envies et des recommandations des principaux sites de voyage.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Evitez les attrapes-touristes et autres galères en vous inspirant des <strong>conseils d'autres voyageurs, et de vos amis</strong> grâce aux réseaux sociaux.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Votre <strong>itinéraire se calcule automatiquement</strong>, vous n'avez plus qu'à l'emmener dans vos valises et partir l'esprit tranquille.</div>"
      }
    }
  end

  def relief_hp_hash
    return {
      tag: true,
      title: 'Préparez votre voyage sans prise de tête',
      subtitle: 'Organisez le voyage parfait en toute simplicité avec les informations les plus fiables du web, des conseils terrain de voyageurs et des outils pratiques qui font gagner du temps',
      description: "Explorizers simplifie l'organisation de votre voyage et vous permet de partir l'esprit tranquille avec un itinéraire complétement personnalisé.",
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Selectionnez les <strong>meilleures expériences</strong> à vivre en fonction de vos envies et des recommandations des principaux sites de voyages.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Evitez les attrapes-touristes et autres galères en vous inspirant des <strong>conseils de vos amis et d'autres voyageurs</strong>.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Votre <strong>itinéraire se calcule automatiquement</strong>, vous n'avez plus qu'à l'emener dans vos valises et partir l'esprit tranquille.</div>"
      }
    }
  end

  def itinerary_hp_hash
    return {
      tag: true,
      title: 'Explorez le monde à votre façon',
      subtitle: "De la sélection des activités à la construction de votre itinéraire, préparez votre voyage sur-mesure avec les informations les plus fiables du web et des outils pratiques qui font gagner du temps",
      description: "Construisez facilement votre parcours selon vos envies, appuyé par des sources de confiance: les guides de voyage, d'autres voyageurs, et vos amis qui donneront directement leurs conseils sur le site.",
      item: {
        one: "<div class='how-header'><i class='fa fa-star'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionnez les <strong>meilleures expériences</strong> selon vos envies et sur la base de conseils de confiance.</div>",
        two: "<div class='how-header'><i class='fa fa-bus'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Construisez <strong>votre itinéraire sur-mesure</strong> en fonction de vos contraintes de temps et de budget.</div>",
        three: "<div class='how-header'><i class='fa fa-book'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Sauvegardez votre itinéraire dans <strong>votre espace personnel</strong>, pour le compléter et y avoir accès quand vous voulez.</div>"
      }
    }
  end

  def agency_hp_hash
    return {
      title: 'Votre agence de voyage digitale',
      subtitle: "Détendez-vous, on s'occupe de tout. Et c'est gratuit.",
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
      subtitle: 'Accédez aux conseils de voyage de vos amis et sauvegardez les votres dans votre espace perso',
      description: "Bonnes adresses, itinéraires, lieux à ne pas rater : les meilleurs conseils de voyage viennent souvent de nos amis. Explorizers permet de noter et d'échanger ces bons plans entre amis, de manière totalement privée.",
      item: {
        one: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Recupérez les <strong>conseils de vos amis</strong> pour votre prochain voyage.</div>",
        two: "<div class='how-header'><i class='fa fa-thumbs-up'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sauvegardez vos <strong>lieux préférés</strong> pour les recommander ensuite.</div>",
        three: "<div class='how-header'><i class='fa fa-users'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'><strong>Partagez vos bons plans</strong> entre amis, selon la confidentialité souhaitée.</div>"
      }
    }
  end
end
