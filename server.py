from gevent.server import StreamServer

def handler(client, address):
    while True:
        try:
            data = client.recv(14)
            if not data:
                break
        except:
            break

        client.sendall("+PING\r\n")


s = StreamServer(("127.0.0.1", 6380), handler)
s.serve_forever()

