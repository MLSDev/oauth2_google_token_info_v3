module Oauth2GoogleTokenInfoV3
  class HttpsRequest
    attr_reader :jwt_id_token

    def initialize jwt_id_token
      @jwt_id_token = jwt_id_token.presence
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
      @response ||= ::JSON.parse(::Net::HTTP.get(request_uri), symbolize_names: true)
    rescue ::Net::OpenTimeout
      retry
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
      @expire_at ||= ::Time.at(response.fetch(:exp).to_i).to_datetime
    end

    def not_expired?
      expire_at.future?
    end

    private

    #
    # https://developers.google.com/identity/sign-in/web/backend-auth#calling-the-tokeninfo-endpoint
    #
    def request_uri
      @request_uri ||= URI("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{ jwt_id_token }")
    end
  end
end
