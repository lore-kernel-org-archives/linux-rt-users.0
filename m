Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E8563290
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116007; cv=none; b=fGBxFAFfZCajFQcpuKazfvf8jgv3wlqBk+klwT1N6C5B+skiEKLPdtoKUhnFuCtQEN/oRZxa164eH34+I5bUEHFk2Lna1rT3x9WMMDFPz6yGAgw55gobYzOv63QTgTRu/2a5D+FM5pMSEnP/BErteQ0kBI4zGMHRaqPqSRNWJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116007; c=relaxed/simple;
	bh=g33WwXDihBZgP7+EFf+6+6x7Z/pTNXWa4Keo4ovzFcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCpA/+IBIUdzfCTYzkUOSkWhdNo1KPIfjOTcjZGQfXoiBa3hmogkfZxjVgPzGzSGWgME4rv+ieeapcrRQoQNT2UCTmwPFpqIaxQSksp0SInXWM/56TexoOV9sRVI1CokscRKyJpriYJEAQQyjgocIL5SqV6QmFStWslSVAdKCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHgXPTBU; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHgXPTBU"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so3354456d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115994; x=1790720794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rQiS8nabWG4HF5vmEjyHEfImEERMITBzXOl8v/L3mA=;
        b=lHgXPTBUG9CHm0pLhoArdIT7sR8dnevAfY+RYQcv2PrCoIK5s6QzHdAIujJnL2pV+q
         z1OcNB8Hm5WXjY+j4fW2wSxzMcJxXIX8DwGuqaVF1ZmJALxeO3WnRLcM3Lol9Hye+yMo
         XkjgOQyfBCzQU2dlSE/RoCtEbhNPyVX0i+6/Keo47XxHl+TVoWyB0i0l6skzo/GYd+MR
         ABEyOyVM9zXqr/vK9NqaKF4VI6/nzW7ZDjNeSYzhP6cL5k8X7u/23QUzpYOjQMNDyK19
         Io+J/WUDYIxi/Nem3eYgNiHY2z4Irc631XOY4YAoh4kztit2Kg877x/lhD5w+scl+bd8
         EoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115994; x=1790720794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rQiS8nabWG4HF5vmEjyHEfImEERMITBzXOl8v/L3mA=;
        b=tB50eCLaV0LvPIOyPLSASPtslE9gILus6FEduiT+xoYdWSBRepLyXi2D1f2nLr+vUt
         uTVsHlLVH06NOfqkck1+g1MsYFaeOdsYpQEilM3NkW+KjIBqXFtnrLaLtDoISzTPTPGE
         f5Mvjt1xPnZzbBXjHmP4UWwkukCJAXwXwkbWeLgtEvZsnMYl44sIxXnWTej3WTkcb7/b
         c2NzqiArRvkRaW/HqrFtsYQ1OANiVbDv0qU9lXstFX+byVK7qKBnDGU1zmt63iH4Yj8b
         vjZV1+qxCy7c1WoXPQOzPuKIHX7xmZHdy6SSjaDfZUNtaKKiaE4+nZOuwUoKe3VGWCLl
         BMdQ==
X-Gm-Message-State: AFuF++m3E9u/w9RBKVknfEl0w9v+EkHRJQR5z/jyAvE7uUx7MOadzUfn
	Ha6E6iP5X1bcyUsDtmsmscumq0lDPV9s8VbmXESsz9MQHmhyi/GwM4U/VXCbnw==
X-Gm-Gg: AYBFou11NqMdx+2p2LEGtGt1IKWxO8wkWgXJF5ALdpxT9RMqdR/QVL0lNO4s5o5xL7w
	mxPX8jou6thkC91tGD6bYDmADIxeUgXnkMTRF9s0qPHF1aGK09tYCGf4PZVFXSPQGVAHAKBV27Y
	W9l7mPKkNH6eCUVl//LpGVdb7mCbtG6DWR6ghKXj4OPuchqZ784OtunJh1NyHZovI1e3wP4ejZy
	Ve8PRW4HI77GZbv6/YdA3rJoKTMBbk7sViHBDjtx+4RHZ0pTCmfqzoNM+JquVkxEDu2w01oc3w4
	/M5jHhYL/rOnPNrxAAmE0lM+3lxBMS4LlbPQLJqqVt3DJZ8WnMDVPYjQLuxPSeDXZbTTd5/SMDg
	pZzbmaWYxt5OeUi3cjBhus9B1ZxzcSm+hnhxSbITE4HAbH5zG+7ZezlhJD7RXe5awtzf5dVhIts
	KDgTfAfut1tB0/WnOjP+rtc2Ny1nZ0Uiy8pZ6Bh+1RVSIUI5Gtd5D3B/2Ozs90R98jPfcuZ/Ekk
	UPeCfGadn4tgA89peCVxXaHrarhN0pz/QvCDRqxffobtnPMCWK78tQ=
