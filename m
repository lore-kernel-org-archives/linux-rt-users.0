Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691D372696
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569279; cv=none; b=hNY9eZr6ELach/pigOHeY8yRvuAFj+WUL5DcQQ3lBu/3OduKIV6h7LEjVGXL1J9ORu9pk1ObCn3z4e1/3LeS2oDYVD+I63/UozC83XAnbtuJmAR1GfsXWzZ7H22SNM7/a9XhDpWnoLRcw+hvBb/ldgZCTJxHsZmrZBxKjxEd2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569279; c=relaxed/simple;
	bh=UUr+EBSl7TmD4hmod/mPo+CSlbvnR24Cnn27CnkoKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My0AAD3Og+JOPQD+yJiiojTxu1Qp1L/JRZ7xoPOpnSJiNn/W0frCDg3YW5TdGmNvyH4lhQGRugPu12L1RvNsKR92tTTYxg2Om7lePkuHLDxImygqDOH+OGkM+WLY1067zwVcD8GjOcXQrmU8IQDw3GDwUGpfHM1WMEOk/32XNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM6QqePd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM6QqePd"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ff20870ac7so8749306d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786569277; x=1787174077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HHpkgwlmS2UMlHbsPRMJ2hdAa3SecUymkFYT4F57R8=;
        b=UM6QqePdHek9g7TR02f4zT6k9DTMZGFba+uK1xHGdrAo6m746L2p5bXK9A5UiTyh4m
         rAWkj3V5dd6KD5Sa8Gj3+7bUNhBIAHzOVYl+qnPkge8zfJYv1Btj7c+dJs+jrRjd2NfY
         dPLiWabKYcGd8utdvxLlpDElAivgvIwgozgikFOVB26nv40xtvEqYiJZHclMWEfKB6oK
         EhuDHSegp9ECumRxABB3v6Z2h4dMH/NOF7Gehcc8pM0RDt8wgjgomnJv6Bq16JKuL1T9
         HS2NxnSQXkzJECcmZRMvTOVgzkhCT/TRIvJzKUi5qckSuvAn5Lr1YWzd1OsjmuKLAyGq
         AGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786569277; x=1787174077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HHpkgwlmS2UMlHbsPRMJ2hdAa3SecUymkFYT4F57R8=;
        b=IUdeBa3/S5ze5cS4IbNsmJUxpHI1fsviA1GKJh8H1eQmFtZpNK2ASgGx6Utv7LNmE/
         IMJwUdcwvzXjGcUbLz9HnXwjTTxa2UrkRofjXVZMnbBQWwSBkEgeqFo8otP2kOVdqM2v
         E0hDZiFOTU/wjWR8XOG4AU8nG+uctygj7988lGN2AXKAV3FDfTkI3C9PAyz4/UezSWXy
         HhSlFccp1htWVGu/dSbTrwstybFF+kUASt+pl/426SbUAFSVFJakS0MgR2irLcto4kbA
         cnf9wrrGPI9jIY3sDMqdF1Hfnusw8Cx4Nih+JX5gW/JnwMM8tREFDMiiLGIl2pLLcMyA
         cHiw==
X-Gm-Message-State: AOJu0YyVm9TnzvZxdmx5B3Pd5Y2yBCnAgUBnpSmA5q2iGkn2wa9hbCLg
	r3tQVgchNFHDFIcwWJnd/IdzlA3FtmQMrp+exRVPLMtPScey7merngAZY9rmoqeF
X-Gm-Gg: AR+sD12O1SLybx2hR4DxBrVSU/YLh1FG5tT7eC2tbxrcGJW9H7rk9aOcIZuf7XsA1Fi
	L3ublN6L2U3erhIY8DDv5yTrNPjY/Piy6FVH4BIfqdC9jKT46/amMTPcvSqFMIcaPTwjbnruR3T
	O+qA3kf5rsZfjj3AYMV/py+Rrf0JFrztMrFj26gsbsnkBemfmg6ui6gG+k99t7uSPImzl/OW3GT
	oEKdHwQ1NaP4ENv3IgrkcflRwz3OVZYAxqk0JO+W0oZkp+Fk14w0VvlF3sp6c09eH0G5INqlU8s
	Er7VlAAr7wSYb1bGJdf5VpW7ZzifbQwvH4Ie0zJUJeG+eZA7WeWjl/AHUjP6inYVCYAaKhdHMRQ
	l6s3AAaF+Lb/RdKmQCsYHBqpr36ZUwIUEALSDAEIZIXXY3cl6fQT/zNA7NtJkLYbz208tfE4Nwj
	XmIavAVn6mBhUf4KghHVJ4NLDAa59UefCETBiivRfXfmx/97KCJff0ZflsapDn78ZB4cN6IjQOW
	NlK5iOqD5TIavySiQIJbTLlenT656cban1fG5pWjkJx9152RZ7dbCQ=
X-Received: by 2002:ad4:5cc3:0:b0:8be:1620:a95a with SMTP id 6a1803df08f44-90a80c736cbmr5531696d6.27.1786569277218;
        Wed, 12 Aug 2026 14:14:37 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81a9e489sm454116d6.35.2026.08.12.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:14:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>
Subject: [PATCH] rteval: stressng: Apply taskset to exclude isolated CPUs
Date: Wed, 12 Aug 2026 17:14:17 -0400
Message-ID: <20260812211420.203625-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812211420.203625-1-jkacur@redhat.com>
References: <20260812195257.378272-1-sansshar@redhat.com>
 <20260812211420.203625-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stress-ng load module was only applying --taskset when the user
explicitly provided a cpulist via --loads-cpulist. When no cpulist
was provided, stress-ng would run without CPU affinity restrictions,
potentially interfering with isolated CPUs reserved for measurement
modules.

The code already calculated the non-isolated CPUs (lines 72-74) but
failed to use them for taskset. This inconsistency differs from other
load modules (kcompile, hackbench) which always restrict loads to
non-isolated CPUs.

Fix by always applying --taskset based on the calculated available
CPUs, combining all NUMA nodes into a single CPU list. This ensures
isolated CPUs remain reserved for measurement modules regardless of
whether the user provides an explicit cpulist.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 387b5718a08f..03fe8429e7b5 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -79,10 +79,16 @@ class Stressng(CommandLineLoad):
             if not cpu:
                 nodes.remove(node)
                 self._log(Log.DEBUG, f"node {node} has no available cpus, removing")
-        if self.cpulist:
-            for node in nodes:
-                cpulist = ",".join([str(n) for n in cpus[node]])
-                self.args.extend(['--taskset', cpulist])
+
+        # Always apply taskset to restrict stress-ng to available CPUs
+        # This ensures isolated CPUs are excluded (reserved for measurement modules)
+        all_cpus = []
+        for node in nodes:
+            all_cpus.extend(cpus[node])
+
+        if all_cpus:
+            cpulist = ",".join([str(c) for c in all_cpus])
+            self.args.extend(['--taskset', cpulist])
 
     def _WorkloadTask(self):
         """ Kick of the workload here """
-- 
2.55.0

