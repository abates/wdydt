class Task < ActivityPlugin
  activity_description "Worked on a task"

  activity_form_field :task
  activity_form_field :hours
  activity_form_field :notes

  validates_presence_of :task
  validate :hours_must_be_positive_half_hour_increments

  def description
    "Worked on #{task}"
  end

  private
    def hours_must_be_positive_half_hour_increments
      if hours.nil? or hours <= 0
        errors.add(:hours, "must be positive")
      elsif hours % 0.5 != 0
        errors.add(:hours, "must be in half hour increments")
      end
    end
end
