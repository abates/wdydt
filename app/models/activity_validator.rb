class ActivityValidator < ActiveRecord::Base
  belongs_to :activity_type
  belongs_to :activity_field

  after_initialize :initialize_calculator
  
  validates_presence_of :description, :formula, :message
  validate :syntax_of_formula

  def evaluate model
    @calculator.evaluate(formula, model.attribute_hash)
  end

  private
    def syntax_of_formula
      begin
        @calculator.evaluate(formula)
      rescue => e
        errors.add(:formula, e.message)
      end
    end

    def initialize_calculator
      @calculator = Dentaku::Calculator.new
    end
end
