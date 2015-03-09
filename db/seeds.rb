

5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.save!
end

# users for testing purposes
tester = User.new(
  name: 'Tester',
  email: 'tester@example.com',
  password: 'pewfortest'
)
tester.save!

participant = User.new(
  name: 'Participant',
  email: 'participant@example.com',
  password: 'pewfortest'
)
participant.save!

users = User.all

15.times do
  correspondence = Correspondence.create!(
    creator: users.sample,
    participant: users.sample,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    private: false
  )
  # make sure participant and creator are unique
  while correspondence.creator == correspondence.participant do
    correspondence.update_attributes!(participant: users.sample)
  end
end

#Private correspondences
5.times do
  correspondence = Correspondence.create!(
    creator: tester,
    participant: participant,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    private: true
  )
end

correspondences = Correspondence.all

100.times do
  # post user can only be the creator or participant
  correspondence = correspondences.sample
  correspondence_users = []
  correspondence_users << correspondence.creator
  correspondence_users << correspondence.participant

  post = Post.create!(
    correspondence: correspondence,
    user: correspondence_users.sample,
    body: Faker::Lorem.paragraphs(10).join("\n")
  )

  post.update_attributes!(created_at: rand(10.minutes .. 6.months).ago)

end



puts "Seed Finished"
puts "#{User.count} users created."
puts "#{Correspondence.count} correspondences created."
puts "#{Post.count} posts created."
