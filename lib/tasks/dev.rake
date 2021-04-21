task :sample_data do
  p "Creating sample data for you, bro."

  User.destroy_all
  FollowRequest.destroy_all
  Like.destroy_all
  Photo.destroy_all
  User.destroy_all


  # Create Users
  12.times do 
    user = User.new
    user.username = Faker::Name.Internet.safe_email
    user.private = Faker::Boolean.boolean
    user.password = "password"
    user.comments_count = 0
    user.likes_count = Faker::Number.within(range: 0..50)
    user.save
  end
  p "Added #{User.count} Users"

  # Adding Follow Requests
  users = User.all
  50.times do
    fr = FollowRequest.new
    fr.status = bool.sample
    fr.sender_id = users.sample.id 
    fr.recipient_id = users.sample.id 
    fr.save
  end
  p "Added #{FollowRequest.count} FollowRequests"

  # Adding Photos
  photos = [
    "https://tinyurl.comy6hk6oep",
    "https://tinyurl.com/y5uszprj",
    "https://picsum.photos/200",
    "https://tinyurl.com/xc57v5j6",
    "https://tinyurl.com/3h2kbx2n",
    "https://tinyurl.com/3wcej37n",
    "https://tinyurl.com/n86b34m4"
  ]
  25.times do 
    photo = Photo.new
    photo.caption = Faker::Hipster.sentences(number: 1)
    photo.image = photos.sample
    photo.likes_count = Faker::Number.within(range: 0..50)
    photo.owner_id = users.sample.id
    photo.save
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

end