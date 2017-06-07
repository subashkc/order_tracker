require 'csv'

class OrderProcessor

  def self.process_orders path
    orders = []
    dealer_id = ''
    delivery_date = ''

    CSV.foreach("public/#{path}", skip_blanks: true, headers: true, header_converters: -> (h) {h.strip.delete(' ').downcase}) do |row|
      row_hash = row.to_hash
      dealer_id,  delivery_date = row_hash['dealerid'], row_hash['deliverydate'] if $. == 2 # $. gives the current line number
      orders << row.to_hash
    end
    dealer = Dealer.where(:id => dealer_id).first_or_create
    account = Account.create!({business_name: "#{dealer.id}_account", dealer: dealer})
    puts Order.add_orders(orders, dealer, delivery_date)
  end

  def self.d
    Dealer.delete_all
    Order.delete_all
    OrderItem.delete_all
  end

end
