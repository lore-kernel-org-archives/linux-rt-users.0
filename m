Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC97376494
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796017; cv=none; b=f5uu9BATngqvtedRgdgulxLrtnsTn0BF4aQgFj9d9RwLyWQHnO+GKafxRYRCGVM27iC4DHET6NoQU497OdI5CfJ3Yv3Lv3ht5PSh2vkArYoxQYhEnRWtMdfWGcBehRccLZDlsOLtJLd8vefQHG60ZWaG3vx24X03juI/YQKO2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796017; c=relaxed/simple;
	bh=5wcVI5/2EQnBre1ism3k/ZYKfglph3JyDKZBzI5SYSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0l1Mo4YpBfLFsA+Et6whVzbDjpTkdv87rwTyKlprRYylLN3P0toBglXTEqIVQU4y0aTWEKS4wVrdFcG8LX/ONnORbjajogqUKHg038t8rFNj+9L+26+T2pEGiCOLvexZ4BQkQYwJfDtEEzHj/ZjHXkIaIaLKNV+ZMsLSnD0/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsJrbe3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsJrbe3"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef5776530bso37666685a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796001; x=1777400801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f4uT2D/PBnXHN3ZlovF9hlIb+iViMZ+M3pqCCGkJtc=;
        b=iIsJrbe37RFY7fjFINEJddVDzbwG4sN9VQmYUj5yB5NtX7tLxvcL7SqvPzaAD7vsXm
         Q79hyX0bIbqxWbEXG8zMs/3aBuCILX+Tmyhh6riIUOb2K1oo6jbgIN9dwiCsmqn6A/hU
         eOy3aE40AyiGAOAFgEC/yOryddQfzsmmeKoVUDrgNCbsRKtm89HsPvMdSantXcRyVC4U
         X6XVuTavynTiaDrUDG5Nwh6FizME87kkiot/J6gdQHyIscLQPerkhiIoHxEmiPpCIWTC
         /0U/+5st3XYqnjExHIF7/wVO9WJye22QH1SoN1EQKmrJaF4IeSP4ITzkGD0m0wcwvGeM
         Qs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796001; x=1777400801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2f4uT2D/PBnXHN3ZlovF9hlIb+iViMZ+M3pqCCGkJtc=;
        b=eaJFAgUI+r/g6Ap0ukHea04V2gXHszV/7iWfKH/U5brgyAvcJziRL01QYLy3P36SoF
         +FPOK8x0qQOp7T4kh+1YBLCQ6Dsxuwrs8ehBn9YLpp4kc0cLYkntSa1bbRowuHBl4V4j
         5nuIfoTuBQ78B8GHnx8xO9WV8O3AasW99KVketOt/q/+esYMnsFHAoIebHvXXPkiXzKA
         9B4LXdTRgddzkpBz/3hVWE6QzQU2JM3wpBAaMkRz683D2r1FbQ09wbRYozCHJnMKIyQ4
         03wfUdO8f55gcPXU9ZKofDpPmh+g2yqWf/zoVosOO2oYzQ7PlaNydAc9H3jP01n0HTMO
         QsTw==
X-Gm-Message-State: AOJu0YwgA0Qt/GCoErupXhCSDysn0Z5FO/qbDHhSIDFFlgEqvVzruF8o
	RO2r338xz9zv5NeyPlnLfvlNLBM/Yh+naQ9rfI7LlZGeC1/jYRzCxfe3q5S2Cw==
X-Gm-Gg: AeBDies53XQKaAwvNaLA/f6WDtSy30BkDddtx6rfpj6S5FV5Sci4OlvG8Ren/YYBHp2
	ku7nPlIGtME0heIROoJkuUCATQ4IaMwfxTxn9ABDkPR53hGcsqk7zRxvOBlaw0qoTxR1MjHfnTP
	nvhmusxerfNFfdnzIirv0k2fepntXZwP0ywOAzUaZEfHjeD/GRxK4ZpDBNVjSjYv27A7WHIfcIX
	a3qOYHfu4cc1FYRixi3J4T/khN8xKcUBlxV+Xb5lngaMZ63cvLvXLChaEPspF2NWjRuvkmSK/Rf
	ZVgON4UuL1CcalzeaXmfiOFM/ehgTo2DrT7W3v+jfpk0OnS9n64VmcY5+l4eQClIam+UAuU0l9k
	5dzSEmkpF92LgeVfxAicPNlui1ULyR3hubUaRLQB7PYohS9vwgq439OpBiQv4ZNSRe9+U3OkiOD
	diRN+LG7JaWM3jy61NVR/R9jatirUZHa3QoLeH9GRyFF2NtMzx82pgID2PMcijo4Ju7/D3XJLdn
	K850JXJnk6IYtCAmKLpwmLURVPEkx7FxYheA2wfNJZ5Dt2ALhphPpmv6JlSA3ZyuG7PZ7PNwlhm
	J9cnFH/cQq0hI7sA6Wg=
X-Received: by 2002:a05:620a:284a:b0:8db:7315:7072 with SMTP id af79cd13be357-8e792b59324mr2646261885a.60.1776796001276;
        Tue, 21 Apr 2026 11:26:41 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/7] rteval: Add --warn-non-isolated-core-sharing option for measurement vs load warnings
Date: Tue, 21 Apr 2026 14:26:17 -0400
Message-ID: <20260421182618.261347-7-jkacur@redhat.com>
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

Add a new command-line flag --warn-non-isolated-core-sharing that enables
warnings when measurement and load CPUs share physical cores even when
neither CPU is isolated.

