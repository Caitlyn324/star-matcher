class User < ApplicationRecord
  validate :type, format: { with: /\A(actor)|(director)\z/,
    message: "Must be either an actor or director!"
  }

  validate :phone_number, format: { with: /((\([2-9]{3}\) ?)|(\d{3}-))?\d{3}-\d{4}/,
    message: "Sorry, we need a phone number!"
  }

  validate :email, format: { with: /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/,
    message: "Sorry, your email doesn't seem valid!"
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

end
