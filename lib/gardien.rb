module Gardien
  class Base < ActiveResource::Base
    self.site = "https://gardien.herokuapp.com/api"
    self.timeout = 15
    self.user = 'refuge'
    self.password = 'dsj8938hfiuehjf9sdu0f9jk3jnqro'
    
    self.format = :json
  end
  
  class Location < Base
    class Member < Base
    end
  end
  
  class Member < Base
  end
end