Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD62264D6
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455499; cv=none; b=iQ5XN+wpTh4ATYEGAAabqPOBO1fFmYGZ/YHvzPZHKqFzx2I4i3cNpIVkm+utrBymESFbVXH8xTPDp2oldhrDwjILWCD1VpY6IqwyfE0eRmLDZyEit9+uKUDsFqM8oPpBRhpX8fhlT+6ZXUzu8dcKJYpjPoQXsQotxKAkQEbnyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455499; c=relaxed/simple;
	bh=zVPQkIcxKMBdv7zUXoIsDVlr45YwDS6XC0it4A8Z1e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBPcOf3lvrTXTi7txv3AL/eqBpER7gVpgjDGZNsSxalJkUEWiIkxlKbuvWTk0/pYmxumvQI0wiMM+AfcKw5+rw/R7GuIWopjjUuwTg91VE6ILFdwpUYgpA9RO27LIEy1EU+hc+puG0Gz1Od82b+Q7kp1BZaxoDhq9rGtCd4xyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmMuB3OF; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmMuB3OF"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50baafd6c4aso12200781cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455496; x=1777060296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L979rqgWPYJQn0EKqcZ73tmjdXqDFXvbagSaLttawLE=;
        b=OmMuB3OFe7Nvil8Hql4Ga9ebeveu4Zlpdm9Q06W4odIRDJqvWfFwRkCkGHWdXWEyZY
         6BL2CvSqgTbx+8YqLuo1i1PipEGp0j+NOTzrsjhRzdIZ59Znt5JyPmHTPeGXHMoRvkEu
         CJj0P+IPO1T6AszOw1YIonXokm+sgTAoGHDBp/VJWm4WH3lMLksbEycVQuCQcbtvA1vf
         M19nfUaUJ1UhpcnyvxHnn3EiWE/Ux+PFVnM6EQXYKyPOd1elmQfoVL6JV6sBUsGYDGfK
         fAilPA28K/JzSUhMUrFkKdMlVsdbQY7mKvhIr9HU9OMOdzYfBQdIjBUjbgXDGUcjka9Z
         d4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455496; x=1777060296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L979rqgWPYJQn0EKqcZ73tmjdXqDFXvbagSaLttawLE=;
        b=cNnKEqy0HHRIGtSuL540sXGMYMKamnIRnsNflQO0qzQpx2NpiIVIZeDn7u4e50Ugqg
         EuZiyhHyY+1ie23YoK/MhOhT7LzU1k9SExwc6jKMwdfncQkJvrKhhxWXQ0tOnhMU52QE
         kaUxidI9ooInbgda7Fg1dRe5S4CiP1ff08QGig8rQ1r5tBezP5sJzDx5AE1uoxvhAvcv
         x2uCgx1MZx3nPZAPJTGZJ6AQS5qN4FbxsA796nLOdsac/MY51SDgkazuATTLQVVHBOnO
         W1HAM7Na+sdOKf/XPmzkFgZCyXE75iKlETfK6l6a40ZZrWlftjWp2cT9JldMixSnWoHq
         FFVA==
X-Gm-Message-State: AOJu0YyNPb6pr/iF1nu/bvYbNRJf5ZC6XJBNvFEJT0/H2hUkSWTh5/b+
	63qVAX3seQH1ZNQ54jS3uay2RK3q++89mh2rppGOIhSIUBQvcMUiDNBCwWDG8w==
