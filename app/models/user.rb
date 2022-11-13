class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  before_destroy :nullify_dependents

  has_many :posts, inverse_of: :creator, dependent: false

  private

  # TODO: - shove this into a background job
  def nullify_dependents
    dependents.each do |dependent|
      send(dependent)&.update_all(user_id: nil) # rubocop:disable Rails/SkipsModelValidations
    end
  end

  def dependents
    User.reflect_on_all_associations(:has_many).map do |association|
      association.name if association&.options&.[](:dependent) == false
    end
  end
end
