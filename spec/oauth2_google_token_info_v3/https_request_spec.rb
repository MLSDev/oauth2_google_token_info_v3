RSpec.describe Oauth2GoogleTokenInfoV3::HttpsRequest do
  let(:id_token) { (0...256).map { (65 + rand(26)).chr }.join }

  let(:response) do
    {
      "iss": "accounts.google.com",
      "azp": "XXX-XXX.apps.googleusercontent.com",
      "aud": "XXX-XXX.apps.googleusercontent.com",
      "sub": "XXX",
      "hd": "example.com",
      "email": "xxx@example.com",
      "email_verified": "true",
      "at_hash": "XXX",
      "name": "XXX XXX",
      "picture": "https://xxx.googleusercontent.com/a-/XXX",
      "given_name": "XXX",
      "family_name": "XXX",
      "locale": "uk",
      "iat": "123",
      "exp": (Time.now + 30*60).to_i,
      "jti": "123XXX",
      "alg": "RS256",
      "kid": "123XXX",
      "typ": "JWT"
    }
  end

  subject { described_class.new(id_token) }

  it { expect(subject.request_uri.to_s =~ ::URI::regexp).to be_truthy }

  before { stub_request(:get, subject.request_uri.to_s).to_return(body: response.to_json) }

  its(:response) { is_expected.to be_a_kind_of(Hash) }

  its(:not_expired?) { is_expected.to be_truthy }

  its(:family_name) { is_expected.to_not be_empty }
  its(:last_name) { is_expected.to_not be_empty }

  its(:given_name) { is_expected.to_not be_empty }
  its(:first_name) { is_expected.to_not be_empty }

  its(:subject) { is_expected.to_not be_empty }
  its(:google_id) { is_expected.to_not be_empty }

  its(:hosted_domain) { is_expected.to_not be_empty }
end
