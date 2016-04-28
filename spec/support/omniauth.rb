OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: "facebook",
  uid: "123545",
  info: {
    email: "foo@bar.com",
    name: "foo bar",
  },
})

OmniAuth.config.mock_auth[:facebook_without_email] = OmniAuth::AuthHash.new({
  provider: "facebook",
  uid: "223545",
  info: {
    email: "",
    name: "foo bar",
  },
})


