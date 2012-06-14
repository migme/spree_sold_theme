module Spree
  HomeController.class_eval do
    def index
      @flash_sales = Spree::FlashSale.includes([:variant]).by_state(['reserved','live','pending','empty']).order('end_date desc').limit(4)
      @auctions = Spree::Auction.includes([:variant]).general.pending_and_live_auction
      if current_user and current_user.beginner?
        @beginner_auctions = Spree::Auction.includes([:variant]).beginner.pending_and_live_auction.all(:limit => 2)
      end
    end
  end
end