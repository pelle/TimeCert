require 'base64'
SMALL_LOGO = "data:image/png;base64,"+Base64::encode64( File.read(File.join(Rails.root, "public","images","logo25.png")))