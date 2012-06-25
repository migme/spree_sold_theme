module Spree
  HomeController.class_eval do
    def index
      @flash_sales = Spree::FlashSale.includes([:variant]).by_state(['reserved','live','pending','empty']).order('end_date desc').limit(4)
      if current_user
        if current_user.beginner?
        @beginner_auctions = Spree::Auction.includes([:variant]).beginner.pending_and_live_auction.all(:limit => 2)
        end
        @auctions = Spree::Auction.includes([:variant]).general.pending_and_live_auction.page(1).per(6).order("remaining_time asc")
      else
        @auctions = Spree::Auction.includes([:variant]).pending_and_live_auction.page(1).per(6).order("remaining_time asc")
      end
    end
  end
end