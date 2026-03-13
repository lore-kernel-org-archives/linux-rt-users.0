Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC943AA512;
	Fri, 13 Mar 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415566; cv=none; b=YXQfz1n12z0wrOqpadG+DEmAaxvqs3UOwEyjXuJFe0w7To3FZb0r3u4qxc1DALgD6Fv119kNjs/hqlvvy8ATrtGLCBG/bAPRIS7LB3lTUSnIb+k9TjU1yU1uiHJi2RMbaQyhvVDI9K0m79DcdsuXEUsnHys67y3fhWvI6F/5PNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415566; c=relaxed/simple;
	bh=HaUINEZRWQYduTUSWdfnb8yMkBwav/7pP6wCgEDzxNA=;
	h=From:Subject:Date:Message-ID:To; b=FMS45jT6G/rLc64kydo5FZQM89SZNHOjEGQ4912kFoa05A/3l218lswcKJvc92luK7oZ4nWwSllWBOFPvDyhRkZ2VWEA4Uyf64AYYAkIew/2zbfH99fKdeEOZyn7hbsRR7x2KPn/fHll2QV3MUuvd2GhRqKDDxdsZFg8B32zz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19B7C2BC87;
	Fri, 13 Mar 2026 15:26:05 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.201-rt93
Date: Fri, 13 Mar 2026 15:22:21 -0000
Message-ID: <177341534116.914902.15835182269280039713@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.201-rt93 stable release.

This release contains a single new patch, which is an RT specific commit:

1adaea51c61b ("ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT")

New patch name:
0183-ipv6-fix-a-BUG-in-rt6_get_pcpu_route-under-PREEMPT_R.patch

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 3bd063531b598d0de0083b820901df5319a71769

Or to build 5.15.201-rt93 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.201.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.201-rt93.patch.xz


Enjoy!
Joseph Salisbury

Changes from v5.15.201-rt92:
---

Jiayuan Chen (1):
      ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT

Joseph Salisbury (1):
      Linux 5.15.201-rt93
---
localversion-rt  |  2 +-
 net/ipv6/route.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
---
diff --git a/localversion-rt b/localversion-rt
index 4905d52a48284..e98a1fe050bde 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt92
+-rt93
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f30a5b7d93f4d..3536192438cea 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1424,7 +1424,18 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 
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
