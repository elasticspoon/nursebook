require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  subject { post }
  describe 'Associations' do
    it { should belong_to(:creator).inverse_of(:posts).class_name('User').validate(false).optional(true) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:creator).on(:create) }
  end

  describe 'Callbacks' do
  end
end
