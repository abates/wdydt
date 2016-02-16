module ActivitiesHelper
  def specific_activity_path activity
    if activity.id.nil?
      send("#{controller_name.classify.tableize}_path")
    else
      send("#{controller_name.classify.underscore}_path", activity)
    end
  end

  def link_to_activities activity, options={}, &block
    link_to(activity.title, activities_path(activity.name.tableize), options, &block)
  end

  def link_to_new_activity activity, options={}, &block
    link_to_activity activity, "new", options, &block
  end

  def link_to_activity activity, action, options={}, &block
    options = {
      "data-type" => activity.name, 
    }.merge(options)
    description = activity.activity_description
    controller = activity.name.underscore.pluralize
    if action == "index"
      description = activity.title
    end

    if block.nil?
      link_to(description, url_for(controller: controller, action: action), options)
    else
      link_to(url_for(controller: controller, action: action), options, &block)
    end
  end
end
