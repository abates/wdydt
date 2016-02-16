class Activity < ActiveRecord::Base
  actable

  def description
    specific.description
  end

  def activity_type
    specific.activity_type
  end
end
