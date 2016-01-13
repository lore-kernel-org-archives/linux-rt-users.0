From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] hwlatdetect: handle hwlat_detector being builtin rather than module
Date: Wed, 13 Jan 2016 15:59:45 +0100
Message-ID: <1452697187-14894-2-git-send-email-jkacur@redhat.com>
References: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35625 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbcAMO75 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 09:59:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so37335631wmf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 06:59:56 -0800 (PST)
In-Reply-To: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Clark Williams <williams@redhat.com>

Originally the hwlat_detector was built as only a module and was
controlled by module parameters. The latest version uses debugfs
control files so there is no real need to force it to be a module.

The hwlatdetector script in rt-tests assumes that the hwlat_detector
code was built as a module. This patch adds logic to detect and
handle if hwlat_detector is a builtin.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index dbf3f674faba..2a1c562c2188 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -108,6 +108,14 @@ class Kmod(object):
     ''' class to manage loading and unloading hwlat.ko'''
 
     names = ("hwlat_detector", "smi_detector")
+    def __check_builtin(self):
+        for l in open(os.path.join('/lib/modules', os.uname()[2], 'modules.builtin'), "r"):
+            for m in Kmod.names:
+                if m in l:
+                    debug("found %s as builtin" % m)
+                    return m
+        return None
+
     def __find_modname(self):
         debug("looking for modules")
         path = os.path.join("/lib/modules",
@@ -123,6 +131,15 @@ class Kmod(object):
 
     def __init__(self):
         self.preloaded = False
+        self.builtin = False
+
+        # check for builtin
+        self.modname = self.__check_builtin()
+        if self.modname:
+            self.builtin = True
+            return
+
+        # now look for module
         f = open ('/proc/modules')
         for l in f:
             field = l.split()
@@ -136,6 +153,9 @@ class Kmod(object):
         self.modname = self.__find_modname()
 
     def load(self):
+        if self.builtin:
+            debug("not loading %s (builtin)" % self.modname)
+            return True
         if self.preloaded:
             debug("not loading %s (already loaded)" % self.modname)
             return True
@@ -143,7 +163,7 @@ class Kmod(object):
         return (subprocess.call(cmd) == 0)
 
     def unload(self):
-        if self.preloaded:
+        if self.preloaded or self.builtin:
             debug("Not unloading %s" % self.modname)
             return True
         cmd = ['/sbin/modprobe', '-r', self.modname]
-- 
2.4.3

