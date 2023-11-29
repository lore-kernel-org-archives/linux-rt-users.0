Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgYrwvl+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD11BC5
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 01:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701250628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1HpXM9YdLQUR81Dng7xIcNUM1XDDo65OgiGecpbaY8=;
	b=cgYrwvl+MtnAWkzQnzN2BJ1td1qG73S0B1vgK6D7qlmwE8TMv587euiSoZuwGHCeuLqGRD
	6uyAl2/9WurJWW0rMiSTjelJBk8JhLjH28nKyTYy6BkFHrg0OFj0Z+ZhjngvVW8/5o6cA/
	Zy2DKP5A6EGa1s1nDKghFrm7Yd7WJN8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-214SgYhNPja5OlIjpnDwOg-1; Wed,
 29 Nov 2023 04:37:05 -0500
X-MC-Unique: 214SgYhNPja5OlIjpnDwOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD2D7280CFA2
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 09:37:05 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06C0440C6EBA;
	Wed, 29 Nov 2023 09:37:04 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/4] rteval: Convert CpuList class to a module
Date: Wed, 29 Nov 2023 10:34:56 +0100
Message-ID: <20231129093457.17984-4-tglozar@redhat.com>
In-Reply-To: <20231129093457.17984-1-tglozar@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Tomas Glozar <tglozar@redhat.com>

Move out code from CpuList class in rteval.systopology into a separate
module named rteval.cpulist_utils and avoid wrapping CPU lists in
a CpuList object.

Almost all uses of CpuList in the code either use the static methods of
the class or its constructor to filter online CPUs by running
CpuList(...).cpulist. The only exception to this are NumaNode and
SimNumaNode classes in systopology; these store a CpuList object,
however their .getcpulist() method extracts the list out. Thus,
the class is completely unnecessary.

Note: A better name for the module would be cpulist, consistent with the
original name of the class, but this name is already used for variables
throughout the code, hence cpulist_utils is used instead.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd                               |  17 ++-
 rteval/cpulist_utils.py                  | 128 ++++++++++++++++++
 rteval/modules/loads/__init__.py         |   8 +-
 rteval/modules/loads/hackbench.py        |   9 +-
 rteval/modules/loads/kcompile.py         |  14 +-
 rteval/modules/loads/stressng.py         |   9 +-
 rteval/modules/measurement/__init__.py   |   8 +-
 rteval/modules/measurement/cyclictest.py |  12 +-
 rteval/systopology.py                    | 165 ++---------------------
 9 files changed, 178 insertions(+), 192 deletions(-)
 create mode 100644 rteval/cpulist_utils.py

diff --git a/rteval-cmd b/rteval-cmd
index 7c41429..56b2c95 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -30,11 +30,10 @@ from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import SysTopology
 from rteval.modules.loads.kcompile import ModuleParameters
+import rteval.cpulist_utils as cpulist_utils
 
-compress_cpulist = CpuList.compress_cpulist
-expand_cpulist = CpuList.expand_cpulist
 
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
@@ -209,9 +208,9 @@ def parse_options(cfg, parser, cmdargs):
 
 def remove_offline(cpulist):
     """ return cpulist in collapsed compressed form with only online cpus """
-    tmplist = expand_cpulist(cpulist)
+    tmplist = cpulist_utils.expand_cpulist(cpulist)
     tmplist = SysTopology().online_cpulist(tmplist)
-    return CpuList.collapse_cpulist(tmplist)
+    return cpulist_utils.collapse_cpulist(tmplist)
 
 
 if __name__ == '__main__':
@@ -343,14 +342,14 @@ if __name__ == '__main__':
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
         if not ldcfg.cpulist and msrcfg.cpulist:
