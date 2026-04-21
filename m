Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339435E925
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796013; cv=none; b=aD6UC71f6DSSnmwG6WHYc1+2aMwc0uPjtHBMEXu+Q1pvy378zMF+mwaZPeIfMkTwulSPiU71PS/24Rb6tqLftgpKff73TyFXctgfTAJgabROP8QbK0Uf5sWngOPlCwK6Skz99AHDlm/FNQEccfdyC1ulH3sUk7P2dBTwfQf6EGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796013; c=relaxed/simple;
	bh=H92eTLeA3Xj0ZDjxaeH6Ufy9WPrBfxAOO9+0nDllR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4hbPIhPA7OxcUFFA8bNDWYcE0vIumkUBQGPmYDfCRot+NiFNbwgbClRraR8SVyNAMBj3iHNW89PBvpNcjsFyFQu3st7KnMqWMmLRvhvGIYZcAxqA1Pd5A2wgVePhfoSWOC931I4/JdrjvVk453HBqQhSBaX1UUvs2fJUdT1q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqTmXa/x; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqTmXa/x"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d67a483d3eso507529585a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795996; x=1777400796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsYCWi56sUhGsX7jgWcV7DGj3wbi2YRDqi4paVv5m6c=;
        b=TqTmXa/xu8qh/a59aHeYYCkmVVBofJOB+nfQtCBtBHL9XX2DJcaijg2haTDAeiFJ2H
         8w3Guc1/btBFY8eDjXTPnpNeRo3i8pC45nZ3K9rRpTgC7gjEhY7HfzHG1gxC9cYGWR3l
         g/aPhw2YSx2U8EgazouMGYfrvt6NGlVUMrI+1q5akXnoXFkpJwslrcFy8cdWx6Y1vvyO
         YiebtVrPXPMnW3rp6qmRr8fVAH+nLIVw8ZyAE7LQALmt+yBNKR7G1s/yKduakXdyI+uy
         0ZFZIRkR/1+EHKsOXQIYFbA4i4AOtB9dbZLxTx7kExXtn61VIGx2WveJCezGQS7LWnQe
         qZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795996; x=1777400796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsYCWi56sUhGsX7jgWcV7DGj3wbi2YRDqi4paVv5m6c=;
        b=CFiTDwQl9dkCd9T55HUm7+JC+4F4fz0EDOwgfT4WMha+koKyEftMrsDhX6R/W8c4oZ
         Jo4YCK1eOf1n9tYjvdb8IzN+HB3n+MP1j8LWj9dYWee8tSDACiQ4+Jzd3vSGrWMgPt9X
         gxXeBHCYOfN4R8yXtph9Af9j+tT6CgKCG0eb3nAHUtZGJ21BeRhykUR/xhExRA1bC4aN
         rn2D46k194ASsZGZbn84/Ehw1Ba9nLr9OEn4fZxiCF7WdCFjuMYUGJrv0mLJe47pgTs6
         AsI+MZmJDcwYHkQzqmALyidNx9oO+LzFiVnW6Df+yvH+B6UjtQgI3oekCf9mvhELvL/Z
         66pQ==
X-Gm-Message-State: AOJu0Yw+7TMI3/wgWDkDI2Z1FZzzjah5BQwMtjJnMnEyKiDCgPv4MLIe
	60NncO6I2jt1OQ0zG6GUvP1pzpL5gNo4VPHdBlDqu4vOZ5AgNmyHMabZT73cog==
X-Gm-Gg: AeBDievCdiz9Pd9E+3pZJRFXoIqWb2c+Fpf39T8KZq+7lAIZxgcrATAQYnp4n/I4Ci1
	0NRrN1vf/DT/256tfiR9ey71URCCIs4fa3necJraC6ZhCNQZrvAby11aZhhXKLo9X7nL7Dltyhz
	QUFgHwdOcc1WYeoN+XDs9d88ERQ3Ox7Q3F15U0FKJi2XjpOytZipG5KcPXSOT2AptFjvNwlgy5M
	05p4ft/v8cVwJNXWdNs6UAteI5FMEJdBImGWccJEkpad4GcMrJoUQ6e1iBDtxs2DAP9lRZjd+Yn
	p8MOPumBj2FnDhvvJWFTUJ78qUT0GqthRUopL1aj/UQe+BxQtTsmr23/XRE4FHX0Mohn98SmEHF
	T4OURWZociym+T+MDpp4XULZKNCMmW8qKuFaEBhxCWgz3fv2wvxHZE1RULIOil6GAkedzCBgbqf
	tm0JtEIYwn3ewtQZ+0xU4sNCl0QUv5n8EdZHdlJhcfNUpyEOFMDDljIM3r0jQMKV3Kds3WxX3QN
	CzuV602qCyzAocIMXfzB3RuFS7qrgkkrEc/wkWDSzcwO2HwZkkaXeD55dXmcSl7DdxStkRGAR3k
	CJStW9Qf7xBQgLQPQMs=
X-Received: by 2002:a05:620a:2903:b0:8d0:891:34d0 with SMTP id af79cd13be357-8e792f4ac59mr2609100185a.60.1776795995901;
        Tue, 21 Apr 2026 11:26:35 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/7] rteval: Add core sharing validation for CPU isolation
Date: Tue, 21 Apr 2026 14:26:13 -0400
Message-ID: <20260421182618.261347-3-jkacur@redhat.com>
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

Add validation to detect and warn when CPUs sharing physical cores are
assigned to different workload types (housekeeping, measurement, load).

