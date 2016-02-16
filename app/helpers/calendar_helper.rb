module CalendarHelper
  def month_name date
    I18n.t("date.month_names")[date.month]
  end

  def month_date date
    "#{month_name(date)} #{date.day}"
  end

  def full_date date
    "#{month_date(date)}, #{date.year}"
  end

  def calendar_title date_range
    if date_range.length == 1
      full_date(date_range.first)
    else
      if date_range.first.year != date_range.last.year
        "#{full_date(date_range.first)} - #{full_date(date_range.last)}"
      elsif date_range.first.month != date_range.last.month
        "#{month_date(date_range.first)} - #{month_date(date_range.last)}, #{date_range.last.year}"
      else
        "#{month_date(date_range.first)} - #{date_range.last.day}, #{date_range.last.year}"
      end
    end
  end

  def cal type, &block
    options = {
      attribute: :day,
    }

    start_date = params[:start_date].nil? ? Date.today : params[:start_date].to_date

    case type
    when :day
      options[:events] = Activity.all.where(day: start_date)
      calendar options.merge(number_of_days: 1), &block
    when :week
      options[:events] = Activity.all.where(day: (start_date.beginning_of_week..start_date.end_of_week))
      week_calendar options, &block
    when :month
      options[:events] = Activity.all.where(day: (start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week))
      month_calendar options, &block
    else
      raise "Unknown calendar type #{type}"
    end
  end
end
