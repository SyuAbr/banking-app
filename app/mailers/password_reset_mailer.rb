class PasswordResetMailer < ApplicationMailer
  def reset_email
    @client = params[:client]
    mail to: @client.email, subject: I18n.t('passwor_reset_mailer.reset_email.subject')
  end
end
