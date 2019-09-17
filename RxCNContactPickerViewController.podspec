Pod::Spec.new do |s|
    s.name             = 'RxCNContactPickerViewController'
    s.version          = '0.1.1'
    s.summary          = 'Reactive CNContactPickerViewController in iOS.'
    s.description      = <<-DESC
    This is an Rx extension to use CNContactPickerViewController.
    DESC
    s.homepage         = 'https://github.com/87kangsw/RxCNContactPickerViewController'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Kanz' => 'kanz.developer@gmail.com' }
    s.source           = { :git => 'https://github.com/87kangsw/RxCNContactPickerViewController.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '10.0'
    s.swift_version = '5.0'
    s.default_subspec = 'Core'
    
    s.subspec 'Core' do |ss|
        ss.frameworks = 'ContactsUI'
        ss.source_files = 'Sources/*.swift'
        ss.dependency 'RxSwift', '>= 5.0.0'
        ss.dependency 'RxCocoa', '>= 5.0.0'
    end
    
end
