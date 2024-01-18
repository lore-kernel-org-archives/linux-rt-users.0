Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289D1CAB6
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jan 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569512; cv=none; b=K36agv1uyxnbe7vU5uoDOflvAZ6t/uVkbztZ42hBHRYXCPQt0/WpjUkaCGuc4Y6F1ayB3WbAzEpm1ZvaTNSTM3FCK+0IC84izVR9//6ESmALx58VHgUIzAdXBYC75vjG7aE2Y+5ciQNAw68toT2KgeLoaJraqQKytkVkA2ur1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569512; c=relaxed/simple;
	bh=FAWN0bcf/7fr68MxYBIXWjHrrY9AEtOTfvzt/bw5F7s=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=WuRHv2SWEzpMaenFS7LvhaBO0UZDA602123gZathjh51f46MJ21cMGbaNpWSlh7kK0O0ZK6LNW35pqfmGply90VSchvxVjTCDhEVjnMPbG9Ayxr3EeQBEjaU2xPVHXh6De7xHftLdysaM5zwpE4j7kiOj2nU51uoPeCFeWK/OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bi+8jvcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi+8jvcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705569509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SHHGNShriv5Q8D1DN63Ilu/nQ0tcSSOybEv1KZPtU8=;
	b=bi+8jvcpxg4+5BRTi83WZ9rGzpUkB17hvNLJtUs6KrZjBabSQoU1Mls75PqXIHq7a1NRk2
	P4sieF8vS4Cx2fjStBHUVSTzHUu36mbuJJcS0MN5UGgxV6UNzHmB13DAXSwNxttpfwBu7e
	/HLZCtXUL0RdUDMNg6a651Q9ijUmG/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-1xAUXNjQNJOS774qn-XJMw-1; Thu, 18 Jan 2024 04:18:21 -0500
X-MC-Unique: 1xAUXNjQNJOS774qn-XJMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C11E185A782
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jan 2024 09:18:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B6A41C05E0E;
	Thu, 18 Jan 2024 09:18:20 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 2/2] rteval: Add relative cpulists for measurements
Date: Thu, 18 Jan 2024 10:18:10 +0100
Message-ID: <20240118091810.127396-3-tglozar@redhat.com>
In-Reply-To: <20240118091810.127396-1-tglozar@redhat.com>
References: <20240118091810.127396-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Tomas Glozar <tglozar@redhat.com>

Instead of specifying an absolute list of CPUs to run measurements on
in --measurement-cpulist, implement an option to specify a relative list
with respect to the current cpuset of rteval.

The relative cpulist can include CPUs both for addition and for removal,
e.g. +0,1,-7,8.

Also move the logic for processing cpulists specified by the user as
a string into cpulists usable by rteval to a single function.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd                               | 26 +++++++-----
 rteval/cpulist_utils.py                  | 33 ++++++++++++++++
 rteval/modules/measurement/__init__.py   |  9 +----
 rteval/modules/measurement/cyclictest.py | 50 +++---------------------
 rteval/systopology.py                    | 33 ++++++++++++++++
 5 files changed, 90 insertions(+), 61 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index d224728..a5e8746 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -30,7 +30,7 @@ from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import SysTopology
+from rteval.systopology import SysTopology, parse_cpulist_from_config
 from rteval.modules.loads.kcompile import ModuleParameters
 import rteval.cpulist_utils as cpulist_utils
 
@@ -339,26 +339,32 @@ if __name__ == '__main__':
 
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
-        if ldcfg.cpulist and msrcfg.cpulist:
+        msrcfg_cpulist_present = msrcfg.cpulist != ""
+        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
+        # and relative cpusets
+        cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
+        if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
+            logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
+        msrcfg.cpulist = collapse_cpulist(cpulist)
+        if ldcfg.cpulist:
             ldcfg.cpulist = remove_offline(ldcfg.cpulist)
