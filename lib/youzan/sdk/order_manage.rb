module Youzan
  class OrderManage < Base
    @customer_avaliable_name = {
      # 订单搜索接口
      :sold_get => {
        :method => :post,
        :url => '/youzan.trades.sold.get/4.0.1'
      },
      # 订单确认发货
      :confirm_send => {
        :method => :post,
        :url => '/youzan.logistics.online.confirm/3.0.0'
      }
    }
  end
end

=begin
Youzan::OrderManage.sold_get({a: 1, c: 2})
Youzan::OrderManage.confirm_send({tid: 有赞订单号})
=end