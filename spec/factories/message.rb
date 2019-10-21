FactoryBot.define do
  factory :message do
    message {"hello!"}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png'))}
    user
    group
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end