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
end