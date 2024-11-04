Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85C134AB
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726844; cv=none; b=gB7VUwswKUk4mDQIVIbR5Uyw9FP9l+NN26MaXJC52H9GJAADhFMbZeNrcNF5TCGAr/ZP07l9jBTrNkxzpuiXvcn7VBUv5AAdAFGoStjndIC2oE6G8z4doGQrV3jnQDwLQU1Pax2JARbx4ghJdFxzh0dLLOynUXSk+yi7sbi+H9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726844; c=relaxed/simple;
	bh=HnQ6bL2ddtuYL+7tMdoDGqPlU+HqmBItoijzeOdjR8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kL/6qbOLlDJgpaauABXBTZTyNmcPlEvaGcwVImQVKbHS2ovXiW1x3aOhsZ4teP+uerLdUjk7gcuBqQfqcqDmCaXPUvrMfP/Lkv8b2zRI9H2vGCiwXtbAxOerzAR+Py5Zei4XeVYp7UJSSVp/vsjzh3SzIhYB18SurZoR5K0F+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZdrDAjb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZdrDAjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730726840;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=oHoWbYs/RsOFBGpv0ja1SDHA/yPP9lWXcSHFH/xGNeg=;
	b=iZdrDAjbvOPsh7yevdG/18JduiBEupsbgMTWCuep07FdjJc4QPs9Yu6ln9hUv6Jh2v6cEz
	MsGYbCSvgxL79YbMVQm2bwbMhR7ztMfpt/74DZW63bDDgi1v2nejnZ1idvmVBrKcYPRPjB
	q0GGqmkRtoPodgOa7/aW0kP6UxEX3/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-zWZmhP7rOqKXzlmIe0hnzg-1; Mon,
 04 Nov 2024 08:27:17 -0500
X-MC-Unique: zWZmhP7rOqKXzlmIe0hnzg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5561319560A6;
	Mon,  4 Nov 2024 13:27:16 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.80.180])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DA3E19560AD;
	Mon,  4 Nov 2024 13:27:15 +0000 (UTC)
Date: Mon, 4 Nov 2024 08:27:12 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
	ajhalaney@gmail.com
Subject: [PATCH v2] printk: nbcon: Fix illegal RCU usage on thread wakeup
Message-ID: <ZyjLsAK1z7wcrv4N@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In debug kernels, printk'ing during the SMP startup of a secondary CPU
results in a splat on boot that details illegal RCU usage from
offline CPUs.

This patch aligns rcuwait_has_sleeper() with what currently exists in
Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
aforementioned splat.

Furthermore, this patch makes it so that we avoid the use of hacky
rcu_derefrencing through the waiter's task struct,and instead leverages
the correct RCU API with the rcuwait_active() function.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Closes: https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn

Signed-off-by: Derek Barbosa <debarbos@redhat.com>

---
 kernel/printk/nbcon.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b941039ee7d2..579f71fffff4 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1101,9 +1101,6 @@ static void nbcon_irq_work(struct irq_work *irq_work)

 static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 {
-       bool has_sleeper;
-
-       rcu_read_lock();
        /*
         * Guarantee any new records can be seen by tasks preparing to wait
         * before this context checks if the rcuwait is empty.
@@ -1116,10 +1113,7 @@ static inline bool rcuwait_has_sleeper(struct rcuwait *w)
         * This pairs with nbcon_kthread_func:A.
         */
        smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
-       has_sleeper = !!rcu_dereference(w->task);
-       rcu_read_unlock();
-
-       return has_sleeper;
+       return rcuwait_active(w);
 }

 /**
--

