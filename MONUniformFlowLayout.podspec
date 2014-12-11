Pod::Spec.new do |s|
    s.name = 'MONUniformFlowLayout'
    s.version = '0.0.1'
    s.summary = ''
    s.platform = :ios, '7.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.homepage = 'https://github.com/mownier/MONUniformFlowLayout'
    s.author = { 'Mounir Ybanez' => 'rinuom91@gmail.com' }
    s.source = { :git = >'https://github.com/mownier/MONUniformFlowLayout.git', :tag => s.version.to_s }
    s.source_files = 'MONUniformFlowLayout/*.{h,m}'
    s.requires_arc = true
end
