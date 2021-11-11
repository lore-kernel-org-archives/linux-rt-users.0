Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D1C43219
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FD961268
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhKKUp1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhKKUp1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:27 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6CC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:37 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 132so7017176qkj.11
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGHzahTgacEr4beU7z6aiO2ulmPbTdR6SYDK4UxraAc=;
        b=AuojSwdb8qAhjb9zPgqGrBe6W5up5iSIPuA7yM9CZWhVfIxYp8D2dmRYaOzdoQkx/k
         OV4tJcVk9HP+rYAQCpd7/ToEKrWuYMPgP+h0wjkXy2p4cVW9a96lwLYoJfFL/EpmwiKI
         mEWfFJEE8+jGCCN+aU8mwZTMV3P3zk2DywucYGgj3fXLKFc/CkQpY2gQUENALBS0MBmd
         FXDuEZpFt3jxeJKL4vlCQDWy96Ff+lTaDPIDrwgRCvchhNmqyNaD9T06XkBtgvQgqbAc
         LIUjk6jcKdeW4SiZnRnpC7w3O3Oehn3LlJryRQpVRXXmVWu1vsEfFGuMQ6SyuPyObGbw
         j8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pGHzahTgacEr4beU7z6aiO2ulmPbTdR6SYDK4UxraAc=;
        b=QuKU0ToLlvuwkFmPCaDslDsxOeH/FL+QZbA3SnY5euVCojxgp9b6Dr8w+2IannQsef
         DU6EgvaNNRnLUwDT8mT9/FT0pXKj3aI0zckA3umj2Gf+aNdcGq9mAl5+Vp0JsUlUXLKi
         LGmVvl/qQ9lw5yUQIqgngrQHN3RgJ2nkOCKuxDWRVcDABeVsfXHyf7W/D3/UJx9nEbNm
         Pe7BBxkdcQZC7SdHUFap9jKoYV88XpOM7JhzHgNGigkR1XuSNCMowIf2qaj7xLZPbrIx
         0oD33Y/M69qJpzvq9TB2zRsBKe5LoIBAZz31aImK4jagefaj1Tym2tfjQd6YNIDKgxRP
         kRFQ==
X-Gm-Message-State: AOAM533Wu+MfGykKx2580SMSEhbzuoRKFp2NKOKiRTMJBKImDOJZv/NN
        LlXgzsGObvk6Q+PRuiDLmfC8l5eXpyg=
X-Google-Smtp-Source: ABdhPJwx9J3rerYH3/bJNTJvv7NSRTMddbmkSU7JFbJqL0/QERcmwcAgQMEqd2jhAThDyBtod1uzwQ==
X-Received: by 2002:a05:620a:4312:: with SMTP id u18mr8414913qko.483.1636663356287;
        Thu, 11 Nov 2021 12:42:36 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:36 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 13/17] rt-tests: hwlatdetect: Remove unused class Kmod
Date:   Thu, 11 Nov 2021 15:42:03 -0500
Message-Id: <20211111204207.10167-13-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Remove class Kmod
  Kmod was used for loading and unloading of a kernel module, but
  hwlatdetect uses ftrace now so this class is unneeded.
- Improve the spacing in the code

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 107 ++++++---------------------------
 1 file changed, 19 insertions(+), 88 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index ea8f2036fe82..c22e5eba25f6 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -20,14 +20,17 @@ debugging = False
 quiet = False
 watch = False
 
+
 def debug(str):
     if debugging:
         print(str)
 
+
 def info(str):
     if not quiet:
         print(str)
 
+
 #
 # Class used to manage mounting and umounting the debugfs
 # filesystem. Note that if an instance of this class mounts
@@ -78,7 +81,7 @@ class DebugFS:
             with open(path) as f:
                 val = f.readline()
         else:
-            f = os.fdopen(os.open(path, os.O_RDONLY|os.O_NONBLOCK), "r")
+            f = os.fdopen(os.open(path, os.O_RDONLY | os.O_NONBLOCK), "r")
             try:
                 val = f.readline()
             except OSError as e:
@@ -104,89 +107,19 @@ class DebugFS:
     def getpath(self, item):
         return os.path.join(self.mountpoint, item)
 
-# Exception class for when tracer is not available
+
 class DetectorNotAvailable(Exception):
+    """ Exception class for when tracer is not available """
+
     def __init__(self, name, msg):
         self.args = (name, msg)
         self.name = name
         self.msg = msg
 
