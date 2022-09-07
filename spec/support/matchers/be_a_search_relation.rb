RSpec::Matchers.define :be_a_search_relation do |data|
  match do |result|
    expect(result.all).to eq(data[:results])
    expect(result.total_pages).to eq(data[:total_pages])
    expect(result.current_page).to eq(data[:page])
  rescue RSpec::Expectations::ExpectationNotMetError => e
    @error = e
    raise
  end

  failure_message do
    <<~MESSAGE
      Expected object to be_an_app_release_response but failed with error:
      #{@error}
    MESSAGE
  end
end
