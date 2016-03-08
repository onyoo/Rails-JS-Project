# Views helper methods to clean-up logic related to subjects
module SubjectsHelper

  def new_resource_helper(subject)
      {
        controller: "resources",
        action: "new",
        category_id: subject.category.id,
        subject_id: subject.id
      }
  end

end
