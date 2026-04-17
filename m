Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129C346E74
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455501; cv=none; b=ffmaFXQEU5XhM/ro6CsCjFRX9hJWX1GvFqs2c/hs11G8ZhFxUoLfqV5T2gqDSwScNOA5VvUG/5WUy/pwYINq36YYAa8yjr4PA4eAO2sVo8cIqhCNzCw0bTOcAarRTd2h6mr3CQEGEFxQh/zMdCd+/f0/NAUS3X1gZ756oOtlwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455501; c=relaxed/simple;
	bh=1lBbFnwgnvefWsM/Tj2++Yn8s+J+C+Ik1L7VN1LOsqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9Cdztv3KzpUelZLlDte8CBHybSWBaZsmioKHz54ILtkDZz1KC2jOsQ5Q429qY+I382XvAtDBQLMq1tmpt2dkNaBZuBbpMUUr3cK+9LwtgfAaZAhcAtFsqU1Jmr/d98u/USgDEH7qPW6s9F2QJyC1NFfTeZpL0S+6F4lIV9ywn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDQi3yr5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDQi3yr5"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ac9ef74131so15549026d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455499; x=1777060299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwfs3o8TqDPjCf9GTPIOVCkKR0gkVPpPg4+t1wuhmJk=;
        b=ZDQi3yr5qWo9fsJn2aVNnngXd9CbBJXbkTQhSJ44pzUT2jdJvLttS46CdF58OP2jCE
         xLGs+owwD6lyqKMrcRiCZPnTEnv6V9wT446ZQzCqyPDwyB7CngI67KYg4fDILQR+3uiq
         n9k0oBfpkjxdxJMzGi37GVrerK/RAGuMdx1b+xaSjeHnoCLt30aV6Ww7AuR4Lx9G9X/L
         Sy6oM2rhoJrHrWzvHqgNbAk/wMIV4LHjD4eBixl8LqCuYF75kn2PGEH50/QHcQEOfPat
         zuWyiMXi/IsVn6TD3g1r8lLNJjMrxOfK8H8kURt8mWj/A5IFjisuLwLb6V46+v95KcYF
         0hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455499; x=1777060299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwfs3o8TqDPjCf9GTPIOVCkKR0gkVPpPg4+t1wuhmJk=;
        b=LeD4uKotp9ggbiTemPNecPkzcrkf4uUDKjSHAlSCrXGu+Dg7hlEL92ghuxaOzv99hA
         0QxsuohkRygoScYLsaeUClBsrKvzubHqLkTANlRarPc9OJfwp+w3UG0Zln4BDkZsUAW0
         stnyg/XLZ2f3KA24goQga8TS9tDzLWpdBwq6CLjFGGL81UF5RATCnDx34PNcGj89jfKN
         x36e2iid10WaV3hmtqSSHeRx0QZTLC9EdCo2uytx9iGuJsl1ehGRql5TuojKfTiH++H3
         x1Y87Ah18Ic4hKFo6DjuUgH4oRa5TCW2yiVORxFaixKtEbbz2zI5mDJN1ct5zUZyYsJi
         J+2g==
X-Gm-Message-State: AOJu0YxW6IqFK5s+pgJVDplNoOrp2b9fOX5PdI5VkcZPEzfg03lnZIzE
	7w5e2KAdFXVNUH4VzM+oH68nvnMtY6gif8ySCMw7Ae/cH8XFPOqXdR5tIGBGBw==
X-Gm-Gg: AeBDievcvSHCVXseh42wOQ7gCl5FNShUHg9Q9qnZ9Nvjz+/lr+owA5XkE5F3nYww0GF
	WlEpa7+1tcpeWpLPUBpGeW8YgANOEca7lbLM/vrmmbK5TBg8ik4aqLvMoKmAWaBsy6HAGDzm9gK
	YnIhjAyXOBvQ0snyF/JR9kJsy3pUZT48i9aVz8iVcgQcgANdd4lcXRy0nVTIQ8fJIx67/+ASx3X
	jQRjs5C+q45Ot78InHAfZAoqZpYk4b4WrjnQPhRgQ6eBX3FbRgPdx+GvqA7afQgDIVlM1nekvzh
	QDlMLACx521xjXo0JzBp9hgmhElPNQnECDGPs7vtahb0DmIqkcCRSiQZ1zcsyK3oSL/+1vly6NG
	N4ANWe6J1nwfzoObfyN0wAcJeK8fyxg1GyaYewYmVlb/K6OW+TaJCUcBYqQBaeqD6DSjtG/Zbyt
	I10qYwaKSysydYGW7hqeHc+roTAMvM11LiOjoymnm7w09FWpw7J4eNq8fvvGb5vs2BxtFywi2Xc
	ppm0dE+QEcqkqILtZRJoUEBWId9sQ==