X-Gm-Gg: AeBDiev+S8BhtJNsoO7dHSBHAFvtnIqGPK9Pta8rq71ESV1M2+gL+p5dPOFnK9RSMhh
	a6hYXvLBt3EVn6KWmNwgziXkn1OZ5JBCaEGmn5DsuBGn54ophoJd557wOWQmt9kT6y5qnsC937U
	R1AXcGHfF2+Q1jwDj7TwpdhUq1Gu5kkNbfWfUcmYYubx4ENc5foYuCMwGk4ywtxPBCH8+DuA9d6
	055544MgDLWQi0L1kvwG3McQW1O4d7kEjCWkYv5V6inkmIOX1wJEDDobhw+olzwXMmoAMbKZx03
	/qkJRXZuh4dvx0rKmKonHmN6QIA4tu8ej/lOohRzEongOidb20mURENfEjPVxeyeyZKJfVCesPl
	4VSqOEPVPv2emv1CNZNpesE2092C44tf7Z7aos6fmGicDmaQlqINi4n0JnXZN4kqw1MH3CxD9if
	u9TNnNnCIZImhCRoJMRYQayvKgiXXyDfrN1Q5QeHarmWL3L8OgKjlj5DQ7QYXFzxjMPUC53UXgX
	Zv2alnxpULNfIXOBCM2T0G/Xtg+6Q==
X-Received: by 2002:ac8:5850:0:b0:50d:7cd4:4a6d with SMTP id d75a77b69052e-50e36eede11mr63787011cf.49.1776455496405;
        Fri, 17 Apr 2026 12:51:36 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/6] rteval: Migrate call sites to use CpuList class where beneficial
Date: Fri, 17 Apr 2026 15:51:11 -0400
Message-ID: <20260417195113.177799-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417195113.177799-1-jkacur@redhat.com>
References: <20260417195113.177799-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate cpulist_utils usage to use a hybrid approach:
- Use CpuList class when doing operations (chaining, filtering)
- Use module functions for simple formatting (collapse_cpulist)

This pragmatic approach uses object-oriented design where it adds
value (chaining operations, filtering) and functional programming
where it's simpler (formatting output).

Changes:
- Use CpuList(...).online().cpus for filtering operations
- Use collapse_cpulist() instead of str(CpuList()) for formatting
- Use CpuList(...).cpus for expanding CPU lists
- Simplified imports to only what's needed

Files updated:
- rteval-cmd: Main command interface
- rteval/systopology.py: NumaNode, SimNumaNode, SysTopology classes
- rteval/modules/loads/__init__.py: Load modules base
- rteval/modules/loads/hackbench.py: Hackbench load
- rteval/modules/loads/kcompile.py: Kernel compile load
- rteval/modules/loads/stressng.py: Stress-ng load
- rteval/modules/measurement/__init__.py: Measurement modules base
- rteval/cpupower.py: CPU power management

All existing tests pass. Module-level functions remain for backward
compatibility and for simple use cases.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                             | 16 ++++++---------
 rteval/cpupower.py                     |  4 ++--
 rteval/modules/loads/__init__.py       |  7 +++----
 rteval/modules/loads/hackbench.py      |  9 +++------
 rteval/modules/loads/kcompile.py       | 14 +++++--------
 rteval/modules/loads/stressng.py       |  8 +++-----
 rteval/modules/measurement/__init__.py |  6 +++---
 rteval/systopology.py                  | 28 +++++++++++---------------
 8 files changed, 37 insertions(+), 55 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 45d9f3a58a11..0ad90cf29ec4 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -33,11 +33,7 @@ from rteval import cpupower
 from rteval.version import RTEVAL_VERSION
 from rteval.systopology import SysTopology, parse_cpulist_from_config
 from rteval.modules.loads.kcompile import ModuleParameters
-import rteval.cpulist_utils as cpulist_utils
-
-compress_cpulist = cpulist_utils.compress_cpulist
-expand_cpulist = cpulist_utils.expand_cpulist
-collapse_cpulist = cpulist_utils.collapse_cpulist
+from rteval.cpulist_utils import CpuList, is_relative, collapse_cpulist
 
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
@@ -381,7 +377,7 @@ if __name__ == '__main__':
         # Parse cpulists using parse_cpulist_from_config to account for
         # run-on-isolcpus and relative cpusets
         cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
-        if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
+        if msrcfg_cpulist_present and not is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
             logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
         msrcfg.cpulist = collapse_cpulist(cpulist)
         cpulist = parse_cpulist_from_config(ldcfg.cpulist)
@@ -389,14 +385,14 @@ if __name__ == '__main__':
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
         if not ldcfg_cpulist_present and msrcfg_cpulist_present:
