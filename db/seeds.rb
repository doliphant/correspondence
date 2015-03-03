

5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.save!
end

users = User.all

10.times do
  discussion = Discussion.create!(
    creator: users.sample,
    participant: users.sample,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
  # make sure participant and creator are unique
  while discussion.creator == discussion.participant do
    discussion.update_attributes!(participant: users.sample)
  end

end

discussions = Discussion.all

50.times do
  # post user can only be the creator or participant
  discussion = discussions.sample
  discussion_users = []
  discussion_users << discussion.creator
  discussion_users << discussion.participant

  post = Post.create!(
    discussion: discussion,
    user: discussion_users.sample,
    body: Faker::Lorem.paragraphs(10).join("\n")
  )

  post.update_attributes!(created_at: rand(10.minutes .. 6.months).ago)

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


puts "Seed Finished"
puts "#{User.count} users created."
puts "#{Discussion.count} discussions created."
puts "#{Post.count} posts created."
