Pod::Spec.new do |s|
  s.name          = "FMLinkLabel"
  s.version       = “1.0.0”
  s.summary       = "Provide Many Effect-types!(Swift Type >= 3.0)"
  s.description   =  "Written in pure objective-c!”
  s.homepage      = "https://github.com/BruceFight/JHB_HUDView"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.platform      = :ios, “7.0”
  s.author        = { “Coder_FM” => ‘847881570@qq.com' }
  s.source        = { :git => 'https://github.com/CoderFM/FMLinkLabel.git', :tag =>  s.version }
  s.source_files  = "FMLabel/*"
  s.requires_arc  = true
end

