Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C9C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10876120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKKUp2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhKKUp2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:28 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC6C061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:38 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bq14so7082730qkb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtCcKyCHqFvL6q1Sn0e8nHQHwA+0l5fm/HiKiwqEjZI=;
        b=cIyYHtPJmdMoR0dI9bm9jFfLPu4oe3Am+t0ug6ilz4PEEkBJc4ye4oRbis9dKVZsDq
         XLmQqa2NXaHQvjyvb/FKAEMGS5hWMzSFy0UdkaGz9UAt7G9X1+pBAwXq22BetC9igUDz
         caQR/2is43J7EqnQRfKmML0qfMFF3R8FBn7kcxgdrpL42xbwE3GPyuehOZas5lpSYyoi
         7+N1pqTSCceTDKLnUutYRWcFF6BHqxHNCe9kVQUrNzANIsnG/rZ9hDZZegOB5tJb96Ry
         3vJmFZm79evtTOzxbTFN/VobpwlhSVsZc73IzWRN7gkq6ycnRVZj+Kx7gs8/I2TjA2BU
         tJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TtCcKyCHqFvL6q1Sn0e8nHQHwA+0l5fm/HiKiwqEjZI=;
        b=nP2NWSXY5PPcZuUXfped9F9spr2570Dn3lngcDyTp6DdYMxwi8yKuAapLqMrjO0ipq
         IpP4akK0nDzkge7eFPUI0R8SpRToKmpqfRHiyP/1QntWbguwnNXdhFgQpfm5qD7bvBMr
         YuirrF+zrxzuQzg6Nc66ZDavbeqF/xvS942LxJmm5Iwil/zdQdX6AdEyXyPhK86jKg8p
         4PCYUK4eN64sGpKoSbrOoVD6gIjExXUoZvr5vaEjksX7GOo89N3PQsLIel8/nQsmmVyb
         FNgXmKD0RsPe7bWwgyIUhs4PkXfxwgcYsqazBTUeEhExiYKjj40BpxNK+tvs19L8l3Bs
         KEqw==
X-Gm-Message-State: AOAM530PDAbO8F3ZznVJhm6vNSJdZaWdirApyd3sikZY6doPUrBmdb7C
        X2XQ7rotPtCbxZaaRiIwnUjWzOQ3UiE=
X-Google-Smtp-Source: ABdhPJyaAyB9rtK0xsptr2F85zlcIWAOwRM4s7vbRR4pSIOi9nyTb/NiqHN6F4A3/QH4zfKsT8Ymnw==
X-Received: by 2002:a05:620a:22a5:: with SMTP id p5mr8360743qkh.189.1636663357292;
        Thu, 11 Nov 2021 12:42:37 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 14/17] rt-tests: hwlatdetect: Don't use built-in name str as a variable
Date:   Thu, 11 Nov 2021 15:42:04 -0500
Message-Id: <20211111204207.10167-14-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Don't use built-in name "str" as a variable
- Add some more docstrings to methods

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 122 +++++++++++++++++----------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index c22e5eba25f6..27c2b8a2d138 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -21,14 +21,16 @@ quiet = False
 watch = False
 
 
-def debug(str):
+def debug(dstr):
+    """ print debugging string if debugging is on """
     if debugging:
-        print(str)
+        print(dstr)
 
 
-def info(str):
+def info(istr):
+    " print info string if quiet is not on """
     if not quiet:
-        print(str)
+        print(istr)
 
 
 #
@@ -39,7 +41,7 @@ def info(str):
 # it mounted.
 #
 class DebugFS:
-    '''class to manage mounting/umounting the debugfs'''
+    """ class to manage mounting/umounting the debugfs """
     def __init__(self):
         self.premounted = False
         self.mounted = False
@@ -53,6 +55,7 @@ class DebugFS:
                     break
 
     def mount(self, path='/sys/kernel/debug'):
+        """ mount debugfs unless already mounted """
         if self.premounted or self.mounted:
             debug("not mounting debugfs")
             return True
@@ -65,6 +68,7 @@ class DebugFS:
         return self.mounted
 
     def umount(self):
+        """ unmount debugfs if not premounted """
         if self.premounted or not self.mounted:
             debug("not umounting debugfs")
             return True
@@ -76,6 +80,7 @@ class DebugFS:
         return not self.mounted
 
     def getval(self, item, nonblocking=False):
+        """ get value of mountpoint/item """
         path = os.path.join(self.mountpoint, item)
         if nonblocking is False:
             with open(path) as f:
@@ -90,21 +95,18 @@ class DebugFS:
                     val = None
                 else:
                     raise
-            except IOError as e:
-                if e.errno == errno.EAGAIN:
-                    val = None
-                else:
-                    raise
             f.close()
         return val
 
     def putval(self, item, value):
+        """ write value to mountpoint/item """
         path = os.path.join(self.mountpoint, item)
         with open(path, "w") as f:
             f.write(str(value))
             f.flush()
 
     def getpath(self, item):
+        """ get mountpoint/item """
         return os.path.join(self.mountpoint, item)
 
 
@@ -153,12 +155,14 @@ class Detector:
     # use c_states_on() to close the file descriptor and re-enable c-states
     #
     def c_states_off(self):
+        """ disable c-state transitions """
         if os.path.exists("/dev/cpu_dma_latency"):
             self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
             os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
             debug("c-states disabled")
 
     def c_states_on(self):
