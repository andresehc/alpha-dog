class User < ApplicationRecord
  has_many :articles
  before_save { self.email = email.downcase}
  validates :username, presence: true , 
            # uniqueness: true, 
            uniqueness: {case_sensitive: false }, 
            length: { minimum: 3, maximum: 20}
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i            
  validates :email, presence: true , 
            length: { minimum: 7, maximum: 100},
            # uniqueness: true, 
            uniqueness: {case_sensitive: false },
            format: {with: VALID_EMAIL_REGEX}
has_secure_password

end