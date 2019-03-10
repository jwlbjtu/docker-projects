version: '3'
services: 
  production:
    build: .
    ports: 
      - "8080:80"