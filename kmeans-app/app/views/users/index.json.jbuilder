json.array!(@users) do |user|
  json.extract! user, :name, :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10
  json.url user_url(user, format: :json)
end
