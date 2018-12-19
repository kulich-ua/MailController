Pod::Spec.new do |s|
  s.name             = 'MailController'
  s.version          = '1.0.1'
  s.summary          = 'Lightweight Swift wrapper around MFMailComposeViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.homepage         = 'https://github.com/Kulich-ua/MailController'
  s.author           = { 'Volodymyr Kolibaba' => 'kulich.ua@gmail.com' }
  
  s.source           = { :git => 'https://github.com/Kulich-ua/MailController.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = "4.2"
  
  s.requires_arc = true

  s.source_files = "Source/**/*.{swift}"

end
