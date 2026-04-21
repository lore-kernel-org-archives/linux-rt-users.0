Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE2374E41
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796010; cv=none; b=PLrCq0hQjyJTdwZBty90V6QeNjVIoM11Z+WEw+hUQZY8VuXuQXCNngyKNIIRCl5I0aSRLLa0aVFSusy43wmqjViS+JKTAzsun9EYpumvu/poNigi12TjQhQRmQA37WfhyMwj9I3/iYDgJDJdcY/U4vuBoberArgh8lRl8g6f/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796010; c=relaxed/simple;
	bh=OIZw7bzStauVMv6MTQbNTWbDU4sXrCPqLTj/ogBJvJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxBE5XCaEFab39t6TBvaUfIVwdpxB+f6OsksPERFcwiCfoZFNwFRLNp2m+xqZFdGfHV2fUkjXAsI7Mg7UIZ+gXKwj3ti94jn2R8mcLtN2oUqUQ7vEOREk8eT/0Wk12UEJSIBkkypXzuJPc1c0So9QRUY+Cz3Q0D4/xxcWglRV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifUd7ndb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifUd7ndb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ef45a6d9dfso45341885a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795997; x=1777400797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba09x6YrOv7SRQkdsjbPVN9fWWwC4/CxDD9A9uJAQPI=;
        b=ifUd7ndbzCEqewUhx7QeA733ELwtjGxduaeFvQtH/zRBISo+uxuYsrIxIeCsICng1b
         oAEJRSNjQYRmNyiKD95Fwf+1GqXOMReUpXSAMtgwU8ZS/i5CC4GEArD5d/01n/+ei8qW
         11hKimnFCR0x9wG8y2ZxZExfeysiCvZyB455C1R0NYhBMpcRl7muahI4/GXqSMrcKnjp
         3IQYsop1gW9Gac8zrayVApuj4IOi8ZuJWeDC46Yvss52GIqpXGQj8Mh3/123nQS0zWsj
         dZ8PhC8LS9UNJkAFmldRTOs0aELggri95XgBzKBXMfPaV/hXWzVpFeP2Org/++0EDHlD
         mu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795997; x=1777400797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba09x6YrOv7SRQkdsjbPVN9fWWwC4/CxDD9A9uJAQPI=;
        b=Rfd4/RaPGixjWTML6/M4sP5efzsyZWl8gQ0XoflaOGu+gAVufjqxzSSdPr6eHL/7nh
         vxW1BhmOm2m2jpRCwYQxMmlCPJEjUO37VnGlWcX9Ijdzz87QwXC7pZ5mgALZ7d8vH+2w
         ki+VdjUvVFtK+vOySZHfjzb/oOaurhQpVGPiZd57/6yi2DqYUSJFQVrmmT3riEZQPavW
         imI3m/QKWnQaTSiOFOP6cJPNUpK9j3Um/K24yLn68MSbvZRZ1gsmH8vtJeVdSOmmutlf
         Y8gZ1m/GsdELxZ4nrzaiPLOuCaJaoZIxxHc6eZsdxB3q0Yt++wiuqS2FrXYplNPcG3og
         xQ7Q==
X-Gm-Message-State: AOJu0Yx5Ci4D7qxqtHziFzDynM/6yLyPPe+3Ygf6+RVAPzCp3uY8Rpkz
	JxkDA92ky8KHQY4CUpvzmgxzJ/UZ8RFZkqS1LnY7FOunthKP6P4Kzm2udT24Nw==
X-Gm-Gg: AeBDiesZ7wKL2OAihYJNkOUAq7M9yx6m/Cj3451VtZW5yNJ0sAYADTisqqThneREmHc
	BS4o/hVBwxIrNqPi/yaTB+3IG9xx46Xu+OVFgk2r2CrhkeW4DOTIyJ9N/Fv+wAHdmpx/GcfOyP2
	IGWh2rEiIg5eC05faVV2gKQBTb2KEQZiWAsN8mZhsQD/DH1rRmM+EWEnUTzozC49Vs/SbY09NEB
	cW+FMwUb1PmK9OkjiefdOdwFTWhbspqAHcv10ZaMOcRSAzZppPgOncf12HmK62VRR6lHP+jQWRu
	wWXJAVzBb/QC7Cn7TTvpf4iTkkBcPLXl50zquCfONDad1BqJIrz8pq53hMjoZ5GHao6jTJ7hmvc
	Dg9k86/b5RcM45FN4/bvd6+oHe7370eTT7zXk94c3XDUsnyY447UnQqIoJEx/s9l/oURuHYOjJi
	gdC4QEnMVjKTrJQ9Ks4he8NtKuQamx+Z/uVj2gW5QgpqRqlT+BKku7JkNawqcN9N+ys1k5rPhfm
	WzGsK5LYGVmQ6MmeHAZl7c190dFWbULNtpApPaWaxF+8suKES3Dctybnm+Y5H8uDCAqJt5kLTbr
	KGZIZ6kHdSy0FZL0LoY=
