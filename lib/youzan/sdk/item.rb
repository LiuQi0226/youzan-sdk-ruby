# https://open.youzanyun.com/api/youzan.item.detail.api.Item.alias/1.0.0

module Youzan
  class Item < Base
    @customer_avaliable_name = {
      :detail => {
        :method => :post,
        :url => '/youzan.item.detail.api.Item.alias/1.0.0'
      },
      :get => {
        :method => :post,
        :url => '/youzan.item.get/3.0.0'
      },
    }

  end
  #code
end