require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { create(:friendship) }
  subject { friendship }

  describe 'Associations' do
    it { should belong_to(:user_one).class_name('User').counter_cache(:friends_cache) }
    it { should belong_to(:user_two).class_name('User').counter_cache(:friends_cache) }
  end
end
