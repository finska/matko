require 'open-uri'
require 'nokogiri'
module ScraperHelper
  def nokogiri_html_page(code)
    Nokogiri::HTML(open("https://www.matkahuolto.fi/en/seuranta/tilanne/?package_code=#{code}"))
  end

  def search_html(code)
    nokogiri_html_page(code)
        .css('.events-table').css('tbody')
        .css('tr')
  end

  def scrape_into_db(code, code_id)
    search_html(code).each do |row|
      td = row.css('td')
      Event.find_or_create_by!(code_id: code_id,
                               time:    td[0].inner_html.to_datetime,
                               status:  td[1].inner_html,
                               place:   clean_string(td[2].inner_html))
    end
    send_email(code_id)
  end

  def clean_string(string)
    string.squish.gsub(/<p>[\s$]*<\/p>/, '')
  end


  def send_email(code_id)
    code = Shipment.find(code_id)
    user = User.find(code.user_id)
    if (email_not_sent(code_id))
      scrape = Event.where(code_id: code_id).order(time: :desc)
      scrape.each do |row|
        row.update(notified: true)
      end
      UserMailer.scrape_info(user, scrape).deliver
    end
  end

  def email_not_sent(code_id)
    if (Event.exists?(code_id: code_id, notified: false))
      return true
    else
      return false
    end
  end

  def check_all_shipments
    if (Shipment.exists?)
      shipment = Shipment.all
      shipment.each do |row|
        scrape_into_db(row.code, row.id)
        user = User.find(row.user_id)
        if (email_not_sent(row.id))
          scrape = Event.where(code_id: row.id).order(time: :desc)
          scrape.each do |row|
            row.update(notified: true)
          end
          UserMailer.scrape_info(user, scrape).deliver
        end
      end
    end
  end
end

class Pusni
  include ScraperHelper

  def ga
    check_all_shipments()
  end
end