-            tmplist = expand_cpulist(msrcfg.cpulist)
+            tmplist = cpulist_utils.expand_cpulist(msrcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
-            ldcfg.cpulist = compress_cpulist(tmplist)
+            ldcfg.cpulist = cpulist_utils.compress_cpulist(tmplist)
             msrcfg.cpulist = remove_offline(msrcfg.cpulist)
         if not msrcfg.cpulist and ldcfg.cpulist:
-            tmplist = expand_cpulist(ldcfg.cpulist)
+            tmplist = cpulist_utils.expand_cpulist(ldcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
-            msrcfg.cpulist = compress_cpulist(tmplist)
+            msrcfg.cpulist = cpulist_utils.compress_cpulist(tmplist)
             ldcfg.cpulist = remove_offline(ldcfg.cpulist)
 
         if ldcfg.cpulist:
diff --git a/rteval/cpulist_utils.py b/rteval/cpulist_utils.py
new file mode 100644
index 0000000..402d579
--- /dev/null
+++ b/rteval/cpulist_utils.py
@@ -0,0 +1,128 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2016 - Clark Williams <williams@redhat.com>
+#   Copyright 2021 - John Kacur <jkacur@redhat.com>
+#   Copyright 2023 - Tomas Glozar <tglozar@redhat.com>
+#
+"""Module providing utility functions for working with CPU lists"""
+
+import os
+
+
+cpupath = "/sys/devices/system/cpu"
+
+
+def sysread(path, obj):
+    """ Helper function for reading system files """
+    with open(os.path.join(path, obj), "r") as fp:
+        return fp.readline().strip()
+
+
+def _online_file_exists():
+    """ Check whether machine / kernel is configured with online file """
+    # Note: some machines do not have cpu0/online so we check cpu1/online.
+    # In the case of machines with a single CPU, there is no cpu1, but
+    # that is not a problem, since a single CPU cannot be offline
+    return os.path.exists(os.path.join(cpupath, "cpu1/online"))
+
+
+def _isolated_file_exists():
+    """ Check whether machine / kernel is configured with isolated file """
+    return os.path.exists(os.path.join(cpupath, "isolated"))
+
+
+def collapse_cpulist(cpulist):
+    """
+    Collapse a list of cpu numbers into a string range
+    of cpus (e.g. 0-5, 7, 9)
+    """
+    cur_range = [None, None]
+    result = []
+    for cpu in cpulist + [None]:
+        if cur_range[0] is None:
+            cur_range[0] = cur_range[1] = cpu
+            continue
+        if cpu is not None and cpu == cur_range[1] + 1:
+            # Extend currently processed range
+            cur_range[1] += 1
+        else:
+            # Range processing finished, add range to string
+            result.append(f"{cur_range[0]}-{cur_range[1]}"
+                          if cur_range[0] != cur_range[1]
+                          else str(cur_range[0]))
+            # Reset
+            cur_range[0] = cur_range[1] = cpu
+    return ",".join(result)
+
+
+def compress_cpulist(cpulist):
+    """ return a string representation of cpulist """
+    if not cpulist:
+        return ""
+    if isinstance(cpulist[0], int):
+        return ",".join(str(e) for e in cpulist)
+    return ",".join(cpulist)
+
+
+def expand_cpulist(cpulist):
+    """ expand a range string into an array of cpu numbers
+    don't error check against online cpus
+    """
+    result = []
+
+    if not cpulist:
+        return result
+
+    for part in cpulist.split(','):
+        if '-' in part:
+            a, b = part.split('-')
+            a, b = int(a), int(b)
+            result.extend(list(range(a, b + 1)))
+        else:
+            a = int(part)
+            result.append(a)
+    return [int(i) for i in list(set(result))]
+
+
+def is_online(n):
+    """ check whether cpu n is online """
+    path = os.path.join(cpupath, f'cpu{n}')
+
+    # Some hardware doesn't allow cpu0 to be turned off
+    if not os.path.exists(path + '/online') and n == 0:
+        return True
+
+    return sysread(path, "online") == "1"
+
+
+def online_cpulist(cpulist):
+    """ Given a cpulist, return a cpulist of online cpus """
+    # This only works if the sys online files exist
+    if not _online_file_exists():
+        return cpulist
+    newlist = []
+    for cpu in cpulist:
+        if not _online_file_exists() and cpu == '0':
+            newlist.append(cpu)
+        elif is_online(int(cpu)):
+            newlist.append(cpu)
+    return newlist
+
+
+def isolated_cpulist(cpulist):
+    """Given a cpulist, return a cpulist of isolated CPUs"""
+    if not _isolated_file_exists():
+        return cpulist
+    isolated_cpulist = sysread(cpupath, "isolated")
+    isolated_cpulist = expand_cpulist(isolated_cpulist)
+    return list(set(isolated_cpulist) & set(cpulist))
+
+
+def nonisolated_cpulist(cpulist):
+    """Given a cpulist, return a cpulist of non-isolated CPUs"""
+    if not _isolated_file_exists():
+        return cpulist
+    isolated_cpulist = sysread(cpupath, "isolated")
+    isolated_cpulist = expand_cpulist(isolated_cpulist)
+    return list(set(cpulist).difference(set(isolated_cpulist)))
diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 13fba1e..0845742 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -11,7 +11,8 @@ import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
-from rteval.systopology import CpuList, SysTopology as SysTop
+from rteval.systopology import SysTopology as SysTop
+import rteval.cpulist_utils as cpulist_utils
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -117,10 +118,11 @@ class LoadModules(RtEvalModules):
         cpulist = self._cfg.GetSection(self._module_config).cpulist
         if cpulist:
             # Convert str to list and remove offline cpus
-            cpulist = CpuList(cpulist).cpulist
+            cpulist = cpulist_utils.expand_cpulist(cpulist)
+            cpulist = cpulist_utils.online_cpulist(cpulist)
         else:
             cpulist = SysTop().default_cpus()
-        rep_n.newProp("loadcpus", CpuList.collapse_cpulist(cpulist))
+        rep_n.newProp("loadcpus", cpulist_utils.collapse_cpulist(cpulist))
 
         return rep_n
 
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index cfc7063..8df2d0a 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -16,10 +16,9 @@ import errno
 from signal import SIGKILL
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import SysTopology
+import rteval.cpulist_utils as cpulist_utils
 
-expand_cpulist = CpuList.expand_cpulist
-isolated_cpulist = CpuList.isolated_cpulist
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
@@ -58,10 +57,10 @@ class Hackbench(CommandLineLoad):
             self.cpus[n] = sysTop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in cpulist_utils.expand_cpulist(self.cpulist)]
             # if a cpulist was not specified, exclude isolated cpus
             else:
-                self.cpus[n] = CpuList.nonisolated_cpulist(self.cpus[n])
+                self.cpus[n] = cpulist_utils.nonisolated_cpulist(self.cpus[n])
 
             # track largest number of cpus used on a node
             node_biggest = len(self.cpus[n])
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 0d02577..93605e1 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -14,11 +14,9 @@ import subprocess
 from rteval.modules import rtevalRuntimeError
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import SysTopology
+import rteval.cpulist_utils as cpulist_utils
 
-expand_cpulist = CpuList.expand_cpulist
-compress_cpulist = CpuList.compress_cpulist
-nonisolated_cpulist = CpuList.nonisolated_cpulist
 
 DEFAULT_KERNEL_PREFIX = "linux-6.6"
 
@@ -38,7 +36,7 @@ class KBuildJob:
             os.mkdir(self.objdir)
 
         # Exclude isolated CPUs if cpulist not set
-        cpus_available = len(nonisolated_cpulist(self.node.cpus.cpulist))
+        cpus_available = len(cpulist_utils.nonisolated_cpulist(self.node.cpus))
 
         if os.path.exists('/usr/bin/numactl') and not cpulist:
             # Use numactl
@@ -47,7 +45,7 @@ class KBuildJob:
         elif cpulist:
             # Use taskset
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
-            self.binder = f'taskset -c {compress_cpulist(cpulist)}'
+            self.binder = f'taskset -c {cpulist_utils.compress_cpulist(cpulist)}'
         else:
             # Without numactl calculate number of jobs from the node
             self.jobs = self.calc_jobs_per_cpu() * cpus_available
@@ -220,7 +218,7 @@ class Kcompile(CommandLineLoad):
 
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in cpulist_utils.expand_cpulist(self.cpulist)]
 
         # remove nodes with no cpus available for running
         for node, cpus in self.cpus.items():
