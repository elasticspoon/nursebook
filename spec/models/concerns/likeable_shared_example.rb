require 'rails_helper'

RSpec.shared_examples 'likeable' do |likeable_name|
  let(:likeable) { create(likeable_name) }
  subject { likeable }

  describe 'Associations' do
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:likers).through(:likes).source(:user) }
  end
end
