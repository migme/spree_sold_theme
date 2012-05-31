Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
    :mini => '80x60>', # thumbs under image
    :small => '180x135>', # images on category view
    :product => '380x285>', # full product image
    :large => '440x330>'  # light box image
  }
end