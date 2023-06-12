class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture
    user_email = @picture.user.email
    mail to: user_email, subject: "投稿の確認メール"
  end
end
