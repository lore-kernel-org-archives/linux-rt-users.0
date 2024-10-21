Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996A1CBEA3
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Oct 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526117; cv=none; b=IjaXfuAEVKUzB02ZmBzILs1H9d/AcRNCP//4GpF4zgNSzhndB38esnUnz1Ep9ejeUAcuDHGOBMrhaBGCnMWnUgviEuM7dGrjrHWb72b6mrrypW/vdnP8XKIANjmv2hzkbgUnZhluGPcV2gW2J76fGPp732JLGlJEPObeupGUmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526117; c=relaxed/simple;
	bh=/wrYUy+5jrtZ10Yu6P+jXF0ksCAMWSl49dW57HXtPNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=el6nBVTA1liE25y99iTd/ihDjV/VUSvfJcojtyoZCCjs6+EhtlsloVyQo9f+fn7THPVUnlC4vsDeYiGtjWtOTjSPqyZBhjNjIRShpn8Bljp/ahuWHvol7OEry1+j5LwBASsp+6GJ6CETs2RrJHcoVJYfFoAIUkA7CHjf/dKFxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TW7iDag9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW7iDag9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729526112;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=MzX2pAP8l11WaiTojp6NlZVXnb5J5ojW0YAjpZvhBOc=;
	b=TW7iDag9+mlUj1jcFx/r4gOxfYIFbavYzxtq98y5DGmdwhY2VMvYT1zUj5FsPS0czeO3dG
	lUft2zt35EdJrLO8+8oNpK8zAGUZRrW4RmDxVFF0RJKht04zd7orPQjJ8O8+pAc8tkWsQ5
	eOtB9/70lNkjnxtIXXVa9DlkC8mkOZI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-JhJbFo8jOLehDpWeme62IA-1; Mon,
 21 Oct 2024 11:55:11 -0400
X-MC-Unique: JhJbFo8jOLehDpWeme62IA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D09E1955D45
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Oct 2024 15:55:09 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.88.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8BC19560A2;
	Mon, 21 Oct 2024 15:55:08 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:55:05 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH] v6.6-rt-stable: printk/nbcon: Fix Illegal RCU Usage
Message-ID: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ifVe99c99bFA5nYW"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--ifVe99c99bFA5nYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On !PREEMPT_RT systems, printk-ing on a CPU that is coming online can produce a
nasty illegal RCU usage splat [0].

To fix this, use the correct RCU API in rcuwait_has_sleeper(), as seen in
Torvalds' tree at 76f258bf3f2aa.

I have appended a patch with a more detailed commit message.

Thanks,

Derek
[0] https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn/

--ifVe99c99bFA5nYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-PATCH-printk-nbcon-Fix-illegal-RCU-usage-on-thread-w.patch"

From 1188b21c357dcb750a6851d7e5fd2d1f70ca9690 Mon Sep 17 00:00:00 2001
From: Derek Barbosa <debarbos@redhat.com>
Date: Mon, 21 Oct 2024 11:30:30 -0400
Subject: [PATCH 1/1] [PATCH] printk: nbcon: Fix illegal RCU usage on thread
 wakeup

In debug kernels, printk'ing during the SMP startup of a secondary CPU
results in a splat [0] on boot that details illegal RCU usage from
offline CPUs.

This patch aligns rcuwait_has_sleeper() with what currently exists in
Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
aforementioned splat.

Furthermore, this patch makes it so that we avoid the use of hacky
rcu_derefrencing through the waiter's task struct,and instead leverages
the correct RCU API with the rcuwait_active() function.

[0] https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn/

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
-	bool has_sleeper;
-
-	rcu_read_lock();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
 	 * before this context checks if the rcuwait is empty.
@@ -1116,10 +1113,7 @@ static inline bool rcuwait_has_sleeper(struct rcuwait *w)
 	 * This pairs with nbcon_kthread_func:A.
 	 */
 	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
-	has_sleeper = !!rcu_dereference(w->task);
-	rcu_read_unlock();
-
-	return has_sleeper;
+	return rcuwait_active(w);
 }
 
 /**
-- 
2.46.0


--ifVe99c99bFA5nYW--

