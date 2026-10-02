require 'webmock/cucumber'

Before do
  stub_request(:post, "https://esaas-randomword-27a759b6224d.herokuapp.com/RandomWord").to_return(status: 200, headers: {},
                                                                              body: "testword")
end