+        """ close the file descriptor and re-enable c-states """
         if self.dma_latency_handle:
             os.close(self.dma_latency_handle)
             debug("c-states enabled")
@@ -184,6 +188,7 @@ class Detector:
         ''' output the sample data as a string '''
 
     def start(self):
+        """ enable the detector """
         count = 0
         threshold = int(self.get("threshold"))
         self.c_states_off()
@@ -201,6 +206,7 @@ class Detector:
         debug("detector module enabled (threshold: %d)" % int(self.get("threshold")))
 
     def stop(self):
+        """ disable the detector """
         count = 0
         debug("disabling detector module")
         self.set("enable", 0)
@@ -244,12 +250,12 @@ class Tracer(Detector):
             return "ts: %s, inner:%d, outer:%d" % (self.timestamp, self.inner, self.outer)
 
         def display(self):
+            """ convert object to string and print """
             print(str(self))
 
         def largest(self):
-            if self.inner > self.outer:
-                return self.inner
-            return self.outer
+            """ return largest value of inner or outer """
+            return max(self.inner, self.outer)
 
     def translate(self, field):
         path = self.debugfs.getpath('tracing')
@@ -274,7 +280,7 @@ class Tracer(Detector):
     def get(self, field):
         if field == "count":
             return len(self.samples)
-        elif field == "max":
+        if field == "max":
             max = 0
             for values in self.samples:
                 s = int(values.largest())
@@ -311,6 +317,7 @@ class Tracer(Detector):
         return val
 
     def save(self, output=None):
+        """ save samples """
         if output:
             with open(output, "w") as f:
                 for s in self.samples:
@@ -328,54 +335,51 @@ class Tracer(Detector):
             raise RuntimeError("Failed to unmount debugfs")
 
 
-def seconds(str):
+def seconds(sval):
     "convert input string to value in seconds"
-    if str.isdigit():
-        return int(str)
-    elif str[-2].isalpha():
-        raise RuntimeError("illegal suffix for seconds: '%s'" % str[-2:-1])
-    elif str[-1:] == 's':
-        return int(str[0:-1])
-    elif str[-1:] == 'm':
-        return int(str[0:-1]) * 60
-    elif str[-1:] == 'h':
-        return int(str[0:-1]) * 3600
-    elif str[-1:] == 'd':
-        return int(str[0:-1]) * 86400
-    elif str[-1:] == 'w':
-        return int(str[0:-1]) * 86400 * 7
-    else:
-        raise RuntimeError("invalid input for seconds: '%s'" % str)
-
-
-def milliseconds(str):
+    if sval.isdigit():
+        return int(sval)
+    if sval[-2].isalpha():
+        raise RuntimeError("illegal suffix for seconds: '%s'" % sval[-2:-1])
+    if sval[-1:] == 's':
+        return int(sval[0:-1])
+    if sval[-1:] == 'm':
+        return int(sval[0:-1]) * 60
+    if sval[-1:] == 'h':
+        return int(sval[0:-1]) * 3600
+    if sval[-1:] == 'd':
+        return int(sval[0:-1]) * 86400
+    if sval[-1:] == 'w':
+        return int(sval[0:-1]) * 86400 * 7
+    raise RuntimeError("invalid input for seconds: '%s'" % sval)
+
+
+def milliseconds(sval):
     "convert input string to millsecond value"
-    if str.isdigit():
-        return int(str)
-    elif str[-2:] == 'ms':
-        return int(str[0:-2])
-    elif str[-1] == 's':
-        return int(str[0:-2]) * 1000
-    elif str[-1] == 'm':
-        return int(str[0:-1]) * 1000 * 60
-    elif str[-1] == 'h':
-        return int(str[0:-1]) * 1000 * 60 * 60
-    else:
-        raise RuntimeError("invalid input for milliseconds: %s" % str)
-
-
-def microseconds(str):
+    if sval.isdigit():
+        return int(sval)
+    if sval[-2:] == 'ms':
+        return int(sval[0:-2])
+    if sval[-1] == 's':
+        return int(sval[0:-2]) * 1000
+    if sval[-1] == 'm':
+        return int(sval[0:-1]) * 1000 * 60
+    if sval[-1] == 'h':
+        return int(sval[0:-1]) * 1000 * 60 * 60
+    raise RuntimeError("invalid input for milliseconds: %s" % sval)
+
+
+def microseconds(sval):
     "convert input string to microsecond value"
-    if str.isdigit():
-        return int(str)
-    elif str[-2:] == 'ms':
-        return int(str[0:-2]) * 1000
-    elif str[-2:] == 'us':
-        return int(str[0:-2])
-    elif str[-1:] == 's':
-        return int(str[0:-1]) * 1000 * 1000
-    else:
-        raise RuntimeError("invalid input for microseconds: '%s'" % str)
+    if sval.isdigit():
+        return int(sval)
+    if sval[-2:] == 'ms':
+        return int(sval[0:-2]) * 1000
+    if sval[-2:] == 'us':
+        return int(sval[0:-2])
+    if sval[-1:] == 's':
+        return int(sval[0:-1]) * 1000 * 1000
+    raise RuntimeError("invalid input for microseconds: '%s'" % sval)
 
 
 if __name__ == '__main__':
-- 
2.31.1

