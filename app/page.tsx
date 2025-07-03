import { prisma } from '@/utils/db'

const HomePage = async () => {
  const posts = await prisma.post.findMany()

  return (
    <div>
      <h1>Posts</h1>
      {posts.length === 0 && <p>No posts found</p>}
      {posts.map((post) => (
        <div key={post.id} className="flex gap-x-4 bg-gray-900 my-4">
          <h2>{post.title}</h2>
          <p>{post.content}</p>
        </div>
      ))}
    </div>
  )
}
export default HomePage
