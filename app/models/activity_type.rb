require 'ostruct'

class ActivityType < ActiveRecord::Base
  after_create :load_constant
  before_save :set_class_name
  before_create :set_class_name, :create_table
  before_destroy :drop_table

  has_many :fields, class_name: "ActivityField"
  has_many :validators, class_name: "ActivityValidator"

  validate :name_not_changed

  def activity_class
    class_name.constantize
  end

  def plural_name
    name.pluralize
  end

  def table_name
    class_name.tableize
  end

  def to_s
    name
  end

  def form_fields
    f = fields.map { |field| OpenStruct.new({name: field.name, field_type: field.field_type, column_name: field.column_name}) }
    f.unshift OpenStruct.new({ name: "day", field_type: "Date", column_name: "day" })
    f
  end

  private
    def load_constant
      ActivityLoader.load! self
    end

    def set_class_name
      self.class_name = name.gsub(/\s+/, "_").classify
    end

    def create_table
      ActiveRecord::Base.connection.create_table table_name
    end

    def drop_table
      ActiveRecord::Base.connection.drop_table table_name
    end

    def name_not_changed
      if name_changed? && self.persisted?
        errors.add(:name, "Name cannot be changed!")
      end
    end
end
