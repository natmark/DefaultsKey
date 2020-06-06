Pod::Spec.new do |spec|
  spec.name         = "DefaultsKey"
  spec.version      = "0.0.1"
  spec.summary      = "Thin UserDefaults exteions"
  spec.description  = <<-DESC
DefaultsKey allows you to specify the type and defaultValue for UserDefaults.
                    DESC
  spec.homepage     = "https://github.com/natmark/DefaultsKey"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "natmark" => "natmark0918@gmail.com" }
  spec.source       = { :git => "https://github.com/natmark/DefaultsKey.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/DefaultsKey/*.swift"
  spec.ios.deployment_target = "10.0"
end
