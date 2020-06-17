Pod::Spec.new do |spec|
    spec.name                 = 'MobilePay-AppSwitch-SDK'
    spec.version              = '2.2.0'
    spec.license              = { :type => 'MobilePay License Terms', :file => 'LICENSE' }
    spec.homepage             = 'http://www.mobilepay.dk/da-dk/erhverv/Pages/mobilepay-appswitch.aspx'
    spec.authors              = { 'MobilePay' => 'support@mobilepay.dk' }
    spec.summary              = 'MobilePay-AppSwitch-SDK'
    spec.description          = 'The MobilePay SDK enables your app to receive payments through the MobilePay app.'
    spec.source               = { :git => 'https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK.git', :tag => '2.2.0' }
    spec.source_files         = 'sdk/iOS/2.2.0/MobilePayManager/*.{h}'
    spec.public_header_files  = 'sdk/iOS/2.2.0/MobilePayManager/*.{h}'
    spec.vendored_libraries   = 'sdk/iOS/2.2.0/MobilePayManager/*.{a}'
    spec.documentation_url    = 'https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki'
    spec.platform             = :ios
    spec.requires_arc         = true
  end
  