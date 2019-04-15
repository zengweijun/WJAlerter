

Pod::Spec.new do |s|

  s.name         = "WJAlerter" 
  s.version      = "0.0.1"
  s.license      = "MIT"          
  s.summary      = "WJAlerter是对UIAlertController和UIAlertAction的封装，为了方便使用和优雅美观，全部封装为链式语法" 

  s.homepage     = "https://github.com/ZengWeiJun/WJAlerter"
  s.source       = { :git => "https://github.com/ZengWeiJun/WJAlerter.git", :tag => s.version }
  s.source_files = "WJAlerter/Classes/**/*" 
  s.requires_arc = true 
  s.platform     = :ios, "8.0" 

  # s.frameworks   = "UIKit", "Foundation"
  
  # User
  s.author           = { '曾维俊' => 'niuszeng@163.com' }
  s.social_media_url   = "https://github.com/ZengWeiJun"

end
