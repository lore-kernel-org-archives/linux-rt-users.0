Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1893CC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiKKTxs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiKKTxq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:46 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FD1583E
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:44 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z17so3579038qki.11
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK9CONtc3G9eq0TRe7qQrSZDDogI1s8NNa3t6DhNjMQ=;
        b=kgsBqArmEGLbkWpDrsvl0jjD9upEydSx9zZaXuf9SU2w1tiUDYM71KnMW4+EZLuiJ3
         hJLOyHznufv1h0VQTiCbbhTjmKu/UsCMjxMwTlVeVtqNbdzJhQJQ/xCG5YVS7fbcfiS/
         gtn/dBzPeL/9/+wmiyoXr7p6Cv3jV93Kt0evwuYNbTXYg83H7o/X5NRMzthPlq2lOWWg
         tR2BxBEpd3vF6isir4vzXQetkCu+0GbVL767pK1ZtqH+mwtVBm8Ncwc4bSj2RhuWKweZ
         iSVWH43CrVjIr4e5iG07+M/6KNof3E+vaitk00Pzex6yvZyCsmuvegrVrrUKh4uCwiuL
         LweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wK9CONtc3G9eq0TRe7qQrSZDDogI1s8NNa3t6DhNjMQ=;
        b=WOkNQNWCxcbYs7AufzZylZLkpSOnFETETu96/+zxqlKsBST1cvClA3jcKM8NNaaMg0
         CSxg9XFKRTUYYCeZ1mxDb/PLBKNYx2zkxxosGIxf767LOWWF+hun4Cy71nFd00PeqG0a
         clzNqNs0LvAghg8ZSpz8pV3n5pAa/ZmjLw2iOIkpZaobZZ0i3Ibi9p7qV2jbYgTVoaDF
         7sT0aSZbHO3DQ4cHc08HJPTmWZQePTJV6LaHmJAZY52hWYD35rsLkb0ADq9VOswrrjnB
         FyWMtKximfS+UcpJT2A8OgqMIW4UiXDr2CPgIqMgZ+aOXSWJ2CbSWkXKqAtfu4d+w7pc
         RPug==
X-Gm-Message-State: ANoB5pnIIa440vcpL6rexnqogHL7zV1NoS4NS/8BG4nz3TfFYfJMWImV
        aIKx/F4ZziXxfoAvvV5VBY7qeJ7and0=
X-Google-Smtp-Source: AA0mqf4EFRE/novXank3c+9T7GXVrqOhZk8Gn0cONSE1X3Xp1BmGIQNOXj/ZpINlF2GgeMyustNYNw==
X-Received: by 2002:a05:620a:b86:b0:6f3:e3b7:6a5b with SMTP id k6-20020a05620a0b8600b006f3e3b76a5bmr2433818qkh.607.1668196422888;
        Fri, 11 Nov 2022 11:53:42 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/8] rt-tests: hwlatdetect.py Covert to f-strings
Date:   Fri, 11 Nov 2022 14:53:21 -0500
Message-Id: <20221111195323.27402-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Leah Leshchinsky <lleshchi@redhat.com>

Add f-strings where applicable for readability.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 74 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 9ef50f862127..1efbe7a60059 100755
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
-    info("        Latency threshold: %dus" % int(detect.get("threshold")))
-    info("        Sample window:     %dus" % int(detect.get("window")))
-    info("        Sample width:      %dus" % int(detect.get("width")))
-    info("     Non-sampling period:  %dus" % (int(detect.get("window")) - int(detect.get("width"))))
-    info("        Output File:       %s" % reportfile)
+    info(f"        CPU list:          {args.cpulist}")
+    info(f"        Latency threshold: {int(detect.get('threshold'))}us")
+    info(f"        Sample window:      {int(detect.get('window'))}us")
+    info(f"        Sample width:      {int(detect.get('width'))}us")
+    info(f"     Non-sampling period:  {(int(detect.get('window')) - int(detect.get('width')))}us")
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
+    info(f"Samples recorded: {len(detect.samples)}")
 
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
2.38.1