X-Received: by 2002:a05:6214:2481:b0:912:5836:82cf with SMTP id 6a1803df08f44-9140c3c79c9mr16687336d6.27.1790115994382;
        Tue, 22 Sep 2026 15:26:34 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 5/8] rteval: Move --measurement-member into the measurement module option group
Date: Tue, 22 Sep 2026 18:25:49 -0400
Message-ID: <20260922222552.482102-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922222552.482102-1-jkacur@redhat.com>
References: <20260922222552.482102-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--measurement-member was added to the top-level argument parser, so it
rendered under the generic "options" section of --help instead of
alongside its siblings (--measurement-cpulist, --measurement-run-on-isolcpus,
--measurement-idle-set) in the "Group Options for measurement modules"
group.

Add the flag in MeasurementModules.SetupModuleOptions instead, using
dest=measurement___member (read as msrcfg.member) to match the
convention already used by the other measurement placement options, and
repoint the validation, overlap check, and CpusetManager construction in
rteval-cmd accordingly. The flag name, guard, and behavior are unchanged.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                 | 9 +++------
 rteval/modules/__init__.py | 5 +++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 46a09c9de3c6..15f6f505fed7 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -126,9 +126,6 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--housekeeping-isolated", dest="rteval___housekeeping_isolated",
                       action="store_true", default=False,
                       help="make housekeeping cpuset use partition=isolated instead of member (requires --cpusets and --housekeeping)")
-    parser.add_argument("--measurement-member", dest="rteval___measurement_member",
-                      action="store_true", default=False,
-                      help="make measurement cpuset use partition=member instead of isolated, allowing loads and measurement to share CPUs (requires --cpusets)")
     parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
                       action="store_true", default=False,
                       help="warn about measurement and load CPUs sharing cores even when neither is isolated")
@@ -424,7 +421,7 @@ if __name__ == '__main__':
                 raise RuntimeError("--housekeeping-isolated requires --housekeeping")
 
         # Validate --measurement-member usage
-        if rtevcfg.measurement_member:
+        if msrcfg.member:
             if not rtevcfg.cpusets:
                 raise RuntimeError("--measurement-member requires --cpusets")
 
@@ -531,7 +528,7 @@ if __name__ == '__main__':
         # the loads are left with no usable CPUs. Fail loud unless the user
         # opts into a shared (member) measurement partition. Skipped when no
         # loads run (--noload) or no measurement runs (--onlyload).
-        if rtevcfg.cpusets and not rtevcfg.measurement_member \
+        if rtevcfg.cpusets and not msrcfg.member \
                 and not rtevcfg.noload and not rtevcfg.onlyload:
             overlap = CpuList(msrcfg_cpus).intersection(ldcfg_cpus)
             if overlap:
@@ -601,7 +598,7 @@ if __name__ == '__main__':
                 logger=logger,
                 housekeeping_isolated=rtevcfg.housekeeping_isolated,
                 create_measurement=not rtevcfg.onlyload,
-                measurement_member=rtevcfg.measurement_member
+                measurement_member=msrcfg.member
             )
 
         # Pass cpuset_manager to RtEval (None if not using cpusets)
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index b8c443e8e0c5..ad7891fcb3c8 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -316,6 +316,11 @@ reference from the first import"""
                                   metavar='IDLESTATE',
                                   default=None,
                                   help='Idle state depth to set on cpus running measurement modules')
+            grparser.add_argument('--measurement-member',
+                                  dest='measurement___member',
+                                  action='store_true',
+                                  default=False,
+                                  help='make measurement cpuset use partition=member instead of isolated, allowing loads and measurement to share CPUs (requires --cpusets)')
             grparser.add_argument('--measurement-module',
                                   dest='measurement___measurement_module',
                                   type=str,
-- 
2.55.0