X-Received: by 2002:a05:622a:22a1:b0:50d:8c8f:f94d with SMTP id d75a77b69052e-50e36c74311mr62094381cf.52.1776455498726;
        Fri, 17 Apr 2026 12:51:38 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:38 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/6] rteval: Add --housekeeping option to reserve isolated CPUs
Date: Fri, 17 Apr 2026 15:51:13 -0400
Message-ID: <20260417195113.177799-7-jkacur@redhat.com>
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

Add a new --housekeeping option that allows users to specify isolated CPUs
that should be reserved for system housekeeping tasks and not used by
rteval's measurement or load modules.

Key features:
- Validates that housekeeping CPUs are in the isolated CPU list (isolcpus)
- Detects conflicts with explicitly specified --measurement-cpulist or
  --loads-cpulist options and exits with a clear error message
- Filters housekeeping CPUs from both measurement and load CPU lists
- Correctly excludes housekeeping CPUs from inverted CPU lists when only
  one of measurement/loads is specified

Example usage:
  rteval --housekeeping 0-3 --measurement-run-on-isolcpus
    Reserves isolcpus 0-3 for system tasks, runs measurements on
    remaining isolated CPUs (4+) plus non-isolated CPUs

Implementation:
- systopology.py: Add validate_housekeeping_cpus() function to validate
  that housekeeping CPUs are in isolcpus
- rteval-cmd: Add --housekeeping argument, conflict checking, filtering,
  and fix inversion logic to exclude housekeeping CPUs

This feature is purely additive and does not change existing behavior
when --housekeeping is not specified.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd            | 46 ++++++++++++++++++++++++++++++++++++++++++-
 rteval/systopology.py | 24 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index 0ad90cf29ec4..a903b537c891 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -31,7 +31,7 @@ from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval import cpupower
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import SysTopology, parse_cpulist_from_config
+from rteval.systopology import SysTopology, parse_cpulist_from_config, validate_housekeeping_cpus
 from rteval.modules.loads.kcompile import ModuleParameters
 from rteval.cpulist_utils import CpuList, is_relative, collapse_cpulist
 
@@ -113,6 +113,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-i", "--installdir", dest="rteval___installdir",
                       type=str, default=rtevcfg.installdir, metavar="DIRECTORY",
                       help=f"place to locate installed templates (default: {rtevcfg.installdir})")
+    parser.add_argument("--housekeeping", dest="rteval___housekeeping",
+                      type=str, default="", metavar="CPULIST",
+                      help="isolated CPUs reserved for system tasks (not used by rteval)")
     parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
                       action="store_true", default=rtevcfg.sysreport,
                       help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
@@ -370,6 +373,13 @@ if __name__ == '__main__':
 
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
+
+        # Validate and process housekeeping CPUs
+        housekeeping_cpus = []
+        if rtevcfg.housekeeping:
+            housekeeping_cpus = validate_housekeeping_cpus(rtevcfg.housekeeping)
+            logger.log(Log.DEBUG, f"housekeeping cpulist: {collapse_cpulist(housekeeping_cpus)}")
+
         # Remember if cpulists were explicitly set by the user before running
         # parse_cpulist_from_config, which generates default value for them
         msrcfg_cpulist_present = msrcfg.cpulist != ""
@@ -382,17 +392,51 @@ if __name__ == '__main__':
         msrcfg.cpulist = collapse_cpulist(cpulist)
         cpulist = parse_cpulist_from_config(ldcfg.cpulist)
         ldcfg.cpulist = collapse_cpulist(cpulist)
