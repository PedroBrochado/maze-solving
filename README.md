# Running the code
```bash
docker run --rm -v $(pwd):/app -w /app ruby ruby run.rb ./spec/fixtures/multiple.txt
```

# Running tests
```bash
docker build -t maze-solving . && docker run --rm maze-solving rspec
```

# Develop
```bash
docker run --rm -it -v $(pwd):/app -w /app maze-solving bash
```