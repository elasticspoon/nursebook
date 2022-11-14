class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  before_destroy :nullify_dependents

  has_many :posts, inverse_of: :creator, dependent: false, counter_cache: :posts_cache
  has_many :user_liked_posts, dependent: :destroy, inverse_of: :user, class_name: 'LikedPost'
  has_many :liked_posts, through: :user_liked_posts, source: :post, counter_cache: :liked_posts_cache

  has_many :comments, inverse_of: :creator, dependent: false, counter_cache: :comments_cache
  has_many :user_liked_comments, dependent: :destroy, inverse_of: :user, class_name: 'LikedComment'
  has_many :liked_comments, through: :user_liked_comments, source: :comment, counter_cache: :liked_comments_cache

  private

  # TODO: - shove this into a background job
  def nullify_dependents
    dependents.each do |dependent|
      send(dependent)&.update_all(user_id: nil) # rubocop:disable Rails/SkipsModelValidations
    end
  end

  def dependents
    User.reflect_on_all_associations(:has_many).filter_map do |association|
      association.name if association&.options&.[](:dependent) == false
    end
  end
end
