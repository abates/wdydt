class ActivityField < ActiveRecord::Base
  belongs_to :activity_type

  after_save :add_column
  before_destroy :drop_column

  validates :activity_type, presence: true

  def column_name
    name.downcase.gsub(/\s+/, "_")
  end

  private
    def add_column
      ActiveRecord::Base.connection.add_column activity_type.table_name, column_name, field_type
      activity_type.activity_class.reset_column_information
    end

    def drop_column
      ActiveRecord::Base.connection.remove_column activity_type.table_name, column_name
      activity_type.activity_class.reset_column_information
    end
end
