Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCB3D525E
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Apr 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674986; cv=none; b=MDSuP8KMP9tfnSKs3pQ8+kjGBiUNMUCCd7BPSvEArxOiy5PK/LXiJspzMkyiWMQvRX0/EFBseipAMZRNaAqpX5YUVcNdhGDRKL6O0xfXtmX8CSffOCJIg8E5g0Fq+i8Uvv/Gn09zr1eX2B/7adK4FIIRNZQy1I1AgHzmh0hkoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674986; c=relaxed/simple;
	bh=659fINYMzuF9gp4K+aEZo09YRrj+DY/LkaT3HyOjrDA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LeFfSmjWgXtwxzZGfYtZHzLz5S/hnFOtR5tLT/fuOBLJnNgh0GSWNcNEsba30MMlQCHGPDMWk4w6Dh4+j11aLax7nEpQjBQa/bkuEu3VF34dhX1uFtA83spSkR9uKoc3+HfbQ9z5vpfGl5ofvpKzYDCBI+V/2vlo5K9OyzGhV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=in3u9jqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="in3u9jqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775674983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zD5/SJRGIuICEqBcH6gXNeLxWlrHiv3BXKk1bJihrps=;
	b=in3u9jqLVOisyJW58dcNZGPhM3ZhbbeB/1ullmcZ5BlLhCqTE4MA4c7GKt8FOVBvyRafcn
	qXIl0WByxP3LG/mfZbl++hGlZJxt8JH4FSvWEjjI90Ymsci95lPYcvcrMKK/mKt3gOHKPg
	hvowhYqZhnYsDieBcdvVIpw1TSItTl4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-mW72pzsWMMGtnVolyxWxqw-1; Wed,
 08 Apr 2026 15:01:12 -0400
X-MC-Unique: mW72pzsWMMGtnVolyxWxqw-1
X-Mimecast-MFC-AGG-ID: mW72pzsWMMGtnVolyxWxqw_1775674863
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BC7B1956060;
	Wed,  8 Apr 2026 19:01:03 +0000 (UTC)
Received: from localhost (unknown [10.22.64.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 658771955D84;
	Wed,  8 Apr 2026 19:01:02 +0000 (UTC)
Date: Wed, 8 Apr 2026 16:01:01 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.252-rt148
Message-ID: <adal7eFyI7ckCSzm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.252-rt148 stable release.

This release is an RT-only update. All the changes here are specific to RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 226bc47dbb388ecf009cd2569e44b0c2c2125c7e

Or to build 5.10.252-rt148 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.252-rt148.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.252-rt147:
---

Jiayuan Chen (1):
      ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

Luis Claudio R. Goncalves (1):
      Linux 5.10.252-rt148
---
localversion-rt  |  2 +-
 net/ipv6/route.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
---
diff --git a/localversion-rt b/localversion-rt
index d3fa072b6b43..857407b62668 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt147
+-rt148
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b47f89600c2f..455f76f07e2e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1419,7 +1419,18 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 
 	p = this_cpu_ptr(res->nh->rt6i_pcpu);
 	prev = cmpxchg(p, NULL, pcpu_rt);
-	BUG_ON(prev);
+	if (unlikely(prev)) {
+		/*
+		 * Another task on this CPU already installed a pcpu_rt.
+		 * This can happen on PREEMPT_RT where preemption is possible.
+		 * Free our allocation and return the existing one.
+		 */
+		WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT));
+
+		dst_dev_put(&pcpu_rt->dst);
+		dst_release(&pcpu_rt->dst);
+		return prev;
+	}
 
 	if (res->f6i->fib6_destroying) {
 		struct fib6_info *from;

