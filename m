Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925FC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Nov 2022 20:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKIUNq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUNo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Nov 2022 15:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAF1704C
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Nov 2022 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668024765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mnf0TotOLEW2LG8tYWKNylXRlzUExLBVPvF3QmfUiZc=;
        b=Kjtvlnw5oto4a4DSpXudomF4GCye6qJm9YePkW+gUBxCcmh6wiZbApLI5pgrVIProiekJv
        5wq9aam44colPRbhoTUDH5FrJ6h3ABw/Opwu9CfQcBEJvfk5PLCeUxmyCoZGt9KdLa7Cuy
        s7ck6gh46E+iLbNJ0NihFKEMVAwppDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-HuDmYfTiPfOP2y4VjDO-rw-1; Wed, 09 Nov 2022 15:12:42 -0500
X-MC-Unique: HuDmYfTiPfOP2y4VjDO-rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 729C6804187
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Nov 2022 20:12:42 +0000 (UTC)
Received: from lleshchi.bos.com (unknown [10.22.11.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F36F1121333;
        Wed,  9 Nov 2022 20:12:42 +0000 (UTC)
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v2] rt-tests: hwlatdetect.py Covert to f-strings
Date:   Wed,  9 Nov 2022 15:12:41 -0500
Message-Id: <20221109201241.415024-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add f-strings where applicable for readability.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 9ef50f862127..7b1ae646577a 100755
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
@@ -192,18 +192,18 @@ class Detector:
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
             self.set("threshold", threshold)
-        debug("detector module enabled (threshold: %d)" % int(self.get("threshold")))
+        debug(f"detector module enabled (threshold: {int(self.get('threshold'))})")
 
     def stop(self):
         """ disable the detector """
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
@@ -322,8 +322,8 @@ class Tracer(Detector):
         if output:
             with open(output, "w") as f:
                 for s in self.samples:
-                    f.write("%s\n" % str(s))
-                print("report saved to %s (%d samples)" % (output, len(self.samples)))
+                    f.write(f"{s}\n")
+                print(f"report saved to {output} ({len(self.samples)} samples)")
 
     def display(self):
         for s in self.samples:
@@ -341,7 +341,7 @@ def seconds(sval):
     if sval.isdigit():
         return int(sval)
     if sval[-2].isalpha():
-        raise RuntimeError("illegal suffix for seconds: '%s'" % sval[-2:-1])
+        raise RuntimeError(f"illegal suffix for seconds: '{sval[-2:-1]}'")
     if sval[-1:] == 's':
         return int(sval[0:-1])
     if sval[-1:] == 'm':
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
@@ -444,37 +444,37 @@ if __name__ == '__main__':
     if args.threshold:
         t = microseconds(args.threshold)
         detect.set("threshold", t)
-        debug("threshold set to %dus" % t)
+        debug(f"threshold set to {t}us")
 
     if args.hardlimit:
         hardlimit = microseconds(args.hardlimit)
     else:
         hardlimit = int(detect.get("threshold"))
-    debug("hardlimit set to %dus" % hardlimit)
+    debug(f"hardlimit set to {hardlimit}us")
 
     if args.window:
         w = microseconds(args.window)
         if w < int(detect.get("width")):
-            debug("shrinking width to %d for new window of %d" % (w/2, w))
+            debug(f"shrinking width to {w//2} for new window of {w}")
             detect.set("width", w/2)
-        debug("window parameter = %d" % w)
+        debug(f"window parameter = {w}")
         detect.set("window", w)
-        debug("window for sampling set to %dus" % w)
+        debug(f"window for sampling set to {w}us")
 
     if args.width:
         w = microseconds(args.width)
         if w > int(detect.get("window")):
-            debug("widening window to %d for new width of %d" % (w*2, w))
+            debug(f"widening window to {w*2} for new width of {w}")
             detect.set("window", w*2)
-        debug("width parameter = %d" % w)
+        debug(f"width parameter = {w}")
         detect.set("width", w)
-        debug("sample width set to %dus" % w)
+        debug(f"sample width set to {w}us")
 
     if args.duration:
         detect.testduration = seconds(args.duration)
     else:
         detect.testduration = 120  # 2 minutes
-    debug("test duration is %ds" % detect.testduration)
+    debug(f"test duration is {detect.testduration}s")
 
     if args.watch:
         watch = True
@@ -491,18 +491,18 @@ if __name__ == '__main__':
                 l, r = map(int, [c, c])
             for i in range(l, r + 1):
                 cpumask |= (1 << i)
-        debug("set tracing_cpumask to %x" % cpumask)
-        detect.set("cpumask", "%x" % cpumask)
+        debug(f"set tracing_cpumask to {cpumask:x}")
+        detect.set("cpumask", f"{cpumask:x}")
 
-    info("hwlatdetect:  test duration %d seconds" % detect.testduration)
-    info("   detector: %s" % detect.type)
+    info(f"hwlatdetect:  test duration {detect.testduration} seconds")
+    info(f"   detector: {detect.type}")
     info("   parameters:")
-    info("        CPU list:          %s"   % args.cpulist)
+    info(f"        CPU list:          {args.cpulist}")
     info("        Latency threshold: %dus" % int(detect.get("threshold")))
     info("        Sample window:     %dus" % int(detect.get("window")))
     info("        Sample width:      %dus" % int(detect.get("width")))
     info("     Non-sampling period:  %dus" % (int(detect.get("window")) - int(detect.get("width"))))
-    info("        Output File:       %s" % reportfile)
+    info(f"        Output File:       {reportfile}")
     info("\nStarting test")
 
     detect.detect()
@@ -513,12 +513,12 @@ if __name__ == '__main__':
     if max_latency == 0:
         info("Max Latency: Below threshold")
     else:
-        info("Max Latency: %dus" % max_latency)
+        info(f"Max Latency: {int(max_latency)}us")
 
-    info("Samples recorded: %d" % len(detect.samples))
+    info(f"Samples recorded: {int(len(detect.samples))}")
 
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

