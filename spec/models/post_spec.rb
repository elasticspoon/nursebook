require 'rails_helper'
require_relative 'concerns/likeable_shared_example'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  subject { post }

  include_examples 'likeable', :post

  describe 'Associations' do
    it { should belong_to(:creator).inverse_of(:posts).class_name('User').validate(false).optional(true) }
    it { should have_many(:comments).dependent(:destroy).inverse_of(:parent).counter_cache(:direct_comments_count) }
    it { should have_many(:total_comments).dependent(:destroy).class_name('Comment').counter_cache(:comments_count) }
    it { should have_many_attached(:images) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:creator).on(:create) }
  end

  describe 'Callbacks' do
  end
end
