class CalendarController < AuthenticatedController
  def day
    @activities = []
  end

  def week
    @activities = []
  end

  def month
    @activities = []
  end
end
