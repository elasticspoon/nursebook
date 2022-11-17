module Likeable
  extend ActiveSupport::Concern

  included do
    has_many through_table,
             dependent: :destroy,
             class_name: through_table_class,
             inverse_of: name.downcase
    has_many :likers, through: through_table, source: :user, counter_cache: :likes_count
  end

  class_methods do
    private

    def through_table
      :"user_liked_#{name.downcase}s"
    end

    def through_table_class
      "Liked#{name}"
    end
  end
end
