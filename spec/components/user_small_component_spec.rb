# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSmallComponent, type: :component do
  it 'renders without throwing an error' do
    expect { render_inline(described_class.new) }.not_to raise_error
  end
end
