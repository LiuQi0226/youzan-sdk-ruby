# youzan-sdk-ruby
本项目fork自[hging/youzan-sdk-ruby](https://github.com/hging/youzan-sdk-ruby)，并作出适当修改。
## 描述
调用有赞API接口

## 使用方法

Gemfile添加：
```ruby
gem 'youzan-sdk-ruby', git: 'https://github.com/LiuQi0226/youzan-sdk-ruby.git'
```

然后执行:

    $ bundle
配置：
```ruby
Youzan.configure do |config|
  config.app_id = '' # 云有赞已创建的应用id
  config.app_secret = '' # 云有赞已创建的应用secret
  config.grant_id = '' # 云有赞店铺id
end
```

## Usage

eg：获取订单
```ruby
Youzan::OrderManage.sold_get(Hash)
```

## 反馈
邮箱：522979872@qq.com
