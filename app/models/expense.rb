class Expense < ActivityPlugin
  activity_description "Paid for something"

  activity_form_field :category
  activity_form_field :amount
  activity_form_field :notes


  def description 
    "Paid for #{category}"
  end
end
