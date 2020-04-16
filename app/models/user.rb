class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates_presence_of :name, :address, :city, :state, :zip, :password_digest

  has_many :orders
  belongs_to :merchants, optional:true
  enum role: {default: 0, merchant: 1, admin: 2}

  def info
    {name: name, address: address, city: city, state: state, zip: zip, email: email}
  end

  def pending_orders
    if admin?
      Order.where(status: 0)
    end
  end

  def packaged_orders
    if admin?
      Order.where(status: 1)
    end
  end

  def shipped_orders
    if admin?
      Order.where(status: 2)
    end
  end

  def cancelled_orders
    if admin?
      Order.where(status: 3)
    end
  end

end
