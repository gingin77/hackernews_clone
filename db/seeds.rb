Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

SUBMITTER_NAMES.each do |name|
  email = "#{(name[0] + name.split(' ')[name.split.length - 1]).downcase}@email.com"
  User.create({
    name: name,
    email: email,
    password: 'secret!'
  })
end

POST_CONTENT.map do |post|
  submitter = User.find_by(name: post[:contributor])
  Post.create({
    title: post[:title],
    submitter: submitter,
    url: post[:url]
  })
end

DIRECT_COMMENT_CONTENT.map do |obj|
  fb_parent_post_id = obj[:fb_id]
  parent = POST_CONTENT.select { |post| post[:fb_id] == fb_parent_post_id }
  parent_post = Post.find_by(url: parent[0][:url])
  submitter = User.find_by(name: obj[:contributor][0])
  Comment.create({
    submitter: submitter,
    commentable: parent_post,
    text: obj[:text]
  })
end

REPLY_COMMENT_CONTENT.map do |reply|
  parents_fb_comment_id = reply[:parent_comment_id]
  parent_comment_value = DIRECT_COMMENT_CONTENT.select do |comment|
    comment[:fb_comment_id] == parents_fb_comment_id
  end
  parent_comment = (Comment.find_by(text: parent_comment_value[0][:text]))

  submitter = User.find_by(name: reply[:contributor][0])

  Comment.create({
    submitter: submitter,
    commentable: parent_comment,
    text: reply[:text]
  })
end

user1 = User.create({
  name: 'Ginnie',
  email: 'ginniehench@gmail.com',
  password: 'secret!'
})

user2 = User.create({
  name: 'Ellie',
  email: 'ellie@awesomedogs.com',
  password: 'secret!'
})

posts = Post.create([
  {
    submitter: user1,
    text: "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
  },
  {
    submitter: user2,
    url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
    title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
  }
])

direct_comment = Comment.create({
  submitter: user2,
  commentable: posts[0],
  text: "So true! I have to rotate my little stemmy succulent or it gets all bendy following the light."
})

reply_comments = Comment.create([{
  submitter: user1,
  commentable: direct_comment,
  text: "Crazy plants..."
},
{
  submitter: user2,
  commentable: direct_comment,
  text: "yeah"
}])

nested_comment_1 = Comment.create({
  submitter: user2,
  commentable: reply_comments[0],
  text: "plants need water"
})

Comment.create({
  submitter: user1,
  commentable: nested_comment_1,
  text: "or boring plants..."
})

100.times do |v|
  vote = Vote.new({
          value: [1, 1, 1, -1].sample,
          voteable: Post.all.sample,
          voter: User.all.sample
    })
  until !vote.voteable_id.nil?
    vote.voteable_id == [*1..8].sample
  end
  vote.save
end

20.times do |v|
  vote = Vote.new({
          value: [1, 1, 1, -1].sample,
          voteable: Comment.all.sample,
          voter: User.all.sample
    })
  until !vote.voteable_id.nil?
    vote.voteable_id == [*1..Comment.count].sample
  end
  vote.save
end