+
+        # Check for conflicts between housekeeping and measurement/load cpulists
+        if housekeeping_cpus:
+            msrcfg_cpus = CpuList(msrcfg.cpulist).cpus if msrcfg.cpulist else []
+            ldcfg_cpus = CpuList(ldcfg.cpulist).cpus if ldcfg.cpulist else []
+
+            # Check measurement conflicts
+            if msrcfg_cpulist_present:
+                conflicts = [cpu for cpu in housekeeping_cpus if cpu in msrcfg_cpus]
+                if conflicts:
+                    raise RuntimeError(
+                        f"Housekeeping CPUs {collapse_cpulist(conflicts)} conflict with "
+                        f"--measurement-cpulist {msrcfg.cpulist}"
+                    )
+
+            # Check load conflicts
+            if ldcfg_cpulist_present:
+                conflicts = [cpu for cpu in housekeeping_cpus if cpu in ldcfg_cpus]
+                if conflicts:
+                    raise RuntimeError(
+                        f"Housekeeping CPUs {collapse_cpulist(conflicts)} conflict with "
+                        f"--loads-cpulist {ldcfg.cpulist}"
+                    )
+
+            # Filter out housekeeping CPUs from measurement and load lists
+            msrcfg_cpus = [cpu for cpu in msrcfg_cpus if cpu not in housekeeping_cpus]
+            ldcfg_cpus = [cpu for cpu in ldcfg_cpus if cpu not in housekeeping_cpus]
+            msrcfg.cpulist = collapse_cpulist(msrcfg_cpus) if msrcfg_cpus else ""
+            ldcfg.cpulist = collapse_cpulist(ldcfg_cpus) if ldcfg_cpus else ""
+
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
         if not ldcfg_cpulist_present and msrcfg_cpulist_present:
             tmplist = CpuList(msrcfg.cpulist).cpus
             tmplist = SysTopology().invert_cpulist(tmplist)
             tmplist = CpuList(tmplist).online().cpus
+            # Exclude housekeeping CPUs from the inverted list
+            tmplist = [cpu for cpu in tmplist if cpu not in housekeeping_cpus]
             ldcfg.cpulist = collapse_cpulist(tmplist)
         if not msrcfg_cpulist_present and ldcfg_cpulist_present:
             tmplist = CpuList(ldcfg.cpulist).cpus
             tmplist = SysTopology().invert_cpulist(tmplist)
             tmplist = CpuList(tmplist).online().cpus
+            # Exclude housekeeping CPUs from the inverted list
+            tmplist = [cpu for cpu in tmplist if cpu not in housekeeping_cpus]
             msrcfg.cpulist = collapse_cpulist(tmplist)
 
         if ldcfg_cpulist_present:
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 7305fc278995..5f2bc291f608 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -239,6 +239,30 @@ class SysTopology:
         return [c for c in self.online_cpus() if c in cpulist]
 
 
+def validate_housekeeping_cpus(housekeeping_cpulist):
+    """
+    Validates that housekeeping CPUs are in isolated CPU list
+    :param housekeeping_cpulist: CPU list string for housekeeping CPUs
+    :return: Sorted list of validated housekeeping CPUs as integers
+    :raises: RuntimeError if housekeeping CPUs are not in isolcpus
+    """
+    if not housekeeping_cpulist:
+        return []
+
+    housekeeping = CpuList(housekeeping_cpulist).online().cpus
+    isolcpus = SysTopology().isolated_cpus()
+
+    # Check if all housekeeping CPUs are in isolcpus
+    not_isolated = [cpu for cpu in housekeeping if cpu not in isolcpus]
+    if not_isolated:
+        isolcpus_str = collapse_cpulist(isolcpus) if isolcpus else "none"
+        raise RuntimeError(
+            f"Housekeeping CPUs {collapse_cpulist(not_isolated)} are not in isolated CPUs [{isolcpus_str}]"
+        )
+
+    return sorted(housekeeping)
+
+
 def parse_cpulist_from_config(cpulist, run_on_isolcpus=False):
     """
     Generates a cpulist based on --*-cpulist argument given by user
-- 
2.53.0

