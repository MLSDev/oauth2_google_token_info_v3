module Oauth2GoogleTokenInfoV3
  class HttpsRequest
    attr_reader :jwt_id_token

    GOOGLE_APIS_DOMAIN = "www.googleapis.com"

    def initialize jwt_id_token
      @jwt_id_token = jwt_id_token
    end

    # {
    #   "iss": "accounts.google.com",
    #   "azp": "XXX-XXX.apps.googleusercontent.com",
    #   "aud": "XXX-XXX.apps.googleusercontent.com",
    #   "sub": "XXX",
    #   "hd": "example.com",
    #   "email": "xxx@example.com",
    #   "email_verified": "true",
    #   "at_hash": "XXX",
    #   "name": "XXX XXX",
    #   "picture": "https://xxx.googleusercontent.com/a-/XXX",
    #   "given_name": "XXX",
    #   "family_name": "XXX",
    #   "locale": "uk",
    #   "iat": "123",
    #   "exp": "123",
    #   "jti": "123XXX",
    #   "alg": "RS256",
    #   "kid": "123XXX",
    #   "typ": "JWT"
    # }
    def response
      return @response if @response

      Net::HTTP.start(request_uri.host, request_uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new request_uri

        @response = http.request(request).body
      end

      @response = JSON.parse(@response, symbolize_names: true)
    rescue ::Net::OpenTimeout
      retry
    end

    def valid?
      !response.key?(:error_description)
    end
    
    def error_description
      response[:error_description]
    end

    def subject
      response.fetch(:sub)
    end
    alias_method :google_id, :subject

    def email
      response.fetch(:email)
    end

    def hosted_domain
      response.fetch(:hd)
    end

    def given_name
      response.fetch(:given_name)
    end
    alias_method :first_name, :given_name

    def family_name
      response.fetch(:family_name)
    end
    alias_method :last_name, :family_name

    def email_verified?
      response.fetch(:email_verified) == 'true'
    end

    def locale
      response.fetch(:locale)
    end

    def expire_at
      @expire_at ||= Time.at(response.fetch(:exp).to_i).to_time
    end

    def not_expired?
      expire_at > Time.now
    end

    #
    # https://developers.google.com/identity/sign-in/web/backend-auth#calling-the-tokeninfo-endpoint
    #
    def request_uri
      @request_uri ||= URI("https://#{ GOOGLE_APIS_DOMAIN }/oauth2/v3/tokeninfo?id_token=#{ jwt_id_token }")
    end
  end
end
