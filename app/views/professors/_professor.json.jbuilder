json.extract! professor, :id, :name, :email, :password_digest, :created_at, :updated_at
json.url professor_url(professor, format: :json)