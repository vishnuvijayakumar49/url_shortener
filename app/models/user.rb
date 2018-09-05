class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable
  validates_uniqueness_of :email, presence: true, case_sensitive:false, message: 'must include unique email'
end
