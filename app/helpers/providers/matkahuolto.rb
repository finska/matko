require 'open-uri'
require 'nokogiri'

class Matkahuolto


  def nokogiri_html_page(provider_address, code)
    Nokogiri::HTML(open("#{provider_address}#{code}"))
  end

  def events_table_tbody_info(provider_address, code)
    nokogiri_html_page(provider_address, code)
      .css('.events-table')
      .css('tbody')
      .css('tr')
  end

  def scrape_into_db(provider_address, code, shipment_code_id)
    events_table_tbody_info(provider_address, code).each do |row|
      td = row.css('td')
      ShipmentEvent.find_or_create_by!(shipment_code_id: shipment_code_id,
                                       time: td[0].inner_html.to_datetime,
                                       status: td[1].inner_html,
                                       place: clean_string(td[2].inner_html))
    end
    send_email(shipment_code_id)
  end

  def clean_string(string)
    string.squish.gsub(/<p>[\s$]*<\/p>/, '')
  end


  def send_email(shipment_code_id)
    code = ShipmentCode.find(shipment_code_id)
    user = User.find(code.user_id)
    if (email_not_sent(shipment_code_id))
      scrape = ShipmentEvent.where(shipment_code_id: shipment_code_id).order(time: :desc)
      scrape.each do |row|
        row.update(user_notified: true)
      end
      UserMailer.scrape_info(user, scrape).deliver
    end
  end

  def email_not_sent(shipment_code_id)
    if (ShipmentEvent.exists?(shipment_code_id: shipment_code_id, user_notified: false))
      return true
    else
      return false
    end
  end
end