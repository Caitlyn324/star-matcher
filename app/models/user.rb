class User < ApplicationRecord
 #password, phone_number
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+ [a-zA-Z]+\z/,
    message: 'must be a first name and last name!'
  }

  validates :email, uniqueness: true, format: { with: /\A([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)\z/,
    message: "isn't valid!"
  }

  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A[\\(]{0,1}([0-9]){3}[\\)]{0,1}[ ]?([^0-1]){1}([0-9]){2}[ ]?[-]?[ ]?([0-9]){4}[ ]*((x){0,1}([0-9]){1,5}){0,1}\z/,
    message: "isn't valid!"
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
