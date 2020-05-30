# https://open.youzanyun.com/api/youzan.item.detail.api.Item.alias/1.0.0
# youzan.users.weixin.follower.get.3.0.0
module Youzan
  class Users < Base
    @customer_avaliable_name = {
      :weixin_follower_get => {
        :method => :post,
        :url => '/youzan.users.weixin.follower.get/3.0.0'
      }
    }

  end
  #code
end