# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
workspace 'EmpowermentsLabsChallenge.xcworkspace'

target 'EmpowermentsLabsChallenge' do
  use_frameworks!

  # Pods for EmpowermentsLabsChallenge
  # Pods for 
  pod 'Kingfisher', '~> 6.0'
  pod 'SVProgressHUD'

  target 'EmpowermentsLabsChallengeTests' do
    inherit! :none
    # Pods for testing
  end

  target 'NetworkModule' do
    project 'NetworkModule/NetworkModule'
  
    target 'NetworkModuleTests' do
      inherit! :none
      # Pods for testing
    end
  end

  target 'CoreModule' do
    project 'CoreModule/CoreModule'
  
    target 'CoreModuleTests' do
      inherit! :none
      # Pods for testing
    end
  end
end
