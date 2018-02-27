Pod::Spec.new do |s|
  s.name             = "DovMess"
  s.version          = "0.1.1"
  s.summary          = "DovMess is a framework that can pass message from top level UIResponder to the UIResponder where you observe the message."

  s.description      = <<-DESC
                        DovMess is a framework that can pass message from top level UIResponder to the UIResponder where you observe the message.
                        Easy to use. Please review README for details
                       DESC

  s.license          = 'MIT'
  s.homepage         = "https://www.cainwang.com"
  s.author           = { "cendywang" => "cendymails@gmail.com" }
  s.source           = { :git => "https://github.com/cendywang/DovMess", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/*'
  s.public_header_files = 'Pod/Classes/*.h'
  s.frameworks = 'UIKit'
end
