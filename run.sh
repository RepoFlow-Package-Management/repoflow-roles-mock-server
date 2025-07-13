docker build -t repoflow-mock-roles-api .
docker run -p 9085:9085 \
  -v $(pwd)/roles:/usr/share/nginx/html/roles \
  repoflow-mock-roles-api
