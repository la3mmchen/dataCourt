#!/usr/bin/env python

import pycurl
import json
from time import time
import cStringIO

buf = cStringIO.StringIO()
lastupdate = 1454410800

c = pycurl.Curl()
c.setopt(c.URL, 'https://jawbone.com/nudge/api/v.1.1/users/@me/moves?updated_after=' + str(lastupdate))
c.setopt(c.WRITEFUNCTION, buf.write)
c.setopt(c.HTTPHEADER, ["Content-Type: application/json",
			"Authorization: Bearer access_token"])
c.setopt(c.VERBOSE, True)
c.setopt(c.SSL_VERIFYPEER, 0)
c.perform()
c.close()

print buf.getvalue()

jsondict = json.loads(buf.getvalue())

#print buf.getvalue();
print ''
print ''
for i in  jsondict['data']['items']:
	print "::"+str(i)
buf.close()
