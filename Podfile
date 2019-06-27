# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def frameworks_pods
    pod 'Alamofire'
    pod 'ObjectMapper'
    pod 'AlamofireObjectMapper' 
end

target 'KavakChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KavakChallenge
  frameworks_pods

  target 'KavakChallengeTests' do
    inherit! :search_paths
    # Pods for testing
    frameworks_pods
  end

  target 'KavakChallengeUITests' do
    inherit! :search_paths
    # Pods for testing
    frameworks_pods
  end

end
