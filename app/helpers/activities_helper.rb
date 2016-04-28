module ActivitiesHelper
  def activity_path_prefix
    return controller_name == "dashboard" ? "dashboard_" : ""
  end

  def specific_activity_path activity
    if activity.id.nil?
      send("#{activity_path_prefix}activities_path")
    else
      send("#{activity_path_prefix}activity_path", activity)
    end
  end
end