When SMT/hyperthreading is enabled, CPUs sharing a physical core also
share L1/L2 caches, execution units, TLB, and other core-level resources.
Running different workload types on sibling threads defeats CPU isolation
and can corrupt real-time measurements or create unreproducible results.

Key features:
- Uses CoreSiblings class to detect which CPUs share physical cores
- Only warns when at least one CPU in a pair is isolated (via isolcpus)
- Checks all three workload type combinations:
  * Housekeeping vs Measurement
  * Housekeeping vs Load
  * Measurement vs Load
- Warning format clearly indicates which CPUs are isolated with "(isol)"
  marker

Example warning:
  Warning: Housekeeping CPU 0 (isol) shares core with measurement CPU 8 (isol)

Implementation:
- coresiblings.py: Add comment explaining SMT-enabled/disabled behavior
- systopology.py: Add validate_core_sharing() function
- rteval-cmd: Call validation after CPU lists are finalized and log warnings

This validation is purely informational - it warns users but does not
prevent execution, allowing users to make informed decisions about their
CPU configurations.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                     |  8 ++++-
 rteval/sysinfo/coresiblings.py |  8 ++++-
 rteval/systopology.py          | 55 ++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index a903b537c891..f0efb0117726 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -31,7 +31,7 @@ from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval import cpupower
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import SysTopology, parse_cpulist_from_config, validate_housekeeping_cpus
+from rteval.systopology import SysTopology, parse_cpulist_from_config, validate_housekeeping_cpus, validate_core_sharing
 from rteval.modules.loads.kcompile import ModuleParameters
 from rteval.cpulist_utils import CpuList, is_relative, collapse_cpulist
 
@@ -446,6 +446,12 @@ if __name__ == '__main__':
             logger.log(Log.DEBUG, f"measurement cpulist: {msrcfg.cpulist}")
         logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
+        # Validate core sharing between housekeeping, measurement, and load CPUs
+        if housekeeping_cpus or msrcfg_cpus or ldcfg_cpus:
+            core_warnings = validate_core_sharing(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
+            for warning in core_warnings:
+                logger.log(Log.WARN, warning)
+
         # if --summarize was specified then just parse the XML, print it and exit
         if cmd_opts.rteval___summarize:
             for xmlfile in cmd_opts.rteval___summarize:
diff --git a/rteval/sysinfo/coresiblings.py b/rteval/sysinfo/coresiblings.py
index 3c97439d0a39..d55a4b699149 100644
--- a/rteval/sysinfo/coresiblings.py
+++ b/rteval/sysinfo/coresiblings.py
@@ -8,7 +8,13 @@ import os
 from rteval.cpulist_utils import expand_cpulist
 
 class CoreSiblings:
-    """Query CPU core topology to determine which CPUs share physical cores"""
+    """
+    Query CPU core topology to determine which CPUs share physical cores
+
+    Note: This class works correctly whether SMT/hyperthreading is enabled or disabled.
+    When SMT is disabled, each CPU's thread_siblings_list contains only itself,
+    so the class will correctly report that no CPUs share cores.
+    """
 
     def __init__(self, root="/"):
         self.sysdir = os.path.join(root, 'sys', 'devices', 'system', 'cpu')
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 5f2bc291f608..0ee81d5c5e36 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -294,6 +294,61 @@ def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
     return result
 
 
+def validate_core_sharing(housekeeping_cpus, measurement_cpus, load_cpus):
+    """
+    Check for CPUs sharing physical cores across different workload types.
+    Warns if isolated CPUs share cores between housekeeping, measurement, and load groups.
+
+    :param housekeeping_cpus: List of housekeeping CPU integers
+    :param measurement_cpus: List of measurement CPU integers
+    :param load_cpus: List of load CPU integers
+    :return: List of warning messages (empty if no issues)
+    """
+    from rteval.sysinfo.coresiblings import CoreSiblings
+
+    warnings = []
+
+    # Get isolated CPUs
+    isolated_cpus = set(SysTopology().isolated_cpus())
+
+    # Create CoreSiblings instance
+    try:
+        cs = CoreSiblings()
+    except Exception:
+        # If we can't read topology, skip validation
+        return warnings
+
+    def check_pair(cpu1, cpu2, type1, type2):
+        """Check if two CPUs share a core and generate warning if at least one is isolated"""
+        if cs.share_core(cpu1, cpu2):
+            cpu1_isol = cpu1 in isolated_cpus
+            cpu2_isol = cpu2 in isolated_cpus
+
+            # Only warn if at least one CPU is isolated
+            if cpu1_isol or cpu2_isol:
+                cpu1_str = f"{type1} CPU {cpu1}{' (isol)' if cpu1_isol else ''}"
+                cpu2_str = f"{type2} CPU {cpu2}{' (isol)' if cpu2_isol else ''}"
+                warnings.append(f"Warning: {cpu1_str} shares core with {cpu2_str}")
+
+    # Check all three combinations
+    # 1. Housekeeping vs Measurement
+    for hk_cpu in housekeeping_cpus:
+        for msr_cpu in measurement_cpus:
+            check_pair(hk_cpu, msr_cpu, "Housekeeping", "measurement")
+
+    # 2. Housekeeping vs Load
+    for hk_cpu in housekeeping_cpus:
+        for ld_cpu in load_cpus:
+            check_pair(hk_cpu, ld_cpu, "Housekeeping", "load")
+
+    # 3. Measurement vs Load
+    for msr_cpu in measurement_cpus:
+        for ld_cpu in load_cpus:
+            check_pair(msr_cpu, ld_cpu, "Measurement", "load")
+
+    return warnings
+
+
 if __name__ == "__main__":
 
     def unit_test():
-- 
2.53.0

