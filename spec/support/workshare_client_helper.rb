module WorkshareClientHelper
  def stub_workshare_client_request(method, url, options = {})
    ret_value = block_given? ? yield : :response
    allow(Workshare::Client).to receive(method).with(url, options).and_return(ret_value)
  end
end