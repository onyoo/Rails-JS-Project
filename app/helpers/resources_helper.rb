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

end
