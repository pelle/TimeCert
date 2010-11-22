class Stamp 
  attr_reader :seconds, :digest
  
  def initialize(digest)
    @digest = digest.strip
    @seconds = get
    unless @seconds
      @seconds = Time.now.to_i
      $redis.set(redis_key,@seconds)
    end
    
  end
  
  def self.find_by_digest(digest)
    Stamp.new(digest) if $redis.get("sha1:#{digest.strip}")      
  end
  
  def self.by_digest(digest)
    Stamp.new digest
  end
  
  def redis_key
    "sha1:#{@digest}"
  end
  
  def timestamp
    @timestamp ||= Time.at(seconds.to_i)
  end
  
  def ==(stamp)
    stamp.is_a?(Stamp) && digest == stamp.digest
  end
  
  def get
    $redis.get(redis_key)
  end
    
  def utc
    self.timestamp.utc
  end
  
  def to_time
    utc.to_s
  end
  
  def to_text
    utc.to_s
  end
  
  def to_yaml
    to_hash.to_yaml
  end
  
  def to_csv
    "#{digest},#{timestamp}"
  end
  
  def to_json
    to_hash.to_json
  end
  
  def to_ini
    "# Go to http://timecert.org for more info\ndigest=#{self.digest}\ntimestamp=#{self.utc}"
  end
  
  def to_hash
    {:timestamp=>utc.to_s,:digest=>digest}
  end
  
  private
  # override this so we can set digest which is the primary key using hash assignment
  def attributes_protected_by_default
    []
  end
end