-            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
-        if not ldcfg.cpulist and msrcfg.cpulist:
+        if not ldcfg.cpulist and msrcfg_cpulist_present:
             tmplist = expand_cpulist(msrcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
-            ldcfg.cpulist = compress_cpulist(tmplist)
-            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
-        if not msrcfg.cpulist and ldcfg.cpulist:
+            tmplist = cpulist_utils.online_cpulist(tmplist)
+            ldcfg.cpulist = collapse_cpulist(tmplist)
+        if not msrcfg_cpulist_present and ldcfg.cpulist:
             tmplist = expand_cpulist(ldcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
-            msrcfg.cpulist = compress_cpulist(tmplist)
-            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
+            tmplist = cpulist_utils.online_cpulist(tmplist)
+            msrcfg.cpulist = collapse_cpulist(tmplist)
 
         if ldcfg.cpulist:
             logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
         # if --onlyload is specified msrcfg.cpulist is unused
-        if msrcfg.cpulist and not rtevcfg.onlyload:
+        if msrcfg_cpulist_present and not rtevcfg.onlyload:
             logger.log(Log.DEBUG, f"measurement cpulist: {msrcfg.cpulist}")
         logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
diff --git a/rteval/cpulist_utils.py b/rteval/cpulist_utils.py
index 402d579..7abc45a 100644
--- a/rteval/cpulist_utils.py
+++ b/rteval/cpulist_utils.py
@@ -126,3 +126,36 @@ def nonisolated_cpulist(cpulist):
     isolated_cpulist = sysread(cpupath, "isolated")
     isolated_cpulist = expand_cpulist(isolated_cpulist)
     return list(set(cpulist).difference(set(isolated_cpulist)))
+
+
+def is_relative(cpulist):
+    return cpulist.startswith("+") or cpulist.startswith("-")
+
+
+def expand_relative_cpulist(cpulist):
+    """
+    Expand a relative cpulist into a tuple of lists.
+    :param cpulist: Relative cpulist of form +1,2,3,-4,5,6
+    :return: Tuple of two lists, one for added CPUs, one for removed CPUs
+    """
+    added_cpus = []
+    removed_cpus = []
+
+    if not cpulist:
+        return added_cpus, removed_cpus
+
+    cpus = None
+
+    for part in cpulist.split(','):
+        if part.startswith('+') or part.startswith('-'):
+            cpus = added_cpus if part[0] == '+' else removed_cpus
+            part = part[1:]
+        if '-' in part:
+            a, b = part.split('-')
+            a, b = int(a), int(b)
+            cpus.extend(list(range(a, b + 1)))
+        else:
+            a = int(part)
+            cpus.append(a)
+
+    return list(set(added_cpus)), list(set(removed_cpus))
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 66dc9c5..11bd7b0 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -5,7 +5,7 @@
 
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
-from rteval.systopology import SysTopology as SysTop
+from rteval.systopology import parse_cpulist_from_config
 import rteval.cpulist_utils as cpulist_utils
 
 class MeasurementProfile(RtEvalModules):
@@ -183,12 +183,7 @@ measurement profiles, based on their characteristics"""
         rep_n = libxml2.newNode("Measurements")
         cpulist = self.__cfg.GetSection("measurement").cpulist
         run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
-        if cpulist:
-            # Convert str to list and remove offline cpus
-            cpulist = cpulist_utils.expand_cpulist(cpulist)
-            cpulist = cpulist_utils.online_cpulist(cpulist)
-        else:
-            cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
+        cpulist = parse_cpulist_from_config(cpulist, run_on_isolcpus)
         rep_n.newProp("measurecpus", cpulist_utils.collapse_cpulist(cpulist))
 
         for mp in self.__measureprofiles:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index fdca257..7224225 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -16,8 +16,7 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.systopology import cpuinfo
-from rteval.systopology import SysTopology
+from rteval.systopology import cpuinfo, parse_cpulist_from_config
 import rteval.cpulist_utils as cpulist_utils
 
 expand_cpulist = cpulist_utils.expand_cpulist
@@ -193,39 +192,9 @@ class Cyclictest(rtevalModulePrototype):
         self.__priority = int(self.__cfg.setdefault('priority', 95))
         self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
         self.__numcores = 0
-        self.__cpus = []
         self.__cyclicdata = {}
-        self.__sparse = False
-        self.__run_on_isolcpus = bool(self.__cfg.setdefault('run-on-isolcpus', False))
-
-        if self.__cfg.cpulist:
-            self.__cpulist = self.__cfg.cpulist
-            self.__cpus = expand_cpulist(self.__cpulist)
-            # Only include online cpus
-            self.__cpus = cpulist_utils.online_cpulist(self.__cpus)
-            # Reset cpulist from the newly calculated self.__cpus
-            self.__cpulist = cpulist_utils.collapse_cpulist(self.__cpus)
-            self.__cpus = [str(c) for c in self.__cpus]
-            self.__sparse = True
-            if self.__run_on_isolcpus:
-                self._log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
-        else:
-            self.__cpus = SysTopology().online_cpus_str()
-            # Get the cpuset from the environment
-            cpuset = os.sched_getaffinity(0)
-            # Convert the elements to strings
-            cpuset = [str(c) for c in cpuset]
-            # Get isolated CPU list
-            isolcpus = [str(c) for c in SysTopology().isolated_cpus()]
-            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
-            self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
-            if self.__run_on_isolcpus:
-                self.__sparse = True
-                self.__cpulist = cpulist_utils.collapse_cpulist([int(c) for c in self.__cpus])
-
-        # Sort the list of cpus to align with the order reported by cyclictest
-        self.__cpus.sort(key=int)
-
+        self.__cpulist = self.__cfg.cpulist
+        self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
         self.__numcores = len(self.__cpus)
 
         info = cpuinfo()
@@ -242,10 +211,7 @@ class Cyclictest(rtevalModulePrototype):
                                               logfnc=self._log)
         self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
 
-        if self.__sparse:
-            self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
-        else:
-            self._log(Log.DEBUG, f"system has {self.__numcores} cpu cores")
+        self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
         self.__started = False
         self.__cyclicoutput = None
         self.__breaktraceval = None
@@ -280,12 +246,8 @@ class Cyclictest(rtevalModulePrototype):
                       f'-h {self.__buckets}',
                       f"-p{int(self.__priority)}",
                       ]
-        if self.__sparse:
-            self.__cmd.append(f'-t{self.__numcores}')
-            self.__cmd.append(f'-a{self.__cpulist}')
-        else:
-            self.__cmd.append('-t')
-            self.__cmd.append('-a')
+        self.__cmd.append(f'-t{self.__numcores}')
+        self.__cmd.append(f'-a{self.__cpulist}')
 
         if 'threads' in self.__cfg and self.__cfg.threads:
             self.__cmd.append(f"-t{int(self.__cfg.threads)}")
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 9e45762..6bcfc77 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -241,6 +241,39 @@ class SysTopology:
         """ return a list of online cpus in cpulist """
         return [c for c in self.online_cpus() if c in cpulist]
 
+
+def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
+    """
+    Generates a cpulist based on --*-cpulist argument given by user
+    :param cpulist: Value of --*-cpulist argument
+    :param run_on_isolcpus: Value of --*-run-on-isolcpus argument
+    :return: Sorted list of CPUs as integers
+    """
+    if cpulist and not cpulist_utils.is_relative(cpulist):
+        result = cpulist_utils.expand_cpulist(cpulist)
+        # Only include online cpus
+        result = cpulist_utils.online_cpulist(result)
+    else:
+        result = SysTopology().online_cpus()
+        # Get the cpuset from the environment
+        cpuset = os.sched_getaffinity(0)
+        # Get isolated CPU list
+        isolcpus = SysTopology().isolated_cpus()
+        if cpulist and cpulist_utils.is_relative(cpulist):
+            # Include cpus that are not removed in relative cpuset and are either in cpuset from affinity,
+            # isolcpus (with run_on_isolcpus enabled, or added by relative cpuset
+            added_cpus, removed_cpus = cpulist_utils.expand_relative_cpulist(cpulist)
+            result = [c for c in result
+                      if (c in cpuset or
+                          c in added_cpus or
+                          run_on_isolcpus and c in isolcpus) and
+                      c not in removed_cpus]
+        else:
+            # Only include cpus that are in the cpuset and isolated CPUs if run_on_isolcpus is enabled
+            result = [c for c in result if c in cpuset or run_on_isolcpus and c in isolcpus]
+    return result
+
+
 if __name__ == "__main__":
 
     def unit_test():
-- 
2.43.0

