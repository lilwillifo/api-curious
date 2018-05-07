Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "fcfc384163716901370f", "4a030588a0800fe6369f4372343386d05dc36aa5"
end
