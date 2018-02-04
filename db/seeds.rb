User.create([
  {
    name: 'Ginnie',
    email: 'ginniehench@gmail.com',
    password: 'secret!'
  },
  {
    name: 'Ellie',
    email: 'ellie@awesomedogs.com',
    password: 'secret!'
  },
])

Submission.create([
  {
    user_id: 1,
    text: "Plants don’t get enough credit. They move. You know this. Your houseplant salutes the sun each morning. At night, it returns to center."
  },
  {
    user_id: 1,
    url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia.html?rref=collection%2Fsectioncollection%2Fscience",
    title: "Sedate a Plant, and It Seems to Lose Consciousness. Is It Conscious?"
  },
  {
    user_id: 2,
    post_id: 1,
    text: "Yay for plants..."
  },
])
