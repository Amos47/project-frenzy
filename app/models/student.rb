class Student < ApplicationRecord

  has_one :project, dependent: :nullify

  validates_uniqueness_of :email
  validates_presence_of :name, :email
  has_secure_password

end
