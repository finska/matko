require 'open-uri'
require 'nokogiri'
class ScraperController < ApplicationController
  def show_form
  end

  def db
    user = User.first_or_create(email: user_params['email'])
    code = Code.first_or_create(user_id: user.id, code: user_params['code'])
    scrape_into_db(user_params['code'], code.id)
    redirect_to '/'
  end

  def scrape_into_db(code, code_id)
    search_html(code).each do |row|
      td = row.css('td')
      insert_record_if_not_exists(td, code_id)
    end
  end

  def insert_record_if_not_exists(td, code_id)
    time = DateTime.parse(td[0].inner_html)

    Scrape.find_or_create_by!(code_id: code_id,
                              time: td[0].inner_html.to_datetime,
                              status: td[1].inner_html,
                              place: td[2].inner_html)

    # if (Scrape.find_by(code_id: code_id, time: time, status: td[1].inner_html, place: td[2].inner_html) == nil)
    #   Scrape.create(code_id: code_id, time: td[0].inner_html, status: td[1].inner_html, place: td[2].inner_html)
    # end
  end

  def search_html(code)
    nokogiri_html_page(code)
      .css('.events-table')
      .css('tbody')
      .css('tr')
  end


  def nokogiri_html_page(code)
    Nokogiri::HTML(open(
      "https://www.matkahuolto.fi/en/seuranta/tilanne/?package_code=#{code}&token"
    ))
  end

  private

  def user_params
    params.require(:user).permit(:email, :code)
  end
end
