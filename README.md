# Google Voice SMS Sender
This is a small [Docker](http://docker.com) container that runs a web-service
to facilitate sending of SMS.

## Usage
### Dependencies
1. [Docker](http://docker.com)

### Building

```sh
# Clone the repo
git clone https://github.com/tomislacker/docker-gvoice-sender.git

# Build the container
docker build -t btomasik/gvoice-sender docker-gvoice-sender
```

### Running

```sh
# Start the container (tag will be dependent on the above build call)
docker run --rm \
  -e 'GV_EMAIL=googleUser@gmail.com' \
  -e 'GV_PASSWD=yourPassword' \
  -p 55000:5000 \
  btomasik/gvoice-sender
```

### Calling

To send a message, a PUT API call can be made against the container or
a forwarded port to the container:

```sh
curl -sXPUT \
  --data-urlencode 'to=13335554444' \
  --data-urlencode 'msg=This is my testing message' \
  http://127.0.0.1:55000/msg
```

