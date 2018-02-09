if User.first.nil?
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
    post: posts[0],
    text: "So true! I have to rotate my little stemmy succulent or it gets all bendy following the light."
  })

  reply_comments = Comment.create([{
    submitter: user1,
    post: posts[0],
    direct_comment_id: direct_comment.id,
    text: "Crazy plants..."
  },
  {
    submitter: user2,
    post: posts[0],
    direct_comment_id: direct_comment.id,
    text: "yeah"
  }])

elsif (!User.first.nil? && !User.last.nil?)
  ar_user1 = User.first
  ar_user2 = User.last

  posts = Post.create([
    {
      submitter: ar_user1,
      text: "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
    },
    {
      submitter: ar_user2,
      url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
      title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
    }
  ])

  Comment.create({
    submitter: ar_user1,
    post: posts[0],
    text: "Yay for plants..."
  })

end
