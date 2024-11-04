Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906341B392A
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730585; cv=none; b=krM7BhJjQPQw8V4kkU7oV4+Fd5ULue/CtxPLV1i5uPrZo8vJzXSTqYgPZmEP+qxsy8uZ7WUEGvP5ngXvXbc+/AZlOQUOMn24EAf2AsmjX6zTT6o2LfU8+Z9SLiNf7hG7yZ1yDaSJYPMfVR0lJo/eQoEDBrXc/hJJHlDa+z5ytcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730585; c=relaxed/simple;
	bh=YIKDQHTj4WC57oWtK81yEzX1qzjr9l9tOxh/akjbdBM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S0VIHQeNXbZNMcla0t6u4Qf0U/lrMtVV+aPlRyxTxWwdWohIAIGhi9hSZTu3dppR18sUcJnSH47f9oRoX+v4dBapq+8qdnfqHf9Lc+XcRcxxzbZPjVU9YKRTmwxOzOvc7q4U/ZoGFs6Z0BFdpYONcM2YPCYRMRTzlrrNFIl/45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TC1uFOOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC1uFOOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730730582;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=BZjbg4CyBT6u97FUpiNukYQMyl2WR+I8Nby9JYUg/Cc=;
	b=TC1uFOOoCRcfHK2RMrUYlLwMqD8hjriEpd4/Fn4FW8UM+GiTv4YfEuMppdSy/xuju9J0um
	TqMCTwe8CkeIpRW8oLZSVH5zhd3ikosLGEA/Y1r41uMLVaao9kXdWNxwfEqhUbizlOSU2h
	sCQmNarymkkG5RR2wd1X355rIasGNeo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-oQeQrqmnN2i7bREXjHM_oQ-1; Mon,
 04 Nov 2024 09:29:39 -0500
X-MC-Unique: oQeQrqmnN2i7bREXjHM_oQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DD8E19560BA;
	Mon,  4 Nov 2024 14:29:38 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.80.180])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD6D019560AD;
	Mon,  4 Nov 2024 14:29:36 +0000 (UTC)
Date: Mon, 4 Nov 2024 09:29:34 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
	ajhalaney@gmail.com, john.ogness@linutronix.de
Subject: [PATCH v3] printk: nbcon: Fix illegal RCU usage on thread wakeup
Message-ID: <ZyjaTu8ktE119iwW@debarbos-thinkpadt14sgen2i.remote.csb>
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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
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

