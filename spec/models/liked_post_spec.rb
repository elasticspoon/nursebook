require 'rails_helper'
require_relative 'concerns/notifiyable_shared_example'

RSpec.describe LikedPost, type: :model do
  let(:liked_post) { create(:liked_post) }
  subject { liked_post }

  include_examples 'notifiyable'

  describe 'Associations' do
    it { should belong_to(:user).counter_cache(:liked_posts_cache) }
    it { should belong_to(:target).counter_cache(:likes_count).class_name('Post') }
  end
end
