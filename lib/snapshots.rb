class Snapshots
  include HTTParty
  
  def initialize
  end
  
  def picture
    response = HTTParty.get("http://api.snapito.com/web/516e011353b62078731712566b01e143f56adf0b/mc?type=jpeg&url=http://diditmatter.herokuapp.com/lists")
    
    if response.success?
      response
    end
  end
end