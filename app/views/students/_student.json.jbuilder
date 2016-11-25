json.extract! student, :id, :name, :email, :password_digest, :created_at, :updated_at
json.url student_url(student, format: :json)