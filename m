Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBD3E486
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey1p/uhQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F10134
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699964303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXoIRRX8Q6RWMgHTI/C+T2R2K754m6EG1aHVxMn/9Lk=;
	b=Ey1p/uhQU/2g7UnIvOHWV9VcYxvHWMtwBkhyHS5n9VC6i9BbQxodPxw+w76V6Sz087ncvU
	z3WQ4XpFoaKZSSazd0HGjxb00p9IiO7nhVLE9LcIzRHcMs5IOeDbt5wlEeOHtXzkSfWEBN
	rg0eLQuZflbqdaY8/xF4r9EvYmyAoso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-mQVcyD-vMXy3Y8qo0G5Big-1; Tue, 14 Nov 2023 07:18:21 -0500
X-MC-Unique: mQVcyD-vMXy3Y8qo0G5Big-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C67A101A529
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7D6025C0;
	Tue, 14 Nov 2023 12:18:20 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/3] rteval: Refactor collapse_cpulist in systopology
Date: Tue, 14 Nov 2023 13:18:06 +0100
Message-ID: <20231114121808.154654-2-tglozar@redhat.com>
In-Reply-To: <20231114121808.154654-1-tglozar@redhat.com>
References: <20231114121808.154654-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Tomas Glozar <tglozar@redhat.com>

Instead of having duplicate code in two functions, one top-level and
one member function of CpuList, have only one static function in
CpuList.

Additionally re-write the implementation to use a more straight forward
one-pass algorithm.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd                               |  4 +-
 rteval/modules/loads/__init__.py         |  4 +-
 rteval/modules/measurement/__init__.py   |  4 +-
 rteval/modules/measurement/cyclictest.py |  6 +--
 rteval/systopology.py                    | 68 ++++++++----------------
 5 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 6f613a3..7c41429 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -30,7 +30,7 @@ from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import CpuList, SysTopology, collapse_cpulist
+from rteval.systopology import CpuList, SysTopology
 from rteval.modules.loads.kcompile import ModuleParameters
 
 compress_cpulist = CpuList.compress_cpulist
@@ -211,7 +211,7 @@ def remove_offline(cpulist):
     """ return cpulist in collapsed compressed form with only online cpus """
     tmplist = expand_cpulist(cpulist)
     tmplist = SysTopology().online_cpulist(tmplist)
-    return collapse_cpulist(tmplist)
+    return CpuList.collapse_cpulist(tmplist)
 
 
 if __name__ == '__main__':
diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index aca0c9f..13fba1e 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -11,7 +11,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
-from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
+from rteval.systopology import CpuList, SysTopology as SysTop
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -120,7 +120,7 @@ class LoadModules(RtEvalModules):
             cpulist = CpuList(cpulist).cpulist
         else:
             cpulist = SysTop().default_cpus()
-        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
+        rep_n.newProp("loadcpus", CpuList.collapse_cpulist(cpulist))
 
         return rep_n
 
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 2a0556b..41b8022 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -5,7 +5,7 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
+from rteval.systopology import CpuList, SysTopology as SysTop
 
 class MeasurementProfile(RtEvalModules):
     """Keeps and controls all the measurement modules with the same measurement profile"""
