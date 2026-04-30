Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F67369203
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577532; cv=none; b=S7QKvpJgiwu9xnNxs3+tw1exfmTINOQENJFENVlRt5x1Ejx7+sakyEfKsz9uEyzm01ZpGlYcPEHXJfXXVgn/05tPEH00MXxFZttm4gSQTHCgEKUF4KqX7cTLYhWWS1MZQwL8wCojqdVgOu4vlLr0/3m/D3KC6l+IPN14/GZozbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577532; c=relaxed/simple;
	bh=po5fiZZ1GgJqN4mcIpzh7rr87XSlOfAtdllzOLJBWrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6Zvzb4ZbiZ0bilH1253038m635zA9Rk+8gmRnYmWzQ3li+hWM7kJ7+NpaQgEyJDEky0I1xNZx9Ii8qILkV6GV+5tQ0/eTqrmFPDOTW7xVe6In0gXFES/eUuPTU6ZsBYpq12BRgywEZvMr/QTIxImh0GLAf41MAZIj0y4OUkOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zou0g5od; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zou0g5od"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506362ac5f7so9209671cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577530; x=1778182330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qK7lYpR59l7Ij64eTD8VxLcbja+WjPGPU7kEN9DGBk=;
        b=Zou0g5odnuqckLAS9eetpHApU/J+zrHKC8qTK9MmZHZVWIMu12/4gouFjm6zwiIxiB
         aWfSRqBPg12f4msmW0yr+HYrNL3lRArvKEoml6G4TgX0wdOJn6GXWzbVKGhc2uBadJBj
         8GDE2axT+XYVnW7PIUh/4RX+I5p9/5+BgnawT0vzk2ROJxeMJvdUibk2aKLdFK1ecCDB
         HvqY75M26wUynOHtLf1IX0REuc6kL1CQ2gtI1jKCw0RnIcrPvUdwkg1nV1Q6+RZF7wDO
         p2WRIGO9ZZZwrZZrvz3jfOo/N6XN4+T3U7SNK+5XHwcmdbrSRlU0j51HyDQ6ftIFvxMM
         qdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577530; x=1778182330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qK7lYpR59l7Ij64eTD8VxLcbja+WjPGPU7kEN9DGBk=;
        b=EYNpU7jHlLZRpg25VVwUsWkT6HXrGPFnaZv5qpYX21zLsjEVpzWyLxGH8/iZnEqutx
         Gy90UQka67zCZXQ4pvfj45emJlLjl66gUBcnLet3Z8Sy2zkRlSb2LcXitj2U/7dCrvoJ
         tH0IGySvNaSawUzzGKfnX9hFqornik45iEASE7hSi54PkEAKsTdDR+M1ce8D6FvRDBO1
         JJnHEo3Dd6xhlEKr3XkTpPnPdIuIKjVIp+GpxoAlHIRKb1rw8s0XJ5BwTrS4V/Iks4Vk
         GMeMjoboRG4RDsHjErOjTGm9MgQ+koLHQphBsGcVJbEfBmBCkRjjKDZAw59JoSV1ahl2
         oVuQ==
X-Gm-Message-State: AOJu0YxvASfx1rnjIfdQw59aHQ1cHw/zAp9yqa4FlNwdPQqlNYLxbWg7
	J2nxX+g6EZHvk93eXFlpv6JrC1M/jwBnqt6ujv+P4hyTnsqd+xcCPDQFo0zYvw==
X-Gm-Gg: AeBDieusTpNKpCoCziMLMlZ62HULm2VOLLqwa6sU/dmq52MXo3cbVG/FJJoAtLFPRpj
	/FA21XdFzxyBCrSV2oYTcJ5za4e5SK89WPvOhSkr7IiBUYEKvXlQZ6w1OHRMJlZLTASvySSZJQ/
	Uwmgk7WABEbi1BTzBeauJTED6/rniPOuAONPnBjaralwaOoisPxsJ4qqJuG2GajhSy+TikAcs/6
	I0gleNSDM4he7djB4C1TO6A7H1z43M/mMQdHAdjjvnXhebQ5o16h7hnkHXrsC4+CWZGJ++V1Yo5
	bNFWsmPTF26MyN8OinJqmr7q5omJ/RNGEDHTLJvxk5NfvH6DsXB3w/TDBvBQaxdtWQsdVlFSCik
	qIpYJkJajPkuhNFMmfeCZqLyt+rENH5YzJFmjF/shMsd7A13w+adEbjOHAUKyotvMMraSGgzasf
	zG4Chn2n5qBFPqGAksGGuUHVhX7z5tEvUpunx2Kzq2GpV1TAO5FatPhvot2xfkxNKstoxs9pcnG
	pKc9WnMh1NIBZzJQFI4P9H0RRl6X24Q+o9GtQs/
X-Received: by 2002:ac8:5993:0:b0:50d:89f0:9a00 with SMTP id d75a77b69052e-5102ae57b19mr60468611cf.42.1777577529535;
        Thu, 30 Apr 2026 12:32:09 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/7] rteval: Add --cleanup-cpusets flag to remove leftover cpusets
Date: Thu, 30 Apr 2026 15:31:39 -0400
Message-ID: <20260430193144.354599-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new command-line flag --cleanup-cpusets that removes any
leftover rteval cpusets from previous runs and exits. This is useful
when rteval was killed and didn't clean up properly, or when users
want to manually clean up without starting a new rteval run.

The cleanup function already existed and runs automatically at
startup when using --cpusets, but this flag makes it available
as a standalone utility command.

Changes:
- rteval-cmd: Add --cleanup-cpusets argument and early handler
- rteval/cpusetmanager.py: Change log level to INFO for "no cpusets
  found" message so users get feedback when running --cleanup-cpusets

Example usage:
  sudo ./rteval-cmd --cleanup-cpusets

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd              | 11 +++++++++++
 rteval/cpusetmanager.py |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index 57f360dc95b0..eddbe9c97008 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -122,6 +122,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--cpusets", dest="rteval___cpusets",
                       action="store_true", default=False,
                       help="use cgroup v2 cpusets to isolate measurement, load, and housekeeping workloads")
+    parser.add_argument("--cleanup-cpusets", dest="rteval___cleanup_cpusets",
+                      action="store_true", default=False,
+                      help="remove any leftover rteval cpusets from previous runs and exit")
     parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
                       action="store_true", default=rtevcfg.sysreport,
                       help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
@@ -167,6 +170,14 @@ def parse_options(cfg, parser, cmdargs):
         print(f"rteval version {RTEVAL_VERSION}")
         sys.exit(0)
 
+    if cmd_opts.rteval___cleanup_cpusets:
+        from rteval.cpusetmanager import CpusetManager
+        from rteval.Log import Log
+        logger = Log()
+        logger.SetLogVerbosity(Log.INFO)
+        CpusetManager.cleanup_leftover_cpusets(logger)
+        sys.exit(0)
+
     if cmd_opts.rteval___duration:
         mult = 1.0
         v = cmd_opts.rteval___duration.lower()
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index d015e0130d54..55f57580d5fa 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -41,7 +41,7 @@ class CpusetManager:
         """
         cpuset_dirs = glob.glob('/sys/fs/cgroup/rteval_*/')
         if not cpuset_dirs:
-            logger.log(Log.DEBUG, "No leftover rteval cpusets found")
+            logger.log(Log.INFO, "No leftover rteval cpusets found")
             return
 
         logger.log(Log.INFO, f"Cleaning up {len(cpuset_dirs)} leftover rteval cpusets from previous run")
-- 
2.54.0

