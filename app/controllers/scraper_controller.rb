class ScraperController < ApplicationController
  include ScraperHelper

  def show_form

  end

  def store
    user = User.first_or_create(email: user_params['email'])
    code = Shipment.first_or_create(user_id: user.id, code: user_params['code'])
    scrape_into_db(user_params['code'], code.id)
    redirect_to '/'
  end

  def testis

  end

  private
  def user_params
    params.require(:user).permit(:email, :code)
  end
end
