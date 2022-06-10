# react-native-screen-recorder-detect.podspec

require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-screen-recorder-detect"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-screen-recorder-detect
                   DESC
  s.homepage     = "https://github.com/soumyadeephalder/react-native-screen-recorder-detectNew"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "deepsoumya" => "soumyadeephalder1@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/soumyadeephalder/react-native-screen-recorder-detectNew.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end

