module Youzan
  module APIOperations
    module Customer
      module ClassMethods
        def method_missing(name, *args, &block)
          body = args[0] || {}
          if @customer_avaliable_name.key?(name)
            response = Youzan.send_request(@customer_avaliable_name[name][:method], Youzan.api_host + @customer_avaliable_name[name][:url] + "?access_token=#{Youzan.app_token}", body, true)
          else
            super
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end