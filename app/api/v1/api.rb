class Api < Grape::API
  format :json
  prefix 'api'

  # before do
  #   header['Access-Control-Allow-Origin'] = '*'
  #   header['Access-Control-Request-Method'] = '*'
  # end

  mount Articles

  #   add_swagger_documentation mount_path: '/api_docs',
  #                             api_version: 'v1'
end