-            tmplist = expand_cpulist(msrcfg.cpulist)
+            tmplist = CpuList(msrcfg.cpulist).cpus
             tmplist = SysTopology().invert_cpulist(tmplist)
-            tmplist = cpulist_utils.online_cpulist(tmplist)
+            tmplist = CpuList(tmplist).online().cpus
             ldcfg.cpulist = collapse_cpulist(tmplist)
         if not msrcfg_cpulist_present and ldcfg_cpulist_present:
-            tmplist = expand_cpulist(ldcfg.cpulist)
+            tmplist = CpuList(ldcfg.cpulist).cpus
             tmplist = SysTopology().invert_cpulist(tmplist)
-            tmplist = cpulist_utils.online_cpulist(tmplist)
+            tmplist = CpuList(tmplist).online().cpus
             msrcfg.cpulist = collapse_cpulist(tmplist)
 
         if ldcfg_cpulist_present:
diff --git a/rteval/cpupower.py b/rteval/cpupower.py
index 37c4d33f1df4..948cd9650382 100644
--- a/rteval/cpupower.py
+++ b/rteval/cpupower.py
@@ -9,7 +9,7 @@ import shutil
 import sys
 from rteval.Log import Log
 from rteval.systopology import SysTopology as SysTop
-from rteval import cpulist_utils
+from rteval.cpulist_utils import collapse_cpulist
 
 PATH = '/sys/devices/system/cpu/'
 
@@ -113,7 +113,7 @@ if __name__ == '__main__':
     l = Log()
     l.SetLogVerbosity(Log.DEBUG)
 
-    online_cpus = cpulist_utils.collapse_cpulist(SysTop().online_cpus())
+    online_cpus = collapse_cpulist(SysTop().online_cpus())
     idlestate = '1'
     info = True
 
diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 0845742e5d29..1ed005cc4e91 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -12,7 +12,7 @@ from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
 from rteval.modules import RtEvalModules, rtevalModulePrototype
 from rteval.systopology import SysTopology as SysTop
-import rteval.cpulist_utils as cpulist_utils
+from rteval.cpulist_utils import CpuList, collapse_cpulist
 
 class LoadThread(rtevalModulePrototype):
     def __init__(self, name, config, logger=None):
@@ -118,11 +118,10 @@ class LoadModules(RtEvalModules):
         cpulist = self._cfg.GetSection(self._module_config).cpulist
         if cpulist:
             # Convert str to list and remove offline cpus
-            cpulist = cpulist_utils.expand_cpulist(cpulist)
-            cpulist = cpulist_utils.online_cpulist(cpulist)
+            cpulist = CpuList(cpulist).online().cpus
         else:
             cpulist = SysTop().default_cpus()
-        rep_n.newProp("loadcpus", cpulist_utils.collapse_cpulist(cpulist))
+        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
 
         return rep_n
 
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index a70fdb33243f..fddb85648506 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -17,10 +17,7 @@ from signal import SIGKILL
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
-import rteval.cpulist_utils as cpulist_utils
-
-expand_cpulist = cpulist_utils.expand_cpulist
-isolated_cpulist = cpulist_utils.isolated_cpulist
+from rteval.cpulist_utils import CpuList
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
@@ -59,10 +56,10 @@ class Hackbench(CommandLineLoad):
             self.cpus[n] = sysTop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in CpuList(self.cpulist).cpus]
             # if a cpulist was not specified, exclude isolated cpus
             else:
-                self.cpus[n] = cpulist_utils.nonisolated_cpulist(self.cpus[n])
+                self.cpus[n] = CpuList(self.cpus[n]).nonisolated().cpus
 
             # track largest number of cpus used on a node
             node_biggest = len(self.cpus[n])
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 404b46d505d0..c960242362d3 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -15,11 +15,7 @@ from rteval.modules import rtevalRuntimeError
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
-import rteval.cpulist_utils as cpulist_utils
-
-expand_cpulist = cpulist_utils.expand_cpulist
-compress_cpulist = cpulist_utils.compress_cpulist
-nonisolated_cpulist = cpulist_utils.nonisolated_cpulist
+from rteval.cpulist_utils import CpuList, collapse_cpulist
 
 DEFAULT_KERNEL_PREFIX = "linux-6.17.7"
 
