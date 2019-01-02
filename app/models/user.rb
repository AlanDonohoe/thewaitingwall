class User < ApplicationRecord
  ROLES = %i[boss admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def create_new_admin_user(email, password)
    user = User.new({email: email, roles: ["admin"], password: password, password_confirmation: password })
    user.skip_confirmation!
    user.save
  end

  def boss?
    "boss" == role
  end

  def admin?
    "admin" == role
  end
end
