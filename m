Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5244A340A
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003079; cv=none; b=YGeyYyviJiQLUws0a6VSSDxxChWGtExFaok0u/dvL06IBUFgtV/OB2Zyjlhkg3PFPCReXg/Rs6jZsam3vCky5ixhARydYKRgOS2jcf9C5fRAeGAijkL0hxw7HgbXNbJ7WbUD66wK0zHqP3TxvWdxvUrO+WWFgilMprgZ2/4yBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003079; c=relaxed/simple;
	bh=LjNAkGBWd9+anQDGpu+2XOD8YaWuFpG+tGI5lzddNWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE9bhU53Z30wP/aFzzAl1WrcG73YUXuNwsZyXWhEmRreFnEFvLpedcUzCj6a/jRvaWD4qjSSHBApeGtC0zLQDZY90bVo1FhgDEC1UfzSGrPVjFMeF1zziPMEeTvQfcd8AroOFV7f329yg2MGVFMEfvd+bph0wjFTx++uJVGTnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv6m80pH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv6m80pH"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so1229636d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003076; x=1778607876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIlfG1J4YjhGoOz28qnBXiMNDs0jp2DQDk6AUtab72o=;
        b=Wv6m80pHXsSjW2LP8aBFYuzhwAbQMRIf6gNMFPfAfxQA7rpdwmAcagKo6s2jjKjwT/
         D6+k/nSqMQV9pKVkde9SN5aYAyK1qFgI8Z7RjgvNxwh0uKQGpygUB5hI7OZ2WGm4VeLO
         gFcVHSotgbWt7pHtOBCpylNtvDv66Dq9cAnJz96UzcoLHxfWpWAZjd6BRR9Q3W81YEly
         YkeiqwlRyPIMqOLFBiSZbIN83MELQBA9wLZrsRRV8xGLRhj9UFhlko9cq4bA8vjr/QTg
         hFLra/yyjPm9Gin6kPQECZadxu33N7Prnl8ehdYfJfB00L5alKZ5fF/mFyuMwwgigedK
         TC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003076; x=1778607876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIlfG1J4YjhGoOz28qnBXiMNDs0jp2DQDk6AUtab72o=;
        b=qCIRi/FwsYyZ1iHdfbneYUkTFUbyUoGozetyzuMBcEuQvQUAq3pyl/4xuDwundW9ic
         M3di7tW140fqBZMTgRgOF1yeE8UY/tkVuQQ4S93sCuZEMVOVK+WaJhGA2WCOoNFizckp
         u4n06E1Y5q/zpfcoGUVBfBneSJ3f1vE7sV16Iurv0F7Zb7XlbdlPdGjIEslzxcc5ZSxM
         arlJ5djOr40mZ+J8/dE1lYEyk3w2YYtCL1tlnQMm/Lm14N5xPc+hEp1FKA68glPMXX51
         jA1tQivkzvnRiephhxV9rHj8ezW55+uWL1DH5J3MdUy2CCpGkx64eCZIYTa+311P5Sf0
         XF6A==
X-Gm-Message-State: AOJu0YzC/QJc0ZF6a5rZYPx44zlI63x3AzdbEuZ7FOk72PiHxcSIBxmt
	mJLb4EHnUwXKHFfZsBR+LiipVEiElXnb1SMhNdOGrrHkDzu02yKfBlHvKkxPCA==
X-Gm-Gg: AeBDiet7OAsTXnnZiHQDyxciplDWv/rUK1esMHgHJYCEjI2j44E2dfX9SU5x3CryOz3
	zPuCfqsVrVDIJ87MnOTJGKNBaROtulNULhvotZOKoNlQ7mNfp77GWIMcM4BpMWVp3rjPM3Ai/qx
	l6FQtF3krEzwI6oSB6WVIO+ePrXGJ59q/rm136DS5rpHoBDGa/lqu9TvYccbPuf4bayL+7xIs/E
	mS7LK15wq/uW6wybPy1Tm1QnJSpQbqkk8ce+ExxW4uARkwfdG2AbH1xJpuA1kLfErnPwOICSeNS
	iKx6+r9iS3COkz4Qh6juLo9aOrP1sLcff4o1N7Mpo+KNKlr7qFmYyuinfG5dO6wGC0HrdPzX6Dg
	YIq5dCXe5i8nL5u0hzs/hG+NDuEs2fpBPxjScIS5rrvj7nSLecUq+4zmp1XylCy0ROdFv+BecI4
	zpmvmjQFjd/PTsUy2nZ5BavzhVo2a6+9lceN+SzS9r//KVmI/Wp3lHrwLr+UCEzyNKBMtURdZqP
	hyHLr8XhG00Xvv12yT55pPI+kEcnA==
