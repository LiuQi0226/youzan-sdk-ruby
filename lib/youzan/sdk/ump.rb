module Youzan
  class Ump < Base
    @customer_avaliable_name = {
      :coupon_take => {
        :method => :post,
        :url => '/youzan.ump.coupon.take/3.0.0'
      }
    }

  end
  #code
end