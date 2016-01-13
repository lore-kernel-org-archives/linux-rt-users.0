From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] hwlatdetect: modify to handle python3 prints
Date: Wed, 13 Jan 2016 15:59:46 +0100
Message-ID: <1452697187-14894-3-git-send-email-jkacur@redhat.com>
References: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35633 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbcAMO75 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 09:59:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so37335695wmf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 06:59:57 -0800 (PST)
In-Reply-To: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Use __future__ import of print_function and make sure all instances
of print are now functions rather than statements.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 2a1c562c2188..c8c86ad189ca 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -7,6 +7,8 @@
 # modify it under the terms of the GNU General Public License Version 2
 # as published by the Free Software Foundation.
 
+from __future__ import print_function
+
 import sys
 import os
 import time
@@ -295,7 +297,7 @@ class Hwlat(object):
                 while val:
                     val = val.strip()
                     self.samples.append(val)
-                    if watch: print val
+                    if watch: print(val)
                     debug("got a latency sample: %s" % val)
                     val = self.get_sample()
                 time.sleep(0.1)
@@ -391,7 +393,7 @@ class Smi(object):
                 val = val.strip()
                 if int(val) >= threshold:
                     self.samples.append(val)
-                    if watch: print val
+                    if watch: print(val)
                     debug("got a latency sample: %s (threshold: %d)" % (val, self.get("threshold")))
                 time.sleep(0.1)
         except KeyboardInterrupt as e:
@@ -572,7 +574,7 @@ if __name__ == '__main__':
             if count > detect.initsmi[i]:
                 smis = count - detect.initsmi[i]
                 total_smis += smis
-                print "%d SMIs occured on cpu %d" % (smis, i)
+                print("%d SMIs occured on cpu %d" % (smis, i))
         info("SMIs during run: %d" % total_smis)
 
     if reportfile:
-- 
2.4.3