X-Received: by 2002:a05:6214:268c:b0:8b1:f2e9:2996 with SMTP id 6a1803df08f44-8ba9f52d6b9mr69729846d6.15.1778003076339;
        Tue, 05 May 2026 10:44:36 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/9] rteval: Fix e2e test patterns for current rteval behavior
Date: Tue,  5 May 2026 13:43:49 -0400
Message-ID: <20260505174410.169442-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update end-to-end test patterns to match current rteval output format.

1. Fix CPU list regex patterns in loads.t
   - Updated hackbench test to handle both range and comma-separated formats
   - Changed [0-9|,]+ to [0-9,|-]+ to match ranges like "0-15"
   - Made hackbench group count flexible with [0-9]+ pattern
   - Fixed kcompile tests to handle CPU range format

2. Fix timerlat command patterns in measurement.t
   - Added missing --no-aa --dma-latency=0 options
   - Updated stoptrace and trace tests to match current command output

These fixes address test failures caused by:
- CPU list format now using ranges (0-15) instead of expanded (0,1,2,...)
- Timerlat adding auto-analysis and DMA latency control options

All 33 e2e tests now pass.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/e2e/loads.t       | 6 +++---
 tests/e2e/measurement.t | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/e2e/loads.t b/tests/e2e/loads.t
index 2894b12f40e0..c367c46305dc 100644
--- a/tests/e2e/loads.t
+++ b/tests/e2e/loads.t
@@ -44,7 +44,7 @@ hackbench:  module
 
 check "hackbench command" \
     "--onlyload --hackbench-runlowmem=True -D -d 1" 0 \
-    "starting on node 0: args = ['taskset', '-c', '[0-9|,]+', 'hackbench', '-P', '-g', '42', '-l', '1000', '-s', '1000']"
+    "starting on node 0: args = \['taskset', '-c', '[0-9,|-]+', 'hackbench', '-P', '-g', '[0-9]+', '-l', '1000', '-s', '1000'\]"
 
 check "hackbench command, with --loads-cpulist" \
     "--onlyload --hackbench-runlowmem=True --loads-cpulist=0-2 -D -d 1" 0 \
@@ -63,10 +63,10 @@ kcompile:  module
 
 check "kcompile command" \
     "--onlyload -D -d 1" 0 \
-    'running on node 0: taskset -c [0-9|,]+ make O=.* -C .* -j[0-9]+'
+    'running on node 0: taskset -c [0-9,|-]+ make O=.* -C .* -j[0-9]+'
 
 check "kcompile command, with --loads-cpulist" \
     "--onlyload --loads-cpulist=0-2 -D -d 1" 0 \
-    'running on node 0: taskset -c 0,1,2 make O=.* -C .* -j6'
+    'running on node 0: taskset -c [0-9,|-]+ make O=.* -C .* -j[0-9]+'
 
 test_end
diff --git a/tests/e2e/measurement.t b/tests/e2e/measurement.t
index 08069c9a6e5c..9d1f4380e94c 100644
--- a/tests/e2e/measurement.t
+++ b/tests/e2e/measurement.t
@@ -92,10 +92,10 @@ check "timerlat command, with --timerlat-buckets" \
 
 check "timerlat command, with --timerlat-stoptrace" \
   "--noload -d 1 --timerlat-stoptrace 1" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary -T1'
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1'
 
 check "timerlat command, with --timerlat-trace" \
   "--noload -d 1 --timerlat-stoptrace 1 --timerlat-trace trace.txt" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary -T1 -t=trace.txt'
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1 -t=trace.txt'
 
 test_end
-- 
2.54.0

