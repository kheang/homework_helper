json.array!(@problems) do |problem|
  json.extract! problem, :id, :issue, :try, :user_id
  json.url problem_url(problem, format: :json)
end
