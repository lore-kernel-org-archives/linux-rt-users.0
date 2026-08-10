Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378D2236F0
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Aug 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394148; cv=none; b=ksGBazgYS6cxhbR6Em8UGBTsUizQloV+k7B4eECs7DfxrdrqxurhdOxGUtKQojcI6We3jEYhIA0tNG52vFKdxY+ev4/TTHLcCqTwWyzTi0UUHYnn9EFsiu4U/DyvdGejdr8/rmM0gNQhsfmwSzWUomfbmgZ4SXWu/3v9WPJXUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394148; c=relaxed/simple;
	bh=UUr+EBSl7TmD4hmod/mPo+CSlbvnR24Cnn27CnkoKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkrXLflislfpJVMnui9yH0ThuP2cYEa41HJadu/8dvgOCsC8vo2jZ1XisuG6o3tiyYcJLlEAIl+VPypqXkukCGNSeTBkuK6WjU1Cu0EmINkxjnqs89ett8qKjfZ+dEHRGN7bvScN+dUWNT0z47LeRqksj46riyT5mXJW19cNl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQFXPIYm; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQFXPIYm"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-907ae240ac3so9462216d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Aug 2026 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786394146; x=1786998946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HHpkgwlmS2UMlHbsPRMJ2hdAa3SecUymkFYT4F57R8=;
        b=sQFXPIYmoEMieAFHle31z+36OnyYHxl6Wvv8Dlt+0kLzsxHOsi22sIHWd96vDv96pA
         wJPobSPBk7k7tBhD343JCKz9qAGqbgfoKa0E4P0dChYprQuuFbx0WbrDmanmw34ObHZF
         Pf1BnliqrqBbthhv+xBAFkWrIouH1Hf81XDC5vu5adzZtZwFBV7VvlqwVis4hr9+7TMA
         j9LfiXhO8EKlpPmlX/UnBO6GSz7Fe5i06+RZ1XfdBvtu9j4DqKqwOzUYt2r7I3PB9iG+
         ybWMJIuobbFnDaKKxApRZE7nZbwvEATZnCA7JDua7hI7U2O4dbNEsOZ4vaSSWdGZMLX1
         QVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394146; x=1786998946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HHpkgwlmS2UMlHbsPRMJ2hdAa3SecUymkFYT4F57R8=;
        b=sKivDuN1dl4iLdALbVJaC1RJYtPYfgt1h0Qn8jXzfjnzrnTbLYTF/c81TtZ0DLrsRb
         9pdXqRBHJNUAL3HuCehoDJ4LN6Sx7Mx1YcfsmpBq+9GhY6If6EgFVBtuONe/DsmdFS/u
         ETdjwx3zkA+isW/aD+5n5iPTGiHIsGfNM2QbTx/HHTjvM3HB0GrNDsnkTtd9nUN8AteM
         MGd80cEeGAuEjFYt4ZxPOQPPzN1GxOGMtdF1SNby+LVL20/1wbvcAxWcVUWtwXs+lkC/
         SmfdgxtELzUkegrVhR2lb9ruhVWroRkqzUT+smqogcIOJqxBlQ1GQXPNKgjYXBPpN6Wi
         SqSg==
X-Gm-Message-State: AOJu0YxpzTXS8lRePWQOPLez6khla23QBQCsyEnu4+nReaiXSFFt7JeR
	nNhL0+NYXMbp6Oe+88hxtbiejTTo9as/hqwNYeLc9wTCbVdPqD7CRHp1R5nvpQ==
X-Gm-Gg: AR+sD13YNNGkXx79zqR6DHITj0aPZOLrUk6JyfBH2hvwsAlVxqymVz+vJVcqF4i26TS
	YTXk7SnpHKo5G446DzweNmrJT2WUF+4nxK9+57d2lK1yGh5yheHG9gJuhE0B/AzPbPyfLCo/Iva
	ZmNuDFYTT3DERUuZtm9IzOoTBDIoC1nsR9jcyod+mY1ZpiNxm++VOqDYoDazisYLRMn9IZ1fPSN
	LAqiPkKWXvObVpCh9pS2k3L4dLETbpl3bwdDDqJhsC35jPs8u6phcZ/ZImlPs/n0ca3XsAL212Q
	lk5NjHD9hCRx2+HU+5V6ii5qweRMG6h6DHD5QHYkUH9mNsB9faDfsyyOa6ToAPxtVvOrPzHWhAd
	ZT84JEILyBpwrFLNNrWfBlPaB9NShB0y/9COmpP3iM/7MYzoidUOGvaLGSnCJ7+dCiJrSoVU2+b
	Xmp4VS/b75feD4MDthE8E51opsyDhDjN2+2NfHQWNS8yHniOA22X6/nLlfeQk23Spkmo20Bjylp
	rN8DaCj1JrbiBackTiHkAGyW/QEmWT/xcH5HNhZO4mSWYZEqQLfyPo=
X-Received: by 2002:a05:6214:1c4c:b0:8f0:b50f:dd1 with SMTP id 6a1803df08f44-908a6f649bbmr313654476d6.5.1786394145987;
        Mon, 10 Aug 2026 13:35:45 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918d7f1sm79807856d6.10.2026.08.10.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:35:45 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Sana Sharma <sansshar@redhat.com>
Subject: [PATCH] rteval: stressng: Apply taskset to exclude isolated CPUs
Date: Mon, 10 Aug 2026 16:35:27 -0400
Message-ID: <20260810203527.136747-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
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

