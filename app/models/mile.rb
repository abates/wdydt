class Mile < ActivityPlugin
  activity_description "Drove somewhere"

  activity_form_field :origin
  activity_form_field :destination
  activity_form_field :distance
  activity_form_field :notes

  def description 
    "Drove to #{destination}"
  end
end
