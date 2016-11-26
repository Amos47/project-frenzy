class Professor < ApplicationRecord

  validates_uniqueness_of :email
  validates_presence_of :email, :name
  has_secure_password

end
