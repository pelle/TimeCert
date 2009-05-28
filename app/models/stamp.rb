class Stamp < ActiveRecord::Base
  validates_format_of :digest,:with=>/[0123456789abcdef]{40}/,:on=>:create
  
  def timestamp
    self.created_at
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
    {:timestamp=>timestamp,:digest=>digest}
  end
  
end
