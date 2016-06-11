json.array!(@answers) do |answer|
  json.extract! answer, :id, :content, :user_id, :question_id
  json.url answer_url(answer, format: :json)
end
