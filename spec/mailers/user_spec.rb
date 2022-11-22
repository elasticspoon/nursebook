require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome_user' do
    let(:user) do
      create(:user) do |user|
        create(:user_profile, user:)
      end
    end
    let(:mail) { UserMailer.with(user:).welcome_user }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Nursebook!')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
