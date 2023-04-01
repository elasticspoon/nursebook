# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentComponent, type: :component do
  let(:comment) { build_stubbed(:comment) }
  let(:user) { build_stubbed(:user) }

  context 'when there is a current_user' do
    it 'renders without throwing an error' do
      expect { render_inline(described_class.new(comment:)) }.not_to raise_error
    end
  end
  context 'when there is no current_user' do
    it 'renders without throwing an error' do
      expect { render_inline(described_class.new(comment:, current_user: user)) }.not_to raise_error
    end
  end
end