@@ -39,7 +35,7 @@ class KBuildJob:
             os.mkdir(self.objdir)
 
         # Exclude isolated CPUs if cpulist not set
-        cpus_available = len(nonisolated_cpulist(self.node.cpus))
+        cpus_available = len(CpuList(self.node.cpus).nonisolated().cpus)
 
         if os.path.exists('/usr/bin/numactl') and not cpulist:
             # Use numactl
@@ -48,7 +44,7 @@ class KBuildJob:
         elif cpulist:
             # Use taskset
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
-            self.binder = f'taskset -c {compress_cpulist(cpulist)}'
+            self.binder = f'taskset -c {collapse_cpulist(cpulist)}'
         else:
             # Without numactl calculate number of jobs from the node
             self.jobs = self.calc_jobs_per_cpu() * cpus_available
@@ -228,7 +224,7 @@ class Kcompile(CommandLineLoad):
 
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in CpuList(self.cpulist).cpus]
 
         # remove nodes with no cpus available for running
         for node, cpus in self.cpus.items():
@@ -290,7 +286,7 @@ class Kcompile(CommandLineLoad):
 
         if 'cpulist' in self._cfg and self._cfg.cpulist:
             cpulist = self._cfg.cpulist
-            self.num_cpus = len(expand_cpulist(cpulist))
+            self.num_cpus = len(CpuList(cpulist).cpus)
         else:
             cpulist = ""
 
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 4f6abfb5eabd..4ad7197fc590 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -8,9 +8,7 @@ import signal
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
-import rteval.cpulist_utils as cpulist_utils
-
-expand_cpulist = cpulist_utils.expand_cpulist
+from rteval.cpulist_utils import CpuList
 
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
@@ -70,10 +68,10 @@ class Stressng(CommandLineLoad):
             cpus[n] = systop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                cpus[n] = [c for c in cpus[n] if c in expand_cpulist(self.cpulist)]
+                cpus[n] = [c for c in cpus[n] if c in CpuList(self.cpulist).cpus]
             # if a cpulist was not specified, exclude isolated cpus
             else:
-                cpus[n] = cpulist_utils.nonisolated_cpulist(cpus[n])
+                cpus[n] = CpuList(cpus[n]).nonisolated().cpus
 
 
         # remove nodes with no cpus available for running
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index e09dca683dbf..71c38357731d 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -6,7 +6,7 @@
 import libxml2
 from rteval.modules import RtEvalModules, ModuleContainer
 from rteval.systopology import parse_cpulist_from_config
-import rteval.cpulist_utils as cpulist_utils
+from rteval.cpulist_utils import CpuList, collapse_cpulist
 
 class MeasurementModules(RtEvalModules):
     """Module container for measurement modules"""
@@ -43,7 +43,7 @@ class MeasurementModules(RtEvalModules):
         run_on_isolcpus = modcfg.run_on_isolcpus
         if cpulist is None:
             # Get default cpulist value
-            cpulist = cpulist_utils.collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
+            cpulist = collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
 
         for (modname, modtype) in modcfg:
             if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
@@ -61,6 +61,6 @@ class MeasurementModules(RtEvalModules):
         cpulist = self._cfg.GetSection("measurement").cpulist
         run_on_isolcpus = self._cfg.GetSection("measurement").run_on_isolcpus
         cpulist = parse_cpulist_from_config(cpulist, run_on_isolcpus)
-        rep_n.newProp("measurecpus", cpulist_utils.collapse_cpulist(cpulist))
+        rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
 
         return rep_n
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 6bcfc77f2c84..7305fc278995 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -9,8 +9,7 @@
 import os
 import os.path
 import glob
-import rteval.cpulist_utils as cpulist_utils
-from rteval.cpulist_utils import sysread
+from rteval.cpulist_utils import CpuList, sysread, is_relative, expand_relative_cpulist, collapse_cpulist
 
 def cpuinfo():
     ''' return a dictionary of cpu keys with various cpu information '''
