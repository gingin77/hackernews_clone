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
  posts = Submission.create([
    {
      user: user1,
      text: "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
    },
    {
      user: user2,
      url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
      title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
    }
  ])
  Submission.create({
    user: user1,
    post: posts[0],
    text: "Yay for plants..."
  })
elsif (!User.first.nil? && !User.last.nil?)
  ar_user1 = User.first
  ar_user2 = User.last
  posts = Submission.create([
    {
      user: ar_user1,
      text: "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
    },
    {
      user: ar_user2,
      url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
      title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
    }
  ])
  Submission.create({
    user: ar_user1,
    post: posts[0],
    text: "Yay for plants..."
  })
end
