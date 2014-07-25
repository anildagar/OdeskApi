OmniAuth.config.logger = Rails.logger



# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :odesk, 'd6d726ea3a48b18d74bf7a177876dab1', 'ed57cce1179fdf61'
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :odesk, '161cf7b042309ee1671b642de55e6cf0', 'bfb90f009c05b99b' # as freelancer
end