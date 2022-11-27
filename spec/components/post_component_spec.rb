# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe PostComponent, type: :component do
  let(:current_user) { build_stubbed(:user) }
  let(:post) { build_stubbed(:post, creator: build_stubbed(:user_with_profile)) }
  let(:post_component) { described_class.new(post:, current_user:) }

  describe '#likes_num' do
    it 'returns the number of likes' do
      allow(post).to receive(:likers).and_return(Array.new(3))
      expect(post_component.likes_num).to eq(3)
    end
  end

  describe '#creator_name' do
    it 'returns the name of the post creator' do
      first_name = post_component.first_name
      last_name = post_component.last_name
      expected_name = "#{first_name} #{last_name}"
      expect(post_component.creator_name).to eq(expected_name)
    end
  end

  describe '#liked' do
    it 'sends the #liked_by? message to the post' do
      expect(post).to receive(:liked_by?).with(current_user)
      post_component.liked
    end
  end

  describe '#likes_count' do
    it 'returns an empty span if the post has no likes' do
      allow(post).to receive(:likers).and_return([])
      expect(post_component.likes_count).to have_css 'span', text: ''
    end

    it 'returns a span with class "post__social-data--hidden" if the post has no likes' do
      allow(post).to receive(:likers).and_return([])
      expect(post_component.likes_count).to have_css 'span.post__social-data--hidden'
    end

    context 'when you have liked the post' do
      it 'returns you and the number of likes if there are other likes' do
        allow(post).to receive(:liked_by?).and_return(true)
        allow(post).to receive(:likers).and_return(Array.new(2))
        expect(post_component.likes_count).to have_content('You and 1 others')
      end

      it 'returns just name if there are no other likes' do
        allow(post).to receive(:liked_by?).and_return(true)
        allow(post).to receive(:likers).and_return([current_user])
        expect(post_component.likes_count).to have_content(current_user.name)
      end
    end

    context 'when you have not liked the post' do
      it 'returns the number of likes if the post has likes' do
        likes_num = 1
        allow(post).to receive(:likers).and_return(Array.new(likes_num))
        count = post_component.likes_count
        expect(count).to have_content(likes_num)
      end
    end
  end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end

# rubocop:enable Metrics/BlockLength
