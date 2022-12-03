require 'rails_helper'
require_relative 'concerns/notifiyable_shared_example'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  # before { allow(like).to receive(:notify) }

  subject { like }
  include_examples 'notifiyable'

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:target).counter_cache(:likes_count) }
  end
end
