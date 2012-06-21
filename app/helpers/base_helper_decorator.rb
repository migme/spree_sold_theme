Spree::BaseHelper.class_eval do
  def flash_messages
    [:notice, :error].map do |msg_type|
      cls  = msg_type=="notice" ? "alert-info" : "alert-block alert-error"
      if flash[msg_type]
        content_tag :div , :class => "alert #{cls}" do
          content_tag(:a, "x", :class => "close", "data-dismiss" => "alert") +
          content_tag(:p, flash[msg_type])
        end
      else
        ''
      end
    end.join("\n").html_safe
  end

  def is_active?(controller)
    "active" if params[:controller] == controller
  end

end