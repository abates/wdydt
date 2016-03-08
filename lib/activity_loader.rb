class ActivityLoader
  def self.unload! activity_type
    Rails.logger.debug("Unloading #{activity_type}")
    if Object.const_defined?(activity_type.class_name)
      Object.send(:remove_const, activity_type.class_name)
    end
  end

  def self.load! activity_type
    Rails.logger.debug("Loading #{activity_type}")
    unless Object.const_defined?(activity_type.class_name)
      Rails.logger.debug("Creating class #{activity_type.class_name}")
      Object.const_set(activity_type.class_name, Class.new(ActiveRecord::Base))
    end
  end

  def self.reload!
    if ActiveRecord::Base.connection.table_exists? 'activity_types'
      Rails.logger.debug("Reloading dynamic activities")
      ActivityType.all.each do |activity_type|
        unload!(activity_type)
        load!(activity_type)
      end
    else
      Rails.logger.warn("activity_types table does not appear to exist so no ActivityType constants are being created")
    end
  end
end
