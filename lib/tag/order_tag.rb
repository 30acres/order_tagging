class OrderTag
  def initialize(order)
    
    @order = ShopifyAPI::Order.find(order)

    # @customer = @order.customer
    @initial_order_tags = @order.tags
  end

  def add_order_tags
    puts @order.inspect
    if !@order.tags.include?('International') && @order.line_items.select { |li| li.requires_shipping }.any? && @order.shipping_address && @order.shipping_address.country != 'Australia'
      @order.tags = @order.tags + ', International'
      sleep(1)
      puts 'SLEEP 1'
      @order.save!
    end

    if !@order.tags.include?('Wholesale') && @order.customer && @order.customer.tags.include?('holesale')
      @order.tags = @order.tags + ', Wholesale'
      puts 'SLEEP 2'
      sleep(1)
      @order.save!
    end
  end

  # def cleaned_tags
  #   @order.tags.split(',').reject{ |c| c.empty? or c == "  " }.uniq.join(',')
  # end
  #
  # def initial_tags
  #   @initial_order_tags
  # end
  #
  # def tags_changed?
  #   clean_tags(initial_tags) != clean_tags(cleaned_tags)
  # end
  #
  # def clean_tags(tags)
  #   tags.split(',').map{ |t| t.strip }.uniq.sort
  # end


end
