Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55028688C
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334972; cv=none; b=SnU0k6h6BXP9aKkrl/3wA0/imUm1KC3ewi6KfRY6CwJCCTriqQ9IOE+wJZawwNyQc9IHuTxuMf0PtLmfg7jyawPmP5K0/NZOyeEIj/QbhAvGVbUlzqsRFrBVOiXx+QXJV7BwjMTchd0hOYMZUFGdNG67qQc/mAWgK9ZPHCBLTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334972; c=relaxed/simple;
	bh=mRWSzqWaAPbBsZcqjVkG+bh1UBceI5SVHDnP1e2imhE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ivviRWfpRV2Z4B9cqtt5AZ2rSA1233t9j7H4PUR2XMHTK+o04ptyepmeUJmiQb3+GdobuA5Thma12nhDcd9WxqBpi08cxUb2xzdo7gCj/dM66qZ4OhOTqoxQJUvEFF9l3A+AfmPE040d7e617NSvz5P93yf9e8b+ZUpltgM3k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g13LtAye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g13LtAye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771334970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=PRmg/W0wzWZVwb346QVotuTNgadWrQyRwDbYUeMZc7k=;
	b=g13LtAyeR0XxDmpB1JPkKrr+H5iupWUVFqTU5CWlt7oP/JewTrC51qd37vXxpB8obD4HBm
	ByFE5U6WZMF30HfhYyVwYhUcO9gV0EP+pCXn8CPtWiRVDFVeKvbeRrkchcMJqMBlzhdIyZ
	KJKUPt/zp7kGKJQI6qoCRfg6/1qjZrM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-YaaLT7zaN_yLajVl9MlTMA-1; Tue,
 17 Feb 2026 08:29:27 -0500
X-MC-Unique: YaaLT7zaN_yLajVl9MlTMA-1
X-Mimecast-MFC-AGG-ID: YaaLT7zaN_yLajVl9MlTMA_1771334966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6321956050;
	Tue, 17 Feb 2026 13:29:25 +0000 (UTC)
Received: from localhost (unknown [10.22.64.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9AF71800361;
	Tue, 17 Feb 2026 13:29:23 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:29:22 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.248-rt143
Message-ID: <aZRtMp_UWp08TtoL@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello RT-list!

I'm pleased to announce the 5.10.248-rt143 stable release.

This is basically kernel 5.10.248-rt142 with an extra patch suggested by
Ben Hutchings to fix a build problem introduced in 5.10.247-rt141.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: e1c3ac4207efdc4bd22fe82fef0aaa0ad1d8efcf

Or to build 5.10.248-rt143 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.248.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.248-rt143.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.248-rt142:
---

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Luis Claudio R. Goncalves (1):
      Linux 5.10.248-rt143
---
localversion-rt     | 2 +-
 net/sched/act_ife.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
---
diff --git a/localversion-rt b/localversion-rt
index 234720dc343d..a7cc5d609b19 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt142
+-rt143
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 892d4824d81d..e518e9b36486 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -648,9 +648,9 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 
 	memset(&opt, 0, sizeof(opt));
 
-	opt.index = ife->tcf_index,
-	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+	opt.index = ife->tcf_index;
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref;
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
 
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;

