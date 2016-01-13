From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] hwlatdetect: make reading sample date work with python2 and python3
Date: Wed, 13 Jan 2016 15:59:47 +0100
Message-ID: <1452697187-14894-4-git-send-email-jkacur@redhat.com>
References: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34289 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcAMO76 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 09:59:58 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so37417869wmb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 06:59:58 -0800 (PST)
In-Reply-To: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Modify the sample reading code to return correct string data and to
catch exceptions in non-blocking mode correctly on python{2,3}

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index c8c86ad189ca..d9ef0272d738 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -79,15 +79,21 @@ class DebugFS(object):
             val = f.readline()
             f.close()
         else:
-            fd = os.open(path, os.O_RDONLY|os.O_NONBLOCK)
+            f = os.fdopen(os.open(path, os.O_RDONLY|os.O_NONBLOCK), "r")
             try:
-                val = os.read(fd, 256)
+                val = f.readline()
             except OSError as e:
+                print ("errno: %s" % e)
                 if e.errno == errno.EAGAIN:
                     val = None
                 else:
                     raise
-            os.close(fd)
+            except IOError as e:
+                if e.errno == errno.EAGAIN:
+                    val = None
+                else:
+                    raise
+            f.close()
         return val
 
     def putval(self, item, value):
-- 
2.4.3

