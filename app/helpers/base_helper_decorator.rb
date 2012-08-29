Spree::BaseHelper.class_eval do
  def flash_messages
    flash.each do |msg_type, text|
      unless text.blank?
        message_block = content_tag(:div, :class => "alert alert-#{msg_type}") do
          concat(content_tag(:a, "x", :class => "close", "data-dismiss" => "alert"))
          concat(content_tag(:p, text))
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
    true if params[:action] == "index"
  end

  def body_class
    "auction-bg" if params[:controller] == 'spree/auctions'
  end

  def populate_notifications
    if current_user and current_user.has_role?("auction_user") || current_user.has_role?("admin")
      if current_user.beginner?
        @auction_notifications <<  "Welcome #{current_user.first_name.capitalize}! New to Sold.sg? #{link_to("Click here ", "/faq")} for our FAQs!"

        @auction_notifications <<  "#{link_to("Click here ", "/tips")} for Bidding Tips & Strategies! "
      end

      @auction_notifications <<  "#{link_to("Click here ", completed_auctions_url(subdomain: 'auctions'))} to see what  you have missed!"


      @auction_notifications <<  "Hi #{current_user.first_name.capitalize}! Did you know we are certified by <a target='_blank' href='http://www.cnsg.com.sg/accreditation/Soldgers.pdf'>TrustSg</a> and <a href='javascript:vrsn_splash()' tabindex='-1'>Verisign</a>"

      auctions = Spree::Auction.by_state('live').where(["remaining_time < ?", 10.minutes.from_now.utc.to_i]).order('remaining_time')
      if !auctions.blank? and auctions.count > 0
        auction = auctions.first
        @auction_notifications <<  "Don't miss out #{current_user.first_name.capitalize}! The #{auction.name} is about to close!"
        @auction_notifications << " Currently selling at #{auction.saving_rate_for_winner}% off! #{link_to("Bid now!",show_auction_url(auction.permalink,auction.id,:subdomain => "auctions"))} to take it home!"
      end

      if current_user.eligible_auctions == 0
        @auction_notifications << "Hi #{current_user.first_name.capitalize} - you are currently participating in 4 Auctions!"
        @auction_notifications << " 4 Auctions is the limit so kick back and enjoy!"
        @auction_notifications << " You can start bidding when one of these Auctions ends!"
      end

      if current_user.coin < 20
        @auction_notifications << "Hi #{current_user.first_name.capitalize}! You are almost out of Tokens "
        @auction_notifications <<  " #{link_to("Click here ", purchase_tokens_url(subdomain:false))} to purchase more!"
      end

      @auction_notifications << "Hi #{current_user.first_name.capitalize}! Did you know you can earn Bonus Tokens by Referring a Friend?"
      @auction_notifications << "#{link_to("Click here ", invitations_url(subdomain:false))} for more information!"
    else
      if current_user
      @auction_notifications <<  "Welcome #{current_user.first_name.capitalize}! See something you like?"
      else
        @auction_notifications <<  "Welcome! See something you like?"
      end

      @auction_notifications << "<a href='#myRegistration' data-toggle='modal'>Activate</a> your Account to start bidding!"
    end
    ntfs=""
    @auction_notifications.each do |notification|
      ntfs += content_tag(:li, notification.html_safe, class: 'news-item').html_safe
    end if @auction_notifications
    ntfs.html_safe
  end
end