@@ -65,8 +64,7 @@ class NumaNode:
         """
         self.path = path
         self.nodeid = int(os.path.basename(path)[4:].strip())
-        self.cpus = cpulist_utils.expand_cpulist(sysread(self.path, "cpulist"))
-        self.cpus = cpulist_utils.online_cpulist(self.cpus)
+        self.cpus = CpuList(sysread(self.path, "cpulist")).online().cpus
         self.getmeminfo()
 
     def __contains__(self, cpu):
@@ -98,7 +96,7 @@ class NumaNode:
 
     def getcpustr(self):
         """ return list of cpus for this node as a string """
-        return cpulist_utils.collapse_cpulist(self.cpus)
+        return collapse_cpulist(self.cpus)
 
     def getcpulist(self):
         """ return list of cpus for this node """
@@ -115,8 +113,7 @@ class SimNumaNode(NumaNode):
 
     def __init__(self):
         self.nodeid = 0
-        self.cpus = cpulist_utils.expand_cpulist(sysread(SimNumaNode.cpupath, "possible"))
-        self.cpus = cpulist_utils.online_cpulist(self.cpus)
+        self.cpus = CpuList(sysread(SimNumaNode.cpupath, "possible")).online().cpus
         self.getmeminfo()
 
     def getmeminfo(self):
@@ -198,7 +195,7 @@ class SysTopology:
         """ return a list of integers of all online cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += cpulist_utils.online_cpulist(self.getcpus(n))
+            cpulist += CpuList(self.getcpus(n)).online().cpus
         cpulist.sort()
         return cpulist
 
@@ -206,7 +203,7 @@ class SysTopology:
         """ return a list of integers of all isolated cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += cpulist_utils.isolated_cpulist(self.getcpus(n))
+            cpulist += CpuList(self.getcpus(n)).isolated().cpus
         cpulist.sort()
         return cpulist
 
@@ -214,7 +211,7 @@ class SysTopology:
         """ return a list of integers of all default schedulable cpus, i.e. online non-isolated cpus """
         cpulist = []
         for n in self.nodes:
-            cpulist += cpulist_utils.nonisolated_cpulist(self.getcpus(n))
+            cpulist += CpuList(self.getcpus(n)).nonisolated().cpus
         cpulist.sort()
         return cpulist
 
@@ -249,20 +246,19 @@ def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
     :param run_on_isolcpus: Value of --*-run-on-isolcpus argument
     :return: Sorted list of CPUs as integers
     """
-    if cpulist and not cpulist_utils.is_relative(cpulist):
-        result = cpulist_utils.expand_cpulist(cpulist)
+    if cpulist and not is_relative(cpulist):
         # Only include online cpus
-        result = cpulist_utils.online_cpulist(result)
+        result = CpuList(cpulist).online().cpus
     else:
         result = SysTopology().online_cpus()
         # Get the cpuset from the environment
         cpuset = os.sched_getaffinity(0)
         # Get isolated CPU list
         isolcpus = SysTopology().isolated_cpus()
-        if cpulist and cpulist_utils.is_relative(cpulist):
+        if cpulist and is_relative(cpulist):
             # Include cpus that are not removed in relative cpuset and are either in cpuset from affinity,
             # isolcpus (with run_on_isolcpus enabled, or added by relative cpuset
-            added_cpus, removed_cpus = cpulist_utils.expand_relative_cpulist(cpulist)
+            added_cpus, removed_cpus = expand_relative_cpulist(cpulist)
             result = [c for c in result
                       if (c in cpuset or
                           c in added_cpus or
@@ -295,7 +291,7 @@ if __name__ == "__main__":
 
         onlcpus = s.online_cpus()
         print(f'onlcpus = {onlcpus}')
-        onlcpus = cpulist_utils.collapse_cpulist(onlcpus)
+        onlcpus = collapse_cpulist(onlcpus)
         print(f'onlcpus = {onlcpus}')
 
         onlcpus_str = s.online_cpus_str()
-- 
2.53.0

