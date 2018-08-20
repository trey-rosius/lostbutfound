class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :products  
    belongs_to :location
    validates :phoneNumber, format: { with: /\A\d+\z/, message: "Integer only. No characters allowed." }

    before_save {self.email = email.downcase}

    def full_name
      return "#{first_name} #{last_name}".strip if (first_name || last_name)
      "Anonymous"
      
    end
    def disable_user
      update active: !active
    end
    def except_admin_user(users)
      users.reject{
      |user| user.admin==true
      }
    end
 
end