By default, rteval only warns about core sharing when at least one of the
sharing CPUs is isolated (via isolcpus). This is the most critical case
because isolated CPUs are explicitly intended for dedicated workloads, and
sharing cores defeats the isolation.

However, even when CPUs are not isolated, running measurement and load
threads on sibling CPUs sharing a physical core can still impact
measurement accuracy due to shared execution resources (L1/L2 caches,
execution units, TLB, etc.). This new flag allows users to detect this
situation when they want stricter validation.

The flag only affects measurement vs load checking. Housekeeping vs
measurement and housekeeping vs load continue to warn only when at least
one CPU is isolated, as housekeeping tasks are expected to run on
non-isolated CPUs.

Example usage:
  rteval --measurement-cpulist 4 --loads-cpulist 12 \
         --warn-non-isolated-core-sharing

  Warning: Measurement CPU 4 shares core with load CPU 12

Implementation:
- rteval-cmd: Add --warn-non-isolated-core-sharing argument
- systopology.py: Add warn_non_isolated parameter to validate_core_sharing()
- check_pair(): Add check_type parameter to distinguish measurement_vs_load
  from other combinations and apply different warning logic

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd            |  6 +++++-
 rteval/systopology.py | 23 ++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index b3f9fac2c2cf..3180e1a7857a 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -116,6 +116,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--housekeeping", dest="rteval___housekeeping",
                       type=str, default="", metavar="CPULIST",
                       help="isolated CPUs reserved for system tasks (not used by rteval)")
+    parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
+                      action="store_true", default=False,
+                      help="warn about measurement and load CPUs sharing cores even when neither is isolated")
     parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
                       action="store_true", default=rtevcfg.sysreport,
                       help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
@@ -449,7 +452,8 @@ if __name__ == '__main__':
         # Validate core sharing between housekeeping, measurement, and load CPUs
         msrcfg_cpus = CpuList(msrcfg.cpulist).cpus if msrcfg.cpulist else []
         ldcfg_cpus = CpuList(ldcfg.cpulist).cpus if ldcfg.cpulist else []
-        core_warnings = validate_core_sharing(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
+        core_warnings = validate_core_sharing(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus,
+                                              cmd_opts.rteval___warn_non_isolated_core_sharing)
         for warning in core_warnings:
             logger.log(Log.WARN, warning)
 
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 0ee81d5c5e36..0e4eb5fe7b89 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -294,7 +294,7 @@ def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
     return result
 
 
-def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus):
+def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus, warn_non_isolated=False):
     """
     Check for CPUs sharing physical cores across different workload types.
     Warns if isolated CPUs share cores between housekeeping, measurement, and load groups.
@@ -302,6 +302,7 @@ def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus):
     :param housekeeping_cpus: List of housekeeping CPU integers
     :param measurement_cpus: List of measurement CPU integers
     :param load_cpus: List of load CPU integers
+    :param warn_non_isolated: If True, also warn about measurement vs load sharing even when neither is isolated
     :return: List of warning messages (empty if no issues)
     """
     from rteval.sysinfo.coresiblings import CoreSiblings
@@ -318,14 +319,22 @@ def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus):
         # If we can't read topology, skip validation
         return warnings
 
-    def check_pair(cpu1, cpu2, type1, type2):
+    def check_pair(cpu1, cpu2, type1, type2, check_type):
         """Check if two CPUs share a core and generate warning if at least one is isolated"""
         if cs.share_core(cpu1, cpu2):
             cpu1_isol = cpu1 in isolated_cpus
             cpu2_isol = cpu2 in isolated_cpus
 
-            # Only warn if at least one CPU is isolated
-            if cpu1_isol or cpu2_isol:
+            # Determine if we should warn based on check_type
+            should_warn = False
+            if check_type == "measurement_vs_load" and warn_non_isolated:
+                # For measurement vs load with flag set: warn if neither is isolated
+                should_warn = not cpu1_isol and not cpu2_isol
+            else:
+                # For all other cases: only warn if at least one CPU is isolated
+                should_warn = cpu1_isol or cpu2_isol
+
+            if should_warn:
                 cpu1_str = f"{type1} CPU {cpu1}{' (isol)' if cpu1_isol else ''}"
                 cpu2_str = f"{type2} CPU {cpu2}{' (isol)' if cpu2_isol else ''}"
                 warnings.append(f"Warning: {cpu1_str} shares core with {cpu2_str}")
@@ -334,17 +343,17 @@ def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus):
     # 1. Housekeeping vs Measurement
     for hk_cpu in housekeeping_cpus:
         for msr_cpu in measurement_cpus:
-            check_pair(hk_cpu, msr_cpu, "Housekeeping", "measurement")
+            check_pair(hk_cpu, msr_cpu, "Housekeeping", "measurement", "housekeeping_vs_measurement")
 
     # 2. Housekeeping vs Load
     for hk_cpu in housekeeping_cpus:
         for ld_cpu in load_cpus:
-            check_pair(hk_cpu, ld_cpu, "Housekeeping", "load")
+            check_pair(hk_cpu, ld_cpu, "Housekeeping", "load", "housekeeping_vs_load")
 
     # 3. Measurement vs Load
     for msr_cpu in measurement_cpus:
         for ld_cpu in load_cpus:
-            check_pair(msr_cpu, ld_cpu, "Measurement", "load")
+            check_pair(msr_cpu, ld_cpu, "Measurement", "load", "measurement_vs_load")
 
     return warnings
 
-- 
2.53.0

