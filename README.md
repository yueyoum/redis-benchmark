
```
redis-benchmark -t ping -n N -c C -p Port

N: Total number of requests
C: Number of parallel connections
Port: Redis Port. (Or your application which can response redis ping request)
```
redis ping will send `PING\r\n` and `*1\r\n$4\r\nPING\r\n`,
and the server should return `+PONG\r\n`


I have write two simple servers which can response the redis ping request.

*   server.erl is written in Erlang
*   server.py is written in Python. Based on Gevent

I made a Benchmark, which shows 

*   the redis-server is fastest.
*   Python is very stable.
*   Erlang will close the connection when N = 100000,

    redis-benchmark says: `Error: Connection reset by peer`.
    even C = 50, this error also occurred!

###### Why erlang not stable. Is there my code incorrect?



### Charts

###### C = 10, N = 10000, 100000, 1000000

![b1][1]


###### N = 10000, N = 50 to 1000

In fact, erlang fill fail on test even C = 50

![b2][2]

[1]: charts/b1.png
[2]: charts/b2.png

