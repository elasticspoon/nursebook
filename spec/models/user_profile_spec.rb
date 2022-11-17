require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  let(:user_profile) { create(:user_profile) }

  subject { user_profile }
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:avatar) }
  end

  describe 'Validations' do
  end

  describe 'Callbacks' do
  end
end
