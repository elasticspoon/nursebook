# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/welcome_user
  def welcome_user
    new_user = FactoryBot.create(:user) do |user|
      FactoryBot.create(:user_profile, user:)
    end
    UserMailer.with(user: new_user).welcome_user
  end
end