@@ -282,7 +280,7 @@ class Kcompile(CommandLineLoad):
 
         if 'cpulist' in self._cfg and self._cfg.cpulist:
             cpulist = self._cfg.cpulist
-            self.num_cpus = len(expand_cpulist(cpulist))
+            self.num_cpus = len(cpulist_utils.expand_cpulist(cpulist))
         else:
             cpulist = ""
 
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 7c9e63f..524604e 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -7,10 +7,9 @@ import subprocess
 import signal
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import SysTopology
+import rteval.cpulist_utils as cpulist_utils
 
-expand_cpulist = CpuList.expand_cpulist
-nonisolated_cpulist = CpuList.nonisolated_cpulist
 
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
@@ -70,10 +69,10 @@ class Stressng(CommandLineLoad):
             cpus[n] = systop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                cpus[n] = [c for c in cpus[n] if c in expand_cpulist(self.cpulist)]
+                cpus[n] = [c for c in cpus[n] if c in cpulist_utils.expand_cpulist(self.cpulist)]
             # if a cpulist was not specified, exclude isolated cpus
             else:
-                cpus[n] = CpuList.nonisolated_cpulist(cpus[n])
+                cpus[n] = cpulist_utils.nonisolated_cpulist(cpus[n])
 
 
         # remove nodes with no cpus available for running
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 41b8022..66dc9c5 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -5,7 +5,8 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-from rteval.systopology import CpuList, SysTopology as SysTop
+from rteval.systopology import SysTopology as SysTop
+import rteval.cpulist_utils as cpulist_utils
 
 class MeasurementProfile(RtEvalModules):
     """Keeps and controls all the measurement modules with the same measurement profile"""
