# Views helper methods to clean-up logic in resources views
module ResourcesHelper


  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def new_resource_helper(object)
    if defined? object.subject
      {
        controller: "resources",
        action: "new",
        category_id: object.category.id,
        subject_id: object.subject.id
      }
    else
      {
        controller: "resources",
        action: "new",
        category_id: object.category.id,
        subject_id: object.id
      }
    end
  end

  def calc_usability_rating
    unless @resource.ratings == []
      (@resource.ratings.map(&:usability_rating).inject(0, :+))/ @resource.ratings.where.not(usability_rating: nil).count
    end
  end

  def calc_addictiveness_rating
    unless @resource.ratings == []
      (@resource.ratings.map(&:addictive_rating).inject(0, :+))/ @resource.ratings.where.not(addictive_rating: nil).count
    end
  end


end
