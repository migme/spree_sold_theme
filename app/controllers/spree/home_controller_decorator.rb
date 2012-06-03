module Spree
  HomeController.class_eval do
    def index
      @flash_sales = Spree::FlashSale.includes([:variant]).by_state(['reserved','live','pending','empty']).order('end_date desc').limit(4)
      @auctions = Spree::Auction.includes([:variant]).pending_and_live_auction
    end
  end
end