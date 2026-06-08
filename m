Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5A3563D4
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943634; cv=none; b=RbQP3SU0oVdlYrU0e8257wAZWRwrVcFcWaIfSYHZY/ZQyBQe2H2xwm8+3yg7ZFfUIl0nkiUmUgbHORDYF8mF84Vau+KgHvZfazPSh8x091+fKP5rzml5klsczYhxrWlc/rdKVAYwSLREG8HKCjXTdPFhRuUpVCBuY4HBeLFfvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943634; c=relaxed/simple;
	bh=DWa3gwUucqi9nkyXotpWuZGmpEHyiY3JGbl+mFGeZCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd7/V22qyQhS1fjUNOa6FGIlTp+VfE3pbKIr8pSdCDgA3B9YJwv9qw+iyfnCmpYuK4oEOXeAWcredem5P0NhWD2otLDpwTaQptIjszX88/GulRd4mpUy17mzMRBoDwFObxdvijFuLXIA2CekhKK4zkXJCSiyGKx7a9cwc4tdZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQ9NKK4V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ9NKK4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPGea45/GP/RF1dzFGX7mgaVJiGXiKxIrS9Dz6k/bW8=;
	b=ZQ9NKK4VFOPr3p1ybYz6HM37oe0m442cwY2F47pY8VVrEEPCCsiCVUNdE8d5awCY7IHH8w
	+XkaKhjT/KgidysN7bQuAARnqtx10D/0s182dDVDRSUkq8Pf9yzvnieJjGzlFW0GYB4ECE
	dV02nK+vjrNFUEQKqzBs5KBjgAqSA1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-RanK9GufPseJJ0NAigDNDw-1; Mon,
 08 Jun 2026 14:33:49 -0400
X-MC-Unique: RanK9GufPseJJ0NAigDNDw-1
X-Mimecast-MFC-AGG-ID: RanK9GufPseJJ0NAigDNDw_1780943628
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45EFD195DE62;
	Mon,  8 Jun 2026 18:33:48 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33B833692B;
	Mon,  8 Jun 2026 18:33:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 34/52] stalld: fix data race on thread_running
Date: Mon,  8 Jun 2026 15:31:44 -0300
Message-ID: <20260608183206.140526-35-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The thread_running field in struct cpu_info is accessed concurrently by
the main monitoring thread and per-CPU worker threads without any
synchronization. The main thread reads thread_running in
conservative_main() to decide whether to spawn a new worker, while
worker threads clear it in cpu_main() upon exit. This constitutes a
data race under the C11 memory model.

Declare thread_running as _Atomic int to ensure proper visibility and
ordering of cross-thread accesses.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/stalld.h b/src/stalld.h
index 73e20df..69bc9e7 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -11,6 +11,7 @@
 
 #include <regex.h>
 #include <sched.h>
+#include <stdatomic.h>
 
 #define BUFFER_PAGES		10
 #define MAX_WAITING_PIDS	30
@@ -68,7 +69,7 @@ struct cpu_info {
        int nr_rt_running;
        int ctxsw;
        int nr_waiting_tasks;
-       int thread_running;
+       _Atomic int thread_running;
        long idle_time;
        struct task_info *starving;
        pthread_t thread;
-- 
2.54.0