-#
-# Class used to manage loading and unloading of the
-# hwlat kernel module. Like the debugfs class
-# above, if the module is already loaded, this class will
-# leave it alone when cleaning up.
-#
-class Kmod:
-    ''' class to manage loading and unloading of kernel modules'''
-
-    names = ("hwlat_detector", "smi_detector")
-
-    def __check_builtin(self):
-        for l in open(os.path.join('/lib/modules', os.uname()[2], 'modules.builtin'), "r"):
-            if self.name in l:
-                debug("found %s as builtin" % self.namename)
-                return True
-        return False
-
-    def __find_module(self):
-        debug("looking for module %s" % self.name)
-        path = os.path.join("/lib/modules",
-                            os.uname()[2],
-                            "kernel/drivers/misc")
-        debug("module path: %s" % path)
-        mpath = os.path.join(path, self.name) + ".ko"
-        debug("checking %s" % mpath)
-        if os.path.exists(mpath):
-            return True
-        return False
-
-    def __init__(self, name):
-        if name not in Kmod.names:
-            raise RuntimeError("unsupported module name: %s" % name)
-        if name == "smi_detector":
-            raise RuntimeError("smi_detector module no longer supported!")
-        self.name = name
-        self.preloaded = False
-        self.builtin = False
-
-        # check for builtin
-        if self.__check_builtin():
-            self.builtin = True
-            return
-
-        # now look for already loaded module
-        for l in open('/proc/modules'):
-            field = l.split()
-            if self.name in field[0]:
-                self.preloaded = True
-                debug("using already loaded %s" % self.name)
-                return
-        if not self.__find_module():
-            raise DetectorNotAvailable(name, "module %s does not exist!" % self.name)
-
-    def load(self):
-        if self.builtin:
-            debug("not loading %s (builtin)" % self.name)
-            return True
-        if self.preloaded:
-            debug("not loading %s (already loaded)" % self.name)
-            return True
-        cmd = ['/sbin/modprobe', self.name]
-        return subprocess.call(cmd) == 0
-
-    def unload(self):
-        if self.preloaded or self.builtin:
-            debug("Not unloading %s" % self.name)
-            return True
-        cmd = ['/sbin/modprobe', '-r', self.name]
-        return subprocess.call(cmd) == 0
 
-#
-# base class for detection modules
-#
 class Detector:
-    '''base class for detector modules'''
+    """ base class for detector modules """
+
     def __init__(self):
         self.type = "unknown"
         if os.getuid() != 0:
@@ -195,7 +128,7 @@ class Detector:
         if not self.debugfs.mount():
             raise RuntimeError("failed to mount debugfs")
         self.samples = []
-        self.testduration = 30 # ten seconds
+        self.testduration = 30  # ten seconds
         self.have_msr = False
         self.initsmi = []
         if os.path.exists('/usr/sbin/rdmsr'):
@@ -283,11 +216,11 @@ class Detector:
     @abc.abstractmethod
     def detect(self):
         ''' get detector output '''
-#
-# class to handle running the hwlat tracer module of ftrace
-#
+
+
 class Tracer(Detector):
-    '''class to wrap access to ftrace hwlat tracer'''
+    """ Class to handle running the hwlat tracer module of ftrace """
+
     __field_translation = {
         'width'     : "hwlat_detector/width",
         'window'    : "hwlat_detector/window",
@@ -298,9 +231,10 @@ class Tracer(Detector):
     class Sample:
         'private class for tracer sample data'
         __slots__ = 'timestamp', 'inner', 'outer'
+
         def __init__(self, line):
             fields = line.split()
-            i,o = fields[6].split('/')
+            i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
             self.inner = int(i)
@@ -383,7 +317,6 @@ class Tracer(Detector):
                     f.write("%s\n" % str(s))
                 print("report saved to %s (%d samples)" % (output, len(self.samples)))
 
-
     def display(self):
         for s in self.samples:
             s.display()
@@ -414,6 +347,7 @@ def seconds(str):
     else:
         raise RuntimeError("invalid input for seconds: '%s'" % str)
 
+
 def milliseconds(str):
     "convert input string to millsecond value"
     if str.isdigit():
@@ -443,9 +377,6 @@ def microseconds(str):
     else:
         raise RuntimeError("invalid input for microseconds: '%s'" % str)
 
-#
-# main starts here
-#
 
 if __name__ == '__main__':
     from argparse import ArgumentParser
@@ -533,7 +464,7 @@ if __name__ == '__main__':
     if args.duration:
         detect.testduration = seconds(args.duration)
     else:
-        detect.testduration = 120 # 2 minutes
+        detect.testduration = 120  # 2 minutes
     debug("test duration is %ds" % detect.testduration)
 
     if args.watch:
@@ -569,7 +500,7 @@ if __name__ == '__main__':
     if detect.have_msr:
         finishsmi = detect.getsmicounts()
         total_smis = 0
-        for i,count in enumerate(finishsmi):
+        for i, count in enumerate(finishsmi):
             if count > detect.initsmi[i]:
                 smis = count - detect.initsmi[i]
                 total_smis += smis
-- 
2.31.1

