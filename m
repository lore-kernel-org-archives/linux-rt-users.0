Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505B3502A7
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727676; cv=none; b=AHyRifPSz988+Qq9UaXyTGl8yVfCyF0iKk11F/601YEDwec0QKW4Clgb+1XsIE2ujq1tcI1Hn5js2jSdfQTpGVTBUxVZspkuKZSj5eXhwLy8ZWsYVRiqwSJc1gt9PsEjTxDcwuyNTnyglugC+1k+SHflu+Zu8yg3qONJp51ZMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727676; c=relaxed/simple;
	bh=KGAhLStl3dsf4rGi5wM/d3P2mgbg239sdIOzZaG0MDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPXoqv5thmLn1tHEZdqnojdvSHWr1qQLL5kTOOTsI3DdN8JOBg5MsSuQ5gX8KAxN3tjZauSojTfRhQS4DHCOavJbu4xKuvniTGUDzHA5RxWYwKIER9IUNFpaM9DNZGBpksyPzLiIN2HcUg62m0C5w0W9rzARgtFwglBNXXavoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY3kp1ko; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY3kp1ko"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8db9f25c5acso2637726d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2026 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781727674; x=1782332474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qlwl04VNfmPWxM8tJ6XOuHoG3Rmp0wT5OEn3y+bB4X8=;
        b=jY3kp1kozuuT84hq+9JFGtyNfF7k694x0fV8YtkukYKUOJIrWoY034v4p8fkDwu/mw
         QeAgcXs7BFxDUrqx6DQybgtDz+3fwPSyN/oYoxzklsCQxoxzeQNiGT1G6jSKhLzaXGwX
         U/Y6//l46SThtrPo7ZDhvLKjCVRWRMN7EO/vP41qrX9JfOVPaNXAQ6bBULIwpqU2Cmfr
         lPxbu9pXD5IHGHGxgFlYImZSvZosPrm8GAZkBBAKIwO3IpIy7sycT+M7fZP1jrWoDOqM
         3vfUmN9VD87BslkosxMIS5BMTpdDHYQXw7oE5jTuKl0Yzm6KSlU7cnR2mbzvnFXcLAoD
         1ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781727674; x=1782332474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlwl04VNfmPWxM8tJ6XOuHoG3Rmp0wT5OEn3y+bB4X8=;
        b=rOHCbC6gLYQlSHTEUnKnG3848rfs5RX9PWC+TT/DRyicpB0uTMSdIHrfB2TV3Tb9IV
         7eo+hb/nxzXpf12+xSYRDgeBaxPGt1niDVuHW7amveAS8I0eaHwtmYc2C8t1/Nv8FYBs
         7VJgNB3kwXpKN6Yq3FTDCpR1A5kKXAxiQKMlcoOzfeeZYsSQ9eIR+oNOkrzeepIBDyV9
         E2XlloObBwxpcjjQZbbWaUrkvm7hzYkWaVnL599gQ6amO5exMB2WTX7nXlj/g5qLHNR5
         qLGgo2vYPfB4/53xKj4f+7TA0GXAPViQ+pDCa9nZd6d6LrsYdxizNN5zDh95OwnH3CR4
         8ttA==
X-Gm-Message-State: AOJu0YxkmQp0RlH+TeHA1s/L/aU5FcBd4kev6fg7RCxamblyWNNQJfqO
	7TJbAku5MWvzFzR8BC2OpY+vRZjzyZBHCz1rMnM647uvfgG0rtPjZxCKtboWHA==
X-Gm-Gg: AfdE7cnBPQpqFPs3fsrHCW6rVpU9iql7cB7KVyrEKXSC2L9TSoEtgo/Ms0Jj15LJLeu
	58l4MhaELxoRdTAxSCU6K5rW2vGLAwv875TJCpmNfYfEIMXG1qeuJGo0+9AEt6gZBkJ9kxQtMOq
	WqJSq8km6+qBwa7y7Q0k8613QAW0cE7uJoCPO89tBe5g4Ji3YOg0/pHRY14zaiF+aAu6MFiJjV3
	8kjwphmuNvv4XeYhjpU3fLQ0FRQ2atLmTUNezxXwDIlbw/TghuQGsV8bOVH1aVKurieOPppyE0O
	MITD3hiQGVDqU664x5x2VuJEkUum3/lpiPvEV3UniymYOnouVXcLR6yKwJ4IM9KEB6RcBjaBujN
	D9/P6ayhU3aI6czZwAMNRrLpNkqgu0Rq1qppwCwmcGnT4wFCqzu97TWDq/Z8IdzGyr8XYpJ3IZv
	seLUB1oY9TX9EP1hVYz7K2UFDTC20GoCD4+5lNYIAh6EJ/sqvgelrKIeeX/NLM0x+ZQZBPHdn+7
	Na7JsTL
X-Received: by 2002:a05:6214:61c5:20b0:8db:dd:4d85 with SMTP id 6a1803df08f44-8dce0f999f1mr11176116d6.26.1781727674145;
        Wed, 17 Jun 2026 13:21:14 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f1dc7432sm71969046d6.19.2026.06.17.13.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 13:21:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 1/3] rt-tests: README: Remove obsolete -n option from cyclictest examples
Date: Wed, 17 Jun 2026 16:20:54 -0400
Message-ID: <20260617202059.217693-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -n/--nanosleep option was removed from cyclictest in commit
9d2c9edd8694 ("cyclictest: make clock_nanosleep as default and add
option for POSIX timers") in March 2017.

Since then, clock_nanosleep has been the default behavior, making the
-n option redundant. The examples in README.markdown still referenced
this obsolete option, causing the commands to fail with "invalid option".

Update all cyclictest example commands to remove the -n flag.

Also add SPDX-License-Identifier to match project conventions.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 README.markdown | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/README.markdown b/README.markdown
index 617b57e88614..9e6ec20e036c 100644
--- a/README.markdown
+++ b/README.markdown
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
 # RT-Tests
 
 This repository contains some programs that test various rt-linux features.
@@ -14,7 +16,7 @@ This repository contains some programs that test various rt-linux features.
 To run one test thread per CPU or per CPU core, each thread on a separate
 processor, type
 
-    sudo ./cyclictest -a -t -n -p99
+    sudo ./cyclictest -a -t -p99
 
 On a non-realtime system, you may see something like
 
@@ -62,7 +64,7 @@ tracer must be configured upfront. The resulting trace can be invastigated in
 `/sys/kernel/tracing/trace`, for example:
 
     echo function > /sys/kernel/tracing/current_tracer
-    cyclictest -a -t -n -p99 --tracemark --breaktrace 100
+    cyclictest -a -t -p99 --tracemark --breaktrace 100
 
 This causes the program to abort execution, if the latency value exceeds 100
 microseconds; the culprit can then be found in the trace output at
-- 
2.54.0

