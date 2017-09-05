class ScraperController < ApplicationController
  include ScraperHelper

  def show_form
    @providers = Provider.all.order('id')
  end

  def store
    user = User.first_or_create(email: user_params['email'])
    provider = Provider.find_by_name(user_params['provider'])
    code = ShipmentCode.first_or_create(user_id: user.id,
                                        provider_id: provider.id,
                                        code: user_params['code'])
    scrape_into_db(provider.address, user_params['code'], code.id)
    redirect_to '/'
  end


  private
  def user_params
    params.require(:user).permit(:email, :code, :provider)
  end
end
