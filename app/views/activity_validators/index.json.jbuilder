json.array!(@activity_validators) do |activity_validator|
  json.extract! activity_validator, :id, :activity_type_id, :activity_field_id, :description, :formula, :message
  json.url activity_validator_url(activity_validator, format: :json)
end
