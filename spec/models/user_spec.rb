require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  subject { user }
  describe 'Associations' do
    it { should have_many(:posts).dependent(false).inverse_of(:creator) }
  end

  describe 'Validations' do
  end

  describe 'Callbacks' do
    it 'should nullify dependents on deletion' do
      expect(user).to receive(:nullify_dependents)
      user.destroy
    end
  end
end
