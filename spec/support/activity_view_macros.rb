module ActivityViewMacros
  def setup_activity_view
    create_test_activities

    before(:each) do
      @activity_type = assign(:activity_type, @activity_type1)
      activity_type = @activity_type
      controller.singleton_class.class_eval do
        define_method :url_options do
          return { activity_type: activity_type.table_name }
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.extend ActivityViewMacros, :type => :view
end
