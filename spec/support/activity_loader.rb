class ActivityLoader
  @@activity_types = []

  def self.reset!
    @@activity_types.each do |activity_type|
      unload!(activity_type)
    end
    @@activity_types = []
  end

  singleton_class.send(:alias_method, :original_load!, :load!)
  def self.load! activity_type_instance
    @@activity_types << activity_type_instance
    original_load!(activity_type_instance)
  end
end

