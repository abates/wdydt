class ActivityPlugin < ActiveRecord::Base
  self.abstract_class = true

  module ClassMethods
    def activity_form_field field
      activity_field field
      @activity_form_fields ||= []
      @activity_form_fields << field
    end

    def activity_form_fields
      @activity_form_fields || column_names.exclude_if { |column| column =~ /id$/ or column =~ /(?:created)|(?:updated)_at/ }
    end

    def activity_field field
      @activity_fields ||= []
      @activity_fields << field
    end

    def activity_fields
      @activity_fields || column_names.exclude_if { |column| column =~ /id$/ }
    end

    def column_types
      super.merge("day" => Activity.column_types["day"])
    end

    def title
      name.tableize.humanize.split(/\s+/).map { |word| word.capitalize }.join(" ")
    end

    def activity_type
      name.tableize
    end

    def activity_description activity_description=nil
      unless activity_description.nil?
        @activity_description = activity_description
      end
      
      @activity_description
    end
  end

  module InstanceMethods
    def activity_type
      self.class.activity_type
    end
  end

  def self.inherited klass
    super klass

    klass.singleton_class.module_eval do
      include ClassMethods
    end
    include InstanceMethods

    klass.acts_as :activity
    klass.activity_form_field :day
  end

  def self.find *args
    if self == ActivityPlugin
      all[args.first]
    else
      super(*args)
    end
  end

  def self.all *args
    if self == ActivityPlugin
      if @plugins.nil?
        @plugins = {}
        [ Expense, Mile, Task ].each do |plugin|
          @plugins[plugin.name.tableize] = plugin
        end
      end
      @plugins
    else
      super(*args)
    end
  end

  def description
    self.class.activity_description
  end
end
