task sample_data: :environment do
  starting = Time.now
  p "Creating sample data"
  
  # Clean the deck (the order is important here)
  if Rails.env.development?
    FollowRequest.destroy_all
    Like.destroy_all
    Comment.destroy_all
    Photo.destroy_all
    User.destroy_all
  end

  # Create Users

  usernames = Array.new {Faker::Name.first_name}
  usernames << "alice"
  usernames << "bob"

  usernames.each do |username|
    User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true, false].sample
    )
    # p user.errors.full_messages
  end
  p "Added #{User.count} Users"


  # Adding Follow Requests
  users = User.all
  30.times do
    fr = FollowRequest.create(
    #status: ["pending", "accepted", "rejected"].sample,
    status: FollowRequest.statuses.keys.sample,
    sender_id: users.sample.id,
    recipient_id: users.sample.id 
    )
  end
  p "Added #{FollowRequest.count} Follow Requests"

  # Adding Photos
  # photos = [
  # "https://tinyurl.comy6hk6oep",
  # "https://tinyurl.com/y5uszprj",
  # "https://picsum.photos/200",
  # "https://tinyurl.com/xc57v5j6",
  # "https://tinyurl.com/3h2kbx2n",
  # "https://tinyurl.com/3wcej37n",
  # "https://tinyurl.com/n86b34m4"
  # ]
  #25.times do 
    # photo = Photo.new
    # photo.caption = Faker::Hipster.sentence
    # photo.image = photos.sample
    # photo.likes_count = Faker::Number.within(range: 0..50)
    # photo.owner_id = users.sample.id
    # photo.save
  #end
  users.each do |user|  
   photo = user.own_photos.create(
      caption: Faker::Hipster.sentence,
      image: "https://robohas.org/#{rand(9999)}"
    )
    user.followers.each do |follower|
      if rand < 0.5
        photo.fans << follower
      end

      if rand < 0.25
        photo.comments.create(
          body: Faker::Quote.jack_handey,
          author: follower
        )
      end
    end

  end
  p "Added #{Photo.count} Photos"

  # Adding Likes
  photos = Photo.all 
  50.times do 
    like = Like.new
    like.fan_id = users.sample.id 
    like.photo_id = photos.sample.id
    like.save
  end
  p "Added #{Like.count} Likes"

  # Adding Comments
  30.times do 
    comment = Comment.new
    comment.body = Faker::Hacker.say_something_smart
    comment.author_id = users.sample.id 
    comment.photo_id = photos.sample.id 
    comment.save
  end
  p "Added #{Comment.count} Comments"

  ending = Time.now
  p "It took #{(ending - starting).to_i} second to create the sample data."
end