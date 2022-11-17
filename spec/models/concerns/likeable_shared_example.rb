require 'rails_helper'

RSpec.shared_examples 'likeable' do |likeable_name|
  let(:likeable) { create(likeable_name) }
  subject { likeable }

  describe 'Associations' do
    let(:through_table) { :"user_liked_#{likeable_name}s" }
    let(:through_table_class) { "Liked#{likeable_name.to_s.capitalize}" }

    it {
      should have_many(through_table)
        .dependent(:destroy).inverse_of(likeable_name)
        .class_name(through_table_class)
    }

    it {
      should have_many(:likers).through(through_table)
        .counter_cache(:likes_count).source(:user)
    }
  end
end
