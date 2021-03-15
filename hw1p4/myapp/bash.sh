#!/bin/bash

# curl -XPOST -d'{"word":"evilmartian", "count": 3}' http://myvm.localhost/
# 💀evilmartian💀evilmartian💀evilmartian💀

# curl http://127.0.0.1:5000/hw/

# curl http://127.0.0.1:5000/   

# curl -X POST -d'{"word":"evilmartian", "count": 5}' http://127.0.0.1:5000/increment_value



curl -X POST -d'{"word":"evilmartian", "count": 5}' http://flask.jeniatr.space/increment_value
