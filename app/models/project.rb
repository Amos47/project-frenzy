class Project < ApplicationRecord
  belongs_to :professor
  belongs_to :student, optional: true
end
