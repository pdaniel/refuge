module Gardien
  class Base < ActiveResource::Base
    self.site = "https://gardien.herokuapp.com/api"
    self.timeout = 15
    self.user = $conf.gardien_login
    self.password = $conf.gardien_password
    
    self.format = :json
  end
  
  class Location < Base
    class Member < Base
    end
  end
  
  class Member < Base
  end
end