@@ -184,10 +185,11 @@ measurement profiles, based on their characteristics"""
         run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
         if cpulist:
             # Convert str to list and remove offline cpus
-            cpulist = CpuList(cpulist).cpulist
+            cpulist = cpulist_utils.expand_cpulist(cpulist)
+            cpulist = cpulist_utils.online_cpulist(cpulist)
         else:
             cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
-        rep_n.newProp("measurecpus", CpuList.collapse_cpulist(cpulist))
+        rep_n.newProp("measurecpus", cpulist_utils.collapse_cpulist(cpulist))
 
         for mp in self.__measureprofiles:
             mprep_n = mp.MakeReport()
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 1b14e7e..dcfca0b 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -17,9 +17,9 @@ import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import SysTopology
+import rteval.cpulist_utils as cpulist_utils
 
-expand_cpulist = CpuList.expand_cpulist
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -199,11 +199,11 @@ class Cyclictest(rtevalModulePrototype):
 
         if self.__cfg.cpulist:
             self.__cpulist = self.__cfg.cpulist
-            self.__cpus = expand_cpulist(self.__cpulist)
+            self.__cpus = cpulist_utils.expand_cpulist(self.__cpulist)
             # Only include online cpus
-            self.__cpus = CpuList(self.__cpus).cpulist
+            self.__cpus = cpulist_utils.online_cpulist(self.__cpus)
             # Reset cpulist from the newly calculated self.__cpus
-            self.__cpulist = CpuList.collapse_cpulist(self.__cpus)
+            self.__cpulist = cpulist_utils.collapse_cpulist(self.__cpus)
             self.__cpus = [str(c) for c in self.__cpus]
             self.__sparse = True
             if self.__run_on_isolcpus:
@@ -220,7 +220,7 @@ class Cyclictest(rtevalModulePrototype):
             self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
             if self.__run_on_isolcpus:
                 self.__sparse = True
-                self.__cpulist = CpuList.collapse_cpulist([int(c) for c in self.__cpus])
+                self.__cpulist = cpulist_utils.collapse_cpulist([int(c) for c in self.__cpus])
 
         # Sort the list of cpus to align with the order reported by cyclictest
         self.__cpus.sort(key=int)
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 60ac8e8..9db1a80 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -9,12 +9,8 @@
 import os
 import os.path
 import glob
-
-
-def sysread(path, obj):
-    """ Helper function for reading system files """
-    with open(os.path.join(path, obj), "r") as fp:
-        return fp.readline().strip()
+import rteval.cpulist_utils as cpulist_utils
+from rteval.cpulist_utils import sysread
 
 def cpuinfo():
     ''' return a dictionary of cpu keys with various cpu information '''
@@ -56,145 +52,6 @@ def cpuinfo():
     return info
 
 
-#
-# class to provide access to a list of cpus
-#
-
-class CpuList:
-    "Object that represents a group of system cpus"
-
-    cpupath = '/sys/devices/system/cpu'
-
-    def __init__(self, cpulist):
-        if isinstance(cpulist, list):
-            self.cpulist = cpulist
-        elif isinstance(cpulist, str):
-            self.cpulist = self.expand_cpulist(cpulist)
-        self.cpulist = self.online_cpulist(self.cpulist)
-        self.cpulist.sort()
-
-    def __str__(self):
-        return self.collapse_cpulist(self.cpulist)
-
-    def __contains__(self, cpu):
-        return cpu in self.cpulist
-
-    def __len__(self):
-        return len(self.cpulist)
-
-    def getcpulist(self):
-        """ return the list of cpus tracked """
-        return self.cpulist
-
-    @staticmethod
-    def online_file_exists():
-        """ Check whether machine / kernel is configured with online file """
-        # Note: some machines do not have cpu0/online so we check cpu1/online.
-        # In the case of machines with a single CPU, there is no cpu1, but
-        # that is not a problem, since a single CPU cannot be offline
-        return os.path.exists(os.path.join(CpuList.cpupath, "cpu1/online"))
-
-    @staticmethod
-    def isolated_file_exists():
-        """ Check whether machine / kernel is configured with isolated file """
-        return os.path.exists(os.path.join(CpuList.cpupath, "isolated"))
-
-    @staticmethod
-    def collapse_cpulist(cpulist):
-        """
-        Collapse a list of cpu numbers into a string range
-        of cpus (e.g. 0-5, 7, 9)
-        """
-        cur_range = [None, None]
-        result = []
-        for cpu in cpulist + [None]:
-            if cur_range[0] is None:
-                cur_range[0] = cur_range[1] = cpu
-                continue
-            if cpu is not None and cpu == cur_range[1] + 1:
-                # Extend currently processed range
-                cur_range[1] += 1
-            else:
-                # Range processing finished, add range to string
-                result.append(f"{cur_range[0]}-{cur_range[1]}"
-                              if cur_range[0] != cur_range[1]
-                              else str(cur_range[0]))
-                # Reset
-                cur_range[0] = cur_range[1] = cpu
-        return ",".join(result)
-
-    @staticmethod
-    def compress_cpulist(cpulist):
-        """ return a string representation of cpulist """
-        if not cpulist:
-            return ""
-        if isinstance(cpulist[0], int):
-            return ",".join(str(e) for e in cpulist)
-        return ",".join(cpulist)
-
-    @staticmethod
-    def expand_cpulist(cpulist):
-        """ expand a range string into an array of cpu numbers
-        don't error check against online cpus
-        """
-        result = []
-
-        if not cpulist:
-            return result
-
-        for part in cpulist.split(','):
-            if '-' in part:
-                a, b = part.split('-')
-                a, b = int(a), int(b)
-                result.extend(list(range(a, b + 1)))
-            else:
-                a = int(part)
-                result.append(a)
-        return [int(i) for i in list(set(result))]
-
-    @staticmethod
-    def is_online(n):
-        """ check whether cpu n is online """
-        path = os.path.join(CpuList.cpupath, f'cpu{n}')
-
-        # Some hardware doesn't allow cpu0 to be turned off
-        if not os.path.exists(path + '/online') and n == 0:
-            return True
-
-        return sysread(path, "online") == "1"
-
-    @staticmethod
-    def online_cpulist(cpulist):
-        """ Given a cpulist, return a cpulist of online cpus """
-        # This only works if the sys online files exist
-        if not CpuList.online_file_exists():
-            return cpulist
-        newlist = []
-        for cpu in cpulist:
-            if not CpuList.online_file_exists() and cpu == '0':
-                newlist.append(cpu)
-            elif CpuList.is_online(int(cpu)):
-                newlist.append(cpu)
-        return newlist
-
-    @staticmethod
-    def isolated_cpulist(cpulist):
-        """Given a cpulist, return a cpulist of isolated CPUs"""
-        if not CpuList.isolated_file_exists():
-            return cpulist
-        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
-        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
-        return list(set(isolated_cpulist) & set(cpulist))
-
-    @staticmethod
-    def nonisolated_cpulist(cpulist):
-        """Given a cpulist, return a cpulist of non-isolated CPUs"""
-        if not CpuList.isolated_file_exists():
-            return cpulist
-        isolated_cpulist = sysread(CpuList.cpupath, "isolated")
-        isolated_cpulist = CpuList.expand_cpulist(isolated_cpulist)
-        return list(set(cpulist).difference(set(isolated_cpulist)))
-
 #
 # class to abstract access to NUMA nodes in /sys filesystem
 #
@@ -208,7 +65,8 @@ class NumaNode:
         """
         self.path = path
         self.nodeid = int(os.path.basename(path)[4:].strip())
