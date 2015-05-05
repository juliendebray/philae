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
      title: 'TON VOYAGE COMMENCE ICI',
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
      title: 'TON VOYAGE COMMENCE ICI',
      subtitle: 'Le meilleur du web pour organiser le voyage de tes rêves',
      description: 'EXPLORIZERS te permet de savoir "que faire" et "que voir" lors de ton prochain voyage en se basant sur les recommandations et services des principaux sites de voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionne les <strong>meilleures expériences</strong> à faire pendant ton voyage sur la base de milliers de notes et d'avis.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Inspire-toi des <strong>conseils les plus utiles</strong> des guides et voyageurs afin d'éviter attrapes-touristes et autres galères.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Récupère ton <strong>itinéraire personnalisé</strong>, partage-le avec tes amis et emmène-le dans tes valises.</div>"
      }
    }
  end

  def itinerary_hp_hash
    return {
      title: 'TON VOYAGE COMMENCE ICI',
      subtitle: 'Le meilleur du web pour organiser le voyage de tes rêves',
      description: 'EXPLORIZERS te permet de savoir "que faire" et "que voir" lors de ton prochain voyage en se basant sur les recommandations et services des principaux sites de voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionne les <strong>meilleures expériences</strong> à faire pendant ton voyage sur la base de milliers de notes et d'avis.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Inspire-toi des <strong>conseils les plus utiles</strong> des guides et voyageurs afin d'éviter attrapes-touristes et autres galères.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Récupère ton <strong>itinéraire personnalisé</strong>, partage-le avec tes amis et emmène-le dans tes valises.</div>"
      }
    }
  end

  def agency_hp_hash
    return {
      title: 'TON VOYAGE COMMENCE ICI',
      subtitle: 'Le meilleur du web pour organiser le voyage de tes rêves',
      description: 'EXPLORIZERS te permet de savoir "que faire" et "que voir" lors de ton prochain voyage en se basant sur les recommandations et services des principaux sites de voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionne les <strong>meilleures expériences</strong> à faire pendant ton voyage sur la base de milliers de notes et d'avis.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Inspire-toi des <strong>conseils les plus utiles</strong> des guides et voyageurs afin d'éviter attrapes-touristes et autres galères.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Récupère ton <strong>itinéraire personnalisé</strong>, partage-le avec tes amis et emmène-le dans tes valises.</div>"
      }
    }
  end

  def social_hp_hash
    return {
      title: 'TON VOYAGE COMMENCE ICI',
      subtitle: 'Le meilleur du web pour organiser le voyage de tes rêves',
      description: 'EXPLORIZERS te permet de savoir "que faire" et "que voir" lors de ton prochain voyage en se basant sur les recommandations et services des principaux sites de voyage.',
      item: {
        one: "<div class='how-header'><i class='fa fa-map-marker'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Sélectionne les <strong>meilleures expériences</strong> à faire pendant ton voyage sur la base de milliers de notes et d'avis.</div>",
        two: "<div class='how-header'><i class='fa fa-comment'></i></div><div class='vertical-spacer-xs'></div><div class='how-content'>Inspire-toi des <strong>conseils les plus utiles</strong> des guides et voyageurs afin d'éviter attrapes-touristes et autres galères.</div>",
        three: "<div class='how-header'><i class='fa fa-cloud-download'></i></div><div class='vertical-spacer-xs'></div>   <div class='how-content'>Récupère ton <strong>itinéraire personnalisé</strong>, partage-le avec tes amis et emmène-le dans tes valises.</div>"
      }
    }
  end
end