@@ -187,7 +187,7 @@ measurement profiles, based on their characteristics"""
             cpulist = CpuList(cpulist).cpulist
         else:
             cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
-        rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
+        rep_n.newProp("measurecpus", CpuList.collapse_cpulist(cpulist))
 
         for mp in self.__measureprofiles:
             mprep_n = mp.MakeReport()
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 0af1d31..d865d57 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -17,7 +17,7 @@ import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo
-from rteval.systopology import CpuList, SysTopology, collapse_cpulist
+from rteval.systopology import CpuList, SysTopology
 
 expand_cpulist = CpuList.expand_cpulist
 
@@ -203,7 +203,7 @@ class Cyclictest(rtevalModulePrototype):
             # Only include online cpus
             self.__cpus = CpuList(self.__cpus).cpulist
             # Reset cpulist from the newly calculated self.__cpus
-            self.__cpulist = collapse_cpulist(self.__cpus)
+            self.__cpulist = CpuList.collapse_cpulist(self.__cpus)
             self.__cpus = [str(c) for c in self.__cpus]
             self.__sparse = True
             if self.__run_on_isolcpus:
@@ -220,7 +220,7 @@ class Cyclictest(rtevalModulePrototype):
             self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
             if self.__run_on_isolcpus:
                 self.__sparse = True
-                self.__cpulist = collapse_cpulist(self.__cpus)
+                self.__cpulist = CpuList.collapse_cpulist(self.__cpus)
 
         # Sort the list of cpus to align with the order reported by cyclictest
         self.__cpus.sort(key=int)
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 62ad355..ea8e242 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -10,25 +10,6 @@ import os
 import os.path
 import glob
 
-# Utility version of collapse_cpulist that doesn't require a CpuList object
-def collapse_cpulist(cpulist):
-    """ Collapse a list of cpu numbers into a string range
-        of cpus (e.g. 0-5, 7, 9) """
-    if len(cpulist) == 0:
-        return ""
-    idx = CpuList.longest_sequence(cpulist)
-    if idx == 0:
-        seq = str(cpulist[0])
-    else:
-        if idx == 1:
-            seq = f"{cpulist[0]},{cpulist[idx]}"
-        else:
-            seq = f"{cpulist[0]}-{cpulist[idx]}"
-
-    rest = collapse_cpulist(cpulist[idx+1:])
-    if rest == "":
-        return seq
-    return ",".join((seq, rest))
 
 def sysread(path, obj):
     """ Helper function for reading system files """
@@ -93,7 +74,7 @@ class CpuList:
         self.cpulist.sort()
 
     def __str__(self):
-        return self.__collapse_cpulist(self.cpulist)
+        return self.collapse_cpulist(self.cpulist)
 
     def __contains__(self, cpu):
         return cpu in self.cpulist
@@ -114,35 +95,28 @@ class CpuList:
         return os.path.exists(os.path.join(CpuList.cpupath, "isolated"))
 
     @staticmethod
-    def longest_sequence(cpulist):
-        """ return index of last element of a sequence that steps by one """
-        lim = len(cpulist)
-        for idx, _ in enumerate(cpulist):
-            if idx+1 == lim:
-                break
-            if int(cpulist[idx+1]) != (int(cpulist[idx])+1):
-                return idx
-        return lim - 1
-
-    def __collapse_cpulist(self, cpulist):
-        """ Collapse a list of cpu numbers into a string range
+    def collapse_cpulist(cpulist):
+        """
+        Collapse a list of cpu numbers into a string range
         of cpus (e.g. 0-5, 7, 9)
         """
-        if len(cpulist) == 0:
-            return ""
-        idx = self.longest_sequence(cpulist)
-        if idx == 0:
-            seq = str(cpulist[0])
-        else:
-            if idx == 1:
-                seq = f"{cpulist[0]},{cpulist[idx]}"
+        cur_range = [None, None]
+        result = []
+        for cpu in cpulist + [None]:
+            if cur_range[0] is None:
+                cur_range[0] = cur_range[1] = cpu
+                continue
+            if cpu is not None and cpu == cur_range[1] + 1:
+                # Extend currently processed range
+                cur_range[1] += 1
             else:
-                seq = f"{cpulist[0]}-{cpulist[idx]}"
-
-        rest = self.__collapse_cpulist(cpulist[idx+1:])
-        if rest == "":
-            return seq
-        return ",".join((seq, rest))
+                # Range processing finished, add range to string
+                result.append(f"{cur_range[0]}-{cur_range[1]}"
+                              if cur_range[0] != cur_range[1]
+                              else str(cur_range[0]))
+                # Reset
+                cur_range[0] = cur_range[1] = cpu
+        return ",".join(result)
 
     @staticmethod
     def compress_cpulist(cpulist):
@@ -428,7 +402,7 @@ if __name__ == "__main__":
 
         onlcpus = s.online_cpus()
         print(f'onlcpus = {onlcpus}')
-        onlcpus = collapse_cpulist(onlcpus)
+        onlcpus = CpuList.collapse_cpulist(onlcpus)
         print(f'onlcpus = {onlcpus}')
 
         onlcpus_str = s.online_cpus_str()
-- 
2.41.0