-        self.cpus = CpuList(sysread(self.path, "cpulist"))
+        self.cpus = cpulist_utils.expand_cpulist(sysread(self.path, "cpulist"))
+        self.cpus = cpulist_utils.online_cpulist(self.cpus)
         self.getmeminfo()
 
     def __contains__(self, cpu):
@@ -240,11 +98,11 @@ class NumaNode:
 
     def getcpustr(self):
         """ return list of cpus for this node as a string """
-        return str(self.cpus)
+        return cpulist_utils.collapse_cpulist(self.cpus)
 
     def getcpulist(self):
         """ return list of cpus for this node """
-        return self.cpus.getcpulist()
+        return self.cpus
 
 class SimNumaNode(NumaNode):
     """class representing a simulated NUMA node.
@@ -257,7 +115,8 @@ class SimNumaNode(NumaNode):
 
     def __init__(self):
         self.nodeid = 0
-        self.cpus = CpuList(sysread(SimNumaNode.cpupath, "possible"))
+        self.cpus = cpulist_utils.expand_cpulist(sysread(SimNumaNode.cpupath, "possible"))
+        self.cpus = cpulist_utils.online_cpulist(self.cpus)
         self.getmeminfo()
 
     def getmeminfo(self):
@@ -339,7 +198,7 @@ class SysTopology:
         """ return a list of integers of all online cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += self.getcpus(n)
+            cpulist += cpulist_utils.online_cpulist(self.getcpus(n))
         cpulist.sort()
         return cpulist
 
@@ -347,7 +206,7 @@ class SysTopology:
         """ return a list of integers of all isolated cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += CpuList.isolated_cpulist(self.getcpus(n))
+            cpulist += cpulist_utils.isolated_cpulist(self.getcpus(n))
         cpulist.sort()
         return cpulist
 
@@ -355,7 +214,7 @@ class SysTopology:
         """ return a list of integers of all default schedulable cpus, i.e. online non-isolated cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += CpuList.nonisolated_cpulist(self.getcpus(n))
+            cpulist += cpulist_utils.nonisolated_cpulist(self.getcpus(n))
         cpulist.sort()
         return cpulist
 
@@ -403,7 +262,7 @@ if __name__ == "__main__":
 
         onlcpus = s.online_cpus()
         print(f'onlcpus = {onlcpus}')
-        onlcpus = CpuList.collapse_cpulist(onlcpus)
+        onlcpus = cpulist_utils.collapse_cpulist(onlcpus)
         print(f'onlcpus = {onlcpus}')
 
         onlcpus_str = s.online_cpus_str()
-- 
2.39.3

