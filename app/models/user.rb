class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  before_destroy :nullify_dependents

  has_one :profile, dependent: :destroy, class_name: 'UserProfile'

  # Posts
  has_many :posts, inverse_of: :creator, dependent: false, counter_cache: :posts_cache
  has_many :user_liked_posts, dependent: :destroy, inverse_of: :user, class_name: 'LikedPost'
  has_many :liked_posts,
           through: :user_liked_posts,
           source: :target,
           counter_cache: :liked_posts_cache

  # Comments
  has_many :comments, inverse_of: :creator, dependent: false, counter_cache: :comments_cache
  has_many :user_liked_comments, dependent: :destroy, inverse_of: :user, class_name: 'LikedComment'
  has_many :liked_comments, through: :user_liked_comments, source: :target, counter_cache: :liked_comments_cache

  # Friend Requests
  has_many :outgoing_friend_requests,
           dependent: :destroy,
           inverse_of: :sender,
           class_name: 'Request',
           foreign_key: :sender_id
  has_many :incoming_friend_requests,
           dependent: :destroy,
           inverse_of: :receiver,
           class_name: 'Request',
           foreign_key: :receiver_id,
           counter_cache: :friend_requests_cache
  has_many :request_senders, through: :incoming_friend_requests, source: :sender
  has_many :request_targets, through: :outgoing_friend_requests, source: :receiver

  # Friendships
  has_many :friendships,
           lambda { |user|
             unscope(where: :user_one_id).where(
               'user_one_id = ? OR user_two_id = ?',
               user.id,
               user.id
             )
           },
           inverse_of: :user_one,
           dependent: :destroy,
           foreign_key: :user_one_id
  has_many :friends,
           lambda { |user|
             joins('OR users.id = friendships.user_one_id').where.not(id: user.id).distinct
           },
           through: :friendships,
           source: :user_two,
           counter_cache: :friends_cache

  # Notifications
  has_many :notifications, dependent: :destroy, inverse_of: :target, foreign_key: :target_id

  def name
    user_profile = profile

    return "#{user_profile.first_name} #{user_profile.last_name}" if user_profile

    email
  end

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
