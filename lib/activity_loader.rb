class ActivityLoader
  def self.unload! activity_type
    Rails.logger.debug("Unloading #{activity_type}")
    if Object.const_defined?(activity_type.class_name)
      Object.send(:remove_const, activity_type.class_name)
    end
  end

  def self.load! activity_type_instance
    if Object.const_defined?(activity_type_instance.class_name)
      Rails.logger.warn("#{activity_type_instance.class_name} is already loaded, cannot reload it")
    else Object.const_defined?(activity_type_instance.class_name)
      Rails.logger.debug("Creating class #{activity_type_instance.class_name}")
      Object.const_set(activity_type_instance.class_name, Class.new(ActiveRecord::Base) do |klass|
        acts_as :activity
        validate :activity_validator

        def klass.column_types
          super.merge("day" => Activity.column_types["day"])
        end

        define_method :attribute_hash do
          Hash[*attributes.map{ |k,v| [k, v, k.to_sym, v] }.flatten]
        end

        define_method :description do
          begin
            return activity_type_instance.singular_description % attribute_hash
          rescue KeyError => e
            Rails.logger.error("Failed to generate description: #{e}.  Description string: #{activity_type_instance.singular_description}")
            return ""
          end
        end

        define_method :activity_type do
          activity_type_instance
        end

        define_method :activity_validator do
          activity_type_instance.validators.each do |validator|
            unless(validator.evaluate(self))
              if validator.activity_field.nil?
                errors.add(:base, validator.message)
              else
                errors.add(validator.activity_field.name, validator.message)
              end
            end
          end
        end
      end)
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
