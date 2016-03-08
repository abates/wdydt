class ActivityType < ActiveRecord::Base
  before_save :set_class_name
  before_create :set_class_name, :create_table
  before_destroy :drop_table

  has_many :fields, class_name: "ActivityField"

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

  private
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
