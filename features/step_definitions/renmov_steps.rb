Given /^a blank slate$/ do
  # do nothing
end

Then /^the output should contain the right version$/ do
  assert_partial_output(Renmov::VERSION, all_output)
end
