class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.scrape_info.subject
  #
  def scrape_info(email, scrape)
    @scrape = scrape
    mail to:email
  end
end
