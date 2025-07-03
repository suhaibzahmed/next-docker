import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
  /* config options here */
  output: 'standalone',
  serverExternalPackages: ['@prisma/client'],
  // experimental: {
  //   serverComponentsExternalPackages: ['@prisma/client'],
  // },
}

export default nextConfig