X-Received: by 2002:a05:620a:4143:b0:8cd:871c:909d with SMTP id af79cd13be357-8e792276312mr2584064985a.53.1776795997321;
        Tue, 21 Apr 2026 11:26:37 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/7] rteval: Include core sharing warnings in XML report
Date: Tue, 21 Apr 2026 14:26:14 -0400
Message-ID: <20260421182618.261347-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421182618.261347-1-jkacur@redhat.com>
References: <20260421182618.261347-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add core sharing validation warnings to the CPUtopology section of the
XML report, making isolation issues part of the permanent test record.

This complements the console warnings added in the previous commit by
ensuring that core sharing conflicts are documented in the XML output,
allowing users to analyze test runs later even if they missed the
console warnings during execution.

Implementation:
- CPUtopology.add_core_sharing_warnings(): New method to add warnings
  to the CPUtopology XML node after CPU lists are finalized
- rteval-cmd: Call add_core_sharing_warnings() after RtEval object is
  created and CPU lists are available
- XML structure: CoreSharingWarnings appears at the end of CPUtopology
  node, after all CPU entries and summary properties

Note: The warnings must be added after SystemInfo initialization because
CPU lists are finalized in rteval-cmd after the config is processed,
which happens after SystemInfo is created. We call the method explicitly
once the CPU lists are known.

Example XML output:
  <CPUtopology num_cpu_cores="16" ...>
    <cpu name="cpu0" ... isolated="1"/>
    <cpu name="cpu8" ... isolated="1"/>
    ...
    <CoreSharingWarnings>
      <warning>Warning: Housekeeping CPU 0 (isol) shares core with measurement CPU 8 (isol)</warning>
    </CoreSharingWarnings>
  </CPUtopology>

The warnings use the same format as console output, clearly indicating
which CPUs are isolated with "(isol)" markers.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                    | 13 +++++++++----
 rteval/sysinfo/__init__.py    |  3 +++
 rteval/sysinfo/cputopology.py | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index f0efb0117726..b3f9fac2c2cf 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -447,10 +447,11 @@ if __name__ == '__main__':
         logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
         # Validate core sharing between housekeeping, measurement, and load CPUs
-        if housekeeping_cpus or msrcfg_cpus or ldcfg_cpus:
-            core_warnings = validate_core_sharing(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
-            for warning in core_warnings:
-                logger.log(Log.WARN, warning)
+        msrcfg_cpus = CpuList(msrcfg.cpulist).cpus if msrcfg.cpulist else []
+        ldcfg_cpus = CpuList(ldcfg.cpulist).cpus if ldcfg.cpulist else []
+        core_warnings = validate_core_sharing(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
+        for warning in core_warnings:
+            logger.log(Log.WARN, warning)
 
         # if --summarize was specified then just parse the XML, print it and exit
         if cmd_opts.rteval___summarize:
@@ -487,6 +488,10 @@ if __name__ == '__main__':
             cpupower_controller.enable_idle_state()
 
         rteval = RtEval(config, loadmods, measuremods, logger)
+
+        # Add core sharing warnings to the XML report now that CPU lists are finalized
+        rteval._sysinfo.add_core_sharing_warnings(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
+
         rteval.Prepare(rtevcfg.onlyload)
 
         if rtevcfg.onlyload:
diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index 4b7b03cda626..56a0c57b2cbc 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -35,6 +35,9 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         self.ProcessWarnings()
 
         # Parse CPU info
+        # Note: CPU lists are not available at this point (they're finalized in rteval-cmd),
+        # so we can't add core sharing warnings to the XML report yet.
+        # Console warnings are still generated in rteval-cmd.
         CPUtopology._parse(self)
 
 
diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
index db30635a0488..a21c19179f28 100644
--- a/rteval/sysinfo/cputopology.py
+++ b/rteval/sysinfo/cputopology.py
@@ -94,6 +94,39 @@ class CPUtopology:
         return self.__cputop_n
 
 
+    def add_core_sharing_warnings(self, housekeeping_cpus, measurement_cpus, load_cpus):
+        """
+        Add core sharing warnings to the CPUtopology XML node.
+        Should be called after CPU lists are finalized.
+
+        :param housekeeping_cpus: List of housekeeping CPU integers
+        :param measurement_cpus: List of measurement CPU integers
+        :param load_cpus: List of load CPU integers
+        """
+        if self.__cputop_n is None:
+            return
+
+        # Remove any existing CoreSharingWarnings section
+        existing = self.__cputop_n.xpathEval('CoreSharingWarnings')
+        if existing:
+            for node in existing:
+                node.unlinkNode()
+                node.freeNode()
+
+        # Generate new warnings
+        from rteval.systopology import validate_core_sharing
+        warnings = validate_core_sharing(
+            housekeeping_cpus or [],
+            measurement_cpus or [],
+            load_cpus or []
+        )
+
+        # Add warnings to XML if any were found
+        if warnings:
+            warnings_n = self.__cputop_n.newChild(None, 'CoreSharingWarnings', None)
+            for warning in warnings:
+                warnings_n.newChild(None, 'warning', warning)
+
     def MakeReport(self):
         return self.__cputop_n
 
-- 
2.53.0

