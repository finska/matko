require 'open-uri'
require 'nokogiri'
class ScraperController < ApplicationController
  def show_form

  end

  def db
    user = User.first_or_create(email: user_params['email'])
    code = Code.first_or_create(user_id: user.id, code: user_params['code'])
    scrape_into_db(user_params['code'], code.id)
  end

  def scrape_into_db(code, code_id)
    search_html(code).each do |row|
      td = row.css('td')
      insert_record_if_not_exists(td, code_id)
    end
    send_email(code_id)
  end

  def insert_record_if_not_exists(td, code_id)
    Scrape.find_or_create_by!(code_id: code_id,
                              time:    td[0].inner_html.to_datetime,
                              status:  td[1].inner_html,
                              place:   td[2].inner_html)
  end

  def send_email(code_id)
    scrape = Scrape.where(code_id: code_id)
    code   = Code.find(code_id)
    user   = User.find(code.user_id)
    UserMailer.scrape_info(user, scrape).deliver
  end

  def search_html(code)
    nokogiri_html_page(code)
        .css('.events-table').css('tbody')
        .css('tr')
  end


  def nokogiri_html_page(code)
    Nokogiri::HTML(open('https://www.matkahuolto.fi/en/seuranta/tilanne/?package_code=' + code))
  end

  private
  def user_params
    params.require(:user).permit(:email, :code)
  end
end
