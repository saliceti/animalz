# Animalz

## Run locally

### Mac
- Install ruby 2.7.1 (RVM recommended)
- Install postgres 12:
  ```
  brew install postgresql@12
  ```
- Add postgres 12 to PATH. Add to `~/.zshrc` :
  ```
  export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
  ```
- Install ruby dependencies:
  ```
  bundle
  ```
- Install `yarn`:
  ```
  brew install yarn
  ```
- Install javascript dependencies:
  ```
  yarn install --check-files
  ```
- Start postgres:
  ```
  make start-db
  ```
- Create dev and test databases:
  ```
  rails db:setup
  ```

### Run tests
- Start postgres:
  ```
  make start-db
  ```
- ```
  rspec
  ```

### Run server
- Start rails
  ```
  rails s
  ```
- Access http://localhost:3000

## Production
Configure Amazon S3 to store animon pictures.

### Create bucket
- Private access
- Region: eu-west-1

### Create user with policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteBucket"
            ],
            "Resource": [
                "arn:aws:s3:::<BUCKET NAME>/*",
                "arn:aws:s3:::<BUCKET NAME>"
            ]
        }
    ]
}
```

### Configure heroku config variables
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
S3_BUCKET
```
