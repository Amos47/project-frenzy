json.extract! project, :id, :title, :description, :publish_at, :created_at, :updated_at
json.url project_url(project, format: :json)