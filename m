Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24455387363
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607473; cv=none; b=Ud6kkGkWanvMoPak5ntl+W4N0vz/4v09K8LbEgyRTwCGPJxbCuCzfqvtevkhhVjPzLBlyOPOk9DzHSvFlov3qTWi7CEwzo4T5O7uEL9oKj92YefMZUvkOFhAmMAkknGGTib+5wzGhX9AUqw/spCBd+yJ4OYkxET1U93fJT6j0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607473; c=relaxed/simple;
	bh=tYRSRMOCoDr5c8AaPlCzkJaf9wYXXNmgZB1EM01BYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RzxMPFwz9R25BUyHxP5lK9E+nNRaWYTFkE4Sc83Ft+vbzAs3LNMzVh2S2QRRi+T55o/su+EMyYFxhhX8mD+x86mmxJk9wvlnPiop9XrE/8CiRQgFkDy0DJZXZuLz4NTK/fM2hUq5zKQV1FuFfaqcBGB/lUkQ3Jw2ktLpDy/ShIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mW+cA96R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNNwECeY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mW+cA96R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNNwECeY"
Date: Thu, 9 Jul 2026 16:31:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783607470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TS8BEtvMQvtLnB6vfkWXPH4LOaVjs2BDj91GOA4OgVE=;
	b=mW+cA96RmxeGTEehWDU8SyxfkrIbx+4kKTfErwftKzdlJPFTPDYaY9Dq/PXN/CaklgWmAI
	6mxsuxy3x9Ol6Bn8TJQlODW0htTI2WRG+ss+iQ/iTa3+dz0rQBQNZ/qlHvYGraJFAj9Fyq
	CgCAiXYZ/hzruMIoatV18Juw00JH0G+B/tm/zLTz46J8Dn+bix+q4ahFQdBWT8a09B1jc3
	7esakF7I7Sn4lPC9iRIWnk5jqJUHmF6H+LNmyYFkYeTCLMGgwQtJECO/hyD/NjeaP7kaYe
	boEiKaVTSOoCT2qtNmbo9raX03lAOlZb79nlcfFrYHTdR+ukg5+G2zyxMKT0iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783607470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TS8BEtvMQvtLnB6vfkWXPH4LOaVjs2BDj91GOA4OgVE=;
	b=XNNwECeYc1MIAYyh6X9dBtiS5yNzABLsSfq9sA4ZLkMC2bGNLOtXKV6+mhEDjymCEGmXzl
	bTVZNwZpawljt0DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260709143108.UYeCUUcd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

The following patch sat in the RT queue for almost 15years now. I can't
find its origin on the list.
All it does is adding /sys/kernel/realtime once PREEMPT_RT is enabled
and returns 1.

Is this something that is still wanted and considered useful?
Is this something that can be expressed better by other means?

There was an in person discussion about this and it was suggested to add
/sys/kernel/realtime as a folder and having individual realtime features
as files. I don't remember a single feature that would quality for this
today but who knows. This is all I remember so far.

Now. Discussion go!

---------------------8>-------------------------

From: Clark Williams <williams@redhat.com>
Date: Sat, 30 Jul 2011 21:55:53 -0500

Add a /sys/kernel entry to indicate that the kernel is a
realtime kernel.

Clark says that he needs this for udev rules, udev needs to evaluate
if its a PREEMPT_RT kernel a few thousand times and parsing uname
output is too slow or so.

Are there better solutions? Should it exist and return 0 on !-rt?

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/ksysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index f45ade718054a..670a7a57d7b23 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -133,6 +133,15 @@ KERNEL_ATTR_RO(vmcoreinfo);
 
 #endif /* CONFIG_VMCORE_INFO */
 
+#if defined(CONFIG_PREEMPT_RT)
+static ssize_t realtime_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", 1);
+}
+KERNEL_ATTR_RO(realtime);
+#endif
+
 /* whether file capabilities are enabled */
 static ssize_t fscaps_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
@@ -206,6 +215,9 @@ static struct attribute * kernel_attrs[] = {
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
 	&rcu_normal_attr.attr,
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	&realtime_attr.attr,
 #endif
 	NULL
 };
-- 
2.53.0

