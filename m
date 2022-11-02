Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8650AC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Nov 2022 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKBOhA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKBOgv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2022 10:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2732A735
        for <linux-rt-users@vger.kernel.org>; Wed,  2 Nov 2022 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667399757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C+tpZC1aiY8OBStiIX12wseRXeqdcbeK+LhwEFIFGBQ=;
        b=gOf6cxGmgzZEgAEeuWVN62MqY3AHgHdJ8fQM6QzXqbGMLINFY/tNdljnUXdCYO0/rikRiw
        XDlMHUC31eMMuDbmh+afWt5RobfPtTy5gdnODsnkr6bPulGZ9EK10IoNVh5tjU0IDXOCuu
        2Hmbyu4aYPsQYUikL2Su1C+Bul7lmx0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-Oig2AZO5PoyYqAKGZ9kGIA-1; Wed, 02 Nov 2022 10:35:56 -0400
X-MC-Unique: Oig2AZO5PoyYqAKGZ9kGIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C2042A5955B
        for <linux-rt-users@vger.kernel.org>; Wed,  2 Nov 2022 14:35:56 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.18.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D82C340C6E14;
        Wed,  2 Nov 2022 14:35:55 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH] rt-tests: hwlatdetect.py Covert to f-strings
Date:   Wed,  2 Nov 2022 10:35:54 -0400
Message-Id: <20221102143554.214241-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add f-strings where applicable for readability.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 9ef50f862127..3b20f664a536 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -59,7 +59,7 @@ class DebugFS:
         if self.premounted or self.mounted:
             debug("not mounting debugfs")
             return True
-        debug("mounting debugfs at %s" % path)
+        debug(f"mounting debugfs at {path}")
         self.mountpoint = path
         cmd = ['/bin/mount', '-t', 'debugfs', 'none', path]
         self.mounted = (subprocess.call(cmd) == 0)
@@ -90,7 +90,7 @@ class DebugFS:
             try:
                 val = f.readline()
             except OSError as e:
-                print("errno: %s" % e)
+                print(f"errno: {e}")
                 if e.errno == errno.EAGAIN:
                     val = None
                 else:
@@ -192,13 +192,13 @@ class Detector:
         count = 0
         threshold = int(self.get("threshold"))
         self.c_states_off()
-        debug("enabling detector module (threshold: %d)" % threshold)
+        debug(f"enabling detector module (threshold: {threshold})")
         self.set("enable", 1)
         while self.get("enable") == 0:
             debug("still disabled, retrying in a bit")
             count += 1
             time.sleep(0.1)
-            debug("retrying enable of detector module (%d)" % count)
+            debug(f"retrying enable of detector module ({count})")
             self.set("enable", 1)
         if self.get("threshold") != threshold:
             debug("start: threshold reset by start, fixing")
@@ -214,7 +214,7 @@ class Detector:
             debug("still enabled, retrying in a bit")
             count += 1
             time.sleep(0.1)
-            debug("retrying disable of detector module(%d)" % count)
+            debug(f"retrying disable of detector module({count})")
             self.set("enable", 0)
         self.c_states_on()
         debug("detector module disabled")
@@ -248,7 +248,7 @@ class Tracer(Detector):
             self.outer = int(o)
 
         def __str__(self):
-            return "ts: %s, inner:%d, outer:%d" % (self.timestamp, self.inner, self.outer)
+            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}"
 
         def display(self):
             """ convert object to string and print """
@@ -352,7 +352,7 @@ def seconds(sval):
         return int(sval[0:-1]) * 86400
     if sval[-1:] == 'w':
         return int(sval[0:-1]) * 86400 * 7
-    raise RuntimeError("invalid input for seconds: '%s'" % sval)
+    raise RuntimeError(f"invalid input for seconds: '{sval}'")
 
 
 def milliseconds(sval):
@@ -367,7 +367,7 @@ def milliseconds(sval):
         return int(sval[0:-1]) * 1000 * 60
     if sval[-1] == 'h':
         return int(sval[0:-1]) * 1000 * 60 * 60
-    raise RuntimeError("invalid input for milliseconds: %s" % sval)
+    raise RuntimeError(f"invalid input for milliseconds: {sval}")
 
 
 def microseconds(sval):
@@ -380,7 +380,7 @@ def microseconds(sval):
         return int(sval[0:-2])
     if sval[-1:] == 's':
         return int(sval[0:-1]) * 1000 * 1000
-    raise RuntimeError("invalid input for microseconds: '%s'" % sval)
+    raise RuntimeError(f"invalid input for microseconds: '{sval}'")
 
 
 if __name__ == '__main__':
@@ -518,7 +518,7 @@ if __name__ == '__main__':
     info("Samples recorded: %d" % len(detect.samples))
 
     exceeding = detect.get("count")
-    info("Samples exceeding threshold: %d" % exceeding)
+    info(f"Samples exceeding threshold: {exceeding}")
 
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
@@ -527,8 +527,8 @@ if __name__ == '__main__':
             if count > detect.initsmi[i]:
                 smis = count - detect.initsmi[i]
                 total_smis += smis
-                print("%d SMIs occured on cpu %d" % (smis, i))
-        info("SMIs during run: %d" % total_smis)
+                print(f"{smis} SMIs occured on cpu {i}")
+        info(f"SMIs during run: {total_smis}")
 
     maxlatency = int(detect.get("max"))
 
-- 
2.31.1

