Spree::BaseHelper.class_eval do
  def flash_messages
    flash.each do |msg_type, text|
      unless text.blank? || (text == true)
        type =  msg_type == :error ? "error" : "success"
        message_block = content_tag(:div, :class => "alert alert-#{type}") do
          concat(content_tag(:a, "x", :class => "close", "data-dismiss" => "alert"))
          if msg_type == :error
          concat(content_tag(:span, text,:class => "txt-18 txt-red"))
          else
            concat(content_tag(:span, text,:class => "txt-18"))
          end

        end
        concat(message_block)
      end
    end
    nil
  end

  def is_active?(controller)
    "active" if params[:controller] == controller
  end

  def show_banner?
    true if (params[:action] == "index" and ["spree/home","spree/auctions","spree/products","spree/flash_sales"].include?(params[:controller])) or (params[:action] == "show" and params[:controller]=="spree/taxons") or (params[:action] == "list_sold_like" and params[:controller]=="spree/products")
  end

  def body_class
    case request.subdomain
      when "auctions"
        "auction-bg"
      when "sales"
        "sale-bg"
      else
        ""
    end
  end

  def fav_icon_for
     @fav_tag || 'favicon_home.ico'
  end

  def full_name(user)
    if user.first_name && user.last_name
      return  "#{user.first_name.capitalize}   #{user.last_name.capitalize}"
    else
       return user.email
    end
  end

  def populate_notifications
    @auction_notifications ||= []
    @auction_notifications << "Merry Christmas! Need gift ideas? Check out our <a href='shop.sold.sg'>Shop</a> and <a href='sales.sold.sg'>Sales</a>!"
    if current_user and current_user.has_role?("auction_user") || current_user.has_role?("admin")

      if current_user.beginner?
        @auction_notifications <<  "Welcome #{current_user.first_name.capitalize}! New to Sold.sg? #{link_to("Click here", "http://feedback.sold.sg/knowledgebase/topics/3851-auction")} for our FAQs!"

        @auction_notifications <<  "#{link_to("Click here", "http://feedback.sold.sg/knowledgebase/articles/112887-tips-and-strategies-basic-bidding-strategies")} for Bidding Tips & Strategies! "
      end


      @auction_notifications <<  "#{link_to("Click here", completed_auctions_url(subdomain: 'auctions'))} to see what  you have missed!"


      @auction_notifications <<  "Hi #{current_user.first_name.capitalize}! Did you know we are certified by <a target='_blank' href='http://www.cnsg.com.sg/accreditation/Soldgers.pdf'>TrustSg</a>" # and <a href='javascript:vrsn_splash()' tabindex='-1'>Verisign</a>"

      @auction_notifications << "Free Shipping applies to purchases of $150 or more (excl.Token Packs)."


      auctions = Spree::Auction.by_state('live').where(["remaining_time < ?", 10.minutes.from_now.utc.to_i]).order('remaining_time')
      if !auctions.blank? and auctions.count > 0
        auction = auctions.first
        @auction_notifications <<  "Don't miss out #{current_user.first_name.capitalize}! The #{link_to(auction.name,show_auction_url(auction.permalink,auction.id,:subdomain => "auctions"))} is about to close!"
        @auction_notifications << " Currently selling at #{auction.saving_rate_for_winner}% off! #{link_to("Bid now!",show_auction_url(auction.permalink,auction.id,:subdomain => "auctions"))} to take it home!"
      end

      won_count = current_user.won_auctions.joins(:variant).joins("INNER JOIN spree_products on spree_variants.product_id= spree_products.id").where("spree_products.token_pack = false and spree_auctions.free=false").joins("INNER JOIN spree_auction_limits on spree_auction_limits.auction_id = spree_auctions.id").count
      if won_count >= 4
        al = current_user.auction_limits.where("status=2").first       # status = WON_AUCTION
        unless al.nil?
          @auction_notifications << "Hi #{current_user.first_name.capitalize} - you are currently participating in 4 Auctions!"
          @auction_notifications << " 4 Auctions is the limit so kick back and enjoy!"
          @auction_notifications << " You can start bidding on #{(al.created_at + 14.days).strftime("%d %B")}"
        end
      end

      if current_user.coin < 20
        @auction_notifications << "Hi #{current_user.first_name.capitalize}! You are almost out of Tokens "
        @auction_notifications <<  " #{link_to("Click here", purchase_tokens_url(subdomain:false))} to purchase more!"
      end

      @auction_notifications << "Hi #{current_user.first_name.capitalize}! Did you know you can earn Credits by Referring Friends?"
      @auction_notifications << "#{link_to("Click here", invite_friends_url(subdomain:false))} for more information!"
    else
      @auction_notifications <<  "Welcome! See something you like?"
      @auction_notifications << "<a href='#myRegistration' data-toggle='modal'>Activate</a> your Account to start bidding!"
    end

    #adding new sales
    new_sale = Spree::FlashSale.recent
    if new_sale.size > 0
      random_new_sale = new_sale[rand(new_sale.size)]
      @auction_notifications << "New Sale: #{link_to(random_new_sale.name, show_flash_sale_url(random_new_sale.permalink,random_new_sale.id,:subdomain => "sales") )} for #{random_new_sale.discount}% off!"
    end

    #adding last day sales
    last_sale = Spree::FlashSale.last_day
    if last_sale.size > 0
      random_last_sale = last_sale[rand(last_sale.size)]
      @auction_notifications << "Sale ending soon: #{link_to(random_last_sale.name,show_flash_sale_url(random_last_sale.permalink,random_last_sale.id,:subdomain => "sales") )} for #{random_last_sale.discount}% off!"
    end

    ntfs=""
    @auction_notifications.each do |notification|
      ntfs += content_tag(:li, notification.html_safe, class: 'news-item').html_safe
    end if @auction_notifications
    ntfs.html_safe
  rescue
    ""
    end


  def meta_fb_data_tags
    object = instance_variable_get('@'+controller_name.singularize)
    fb_meta = { }

    if object.kind_of?(ActiveRecord::Base)
      fb_meta[:title] = object.name if object[:name].present?
      fb_meta[:description] = strip_tags(object.description) if object[:description].present?
      fb_meta[:url] = url_for(:only_path => false)
      begin
        if object.respond_to?(:image_url)
          fb_meta[:image] = object.image_url
        else

          fb_meta[:image] = object.images.first.attachment.url unless object.images.empty?
        end
      rescue => e
      end
    end

    fb_meta.map do |name, content|
      tag('meta', :property => "og:#{name}", :content => content)
    end.join("\n")
  end
end