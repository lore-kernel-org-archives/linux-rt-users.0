Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198823;
	b=r6lZSjCJayQs0aWaN0Af8qUQ66Ma0IIkqeK7YDY8yfVw7ykVX4Q6NtxZA4n3fsK/AyVv
	 j5wPU3Ck28QeaTbCjAIIOPZIDZxNvj6poHHtPfQcoom4iycwGQZpHTKqq8h2mbeBM6/+x
	 HJPim90dncqzWRaABYD4mBWpvxPh6Bubtjeh3KoDN/PB4Y/5i7+G9S5L6e0XS598yn2Ig
	 RRpahE9CDp9+1MgJ250UgtS2BXftJCskS+vfgK+rLfcS464jTTAjiYs1jVfZeclsC+lL9
	 jXjHl6bGyjtqnkYSxo68MZ9kCJC9YWOUmTYLWQIrLUDVkBu41ycT6QzvVZZGS8sOhlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
	b=sw9ZNpd7nC1tqr66oZW7Ed+H7syGbfnk6mVpwAT2NGrEefJTzcl/rEsIGIX1dHJZDITn
	 19v6WHpgAE9WoSu1y8tIEDOqJQSLBycK7CMEZUmNTFwQjOSqCheByNaH/RDNVmZBir++3
	 EImUY540mGGBkHOnB1/1TYs5c3wprnUcfLWOGTGGeJPK2/Ai6o5IQMBEnLxCkNj5R40ME
	 n+JjYnAId2hjzteQINdd1NEjjkQmlHyriCdztNJ97MAG+zxo7jsLb4gLNt06GXRQZ4neK
	 mdkfN+q7YX7fEd5vUD3h4O8Bd280uwtQcDisxd/GZpiDXx7qGNI4P2uL4vnzyCfHhDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIqoiPHl;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085A606B44D
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 18:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6085A606B44D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIqoiPHl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so11161445e9.3
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198817; x=1795803617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
        b=SIqoiPHl4PvkvH3uNUmWwM+jmheKQz3gILJ8Bof2Xhfc/jlWKFryJC7rR+YUM7AwFy
         3WI23dfrODgmpMtus3eKndATKXoncXM0853HMuJlAmDxHHpHDaEL9O+GQjIliaubfDYu
         SkJjEODQK47/wialIiZ0TThDTPpnIv+yp6RE7VgaqmfBD0/hXzFJG6pdlrboDGYCZbuQ
         M7t8NcUWjsGpeeLfkVc8X+6WQErPsUoM8aaI3Lru1ezHaPlXJZ9jGLYbAf79JkrgCzos
         QZqwfLMoWdrW4SYE8C6uEkxect7i6LirnNeLgnb81xSrtmP2TXSNwvI/rId9TG7Tb567
         WXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198817; x=1795803617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
        b=E31JaWBi3waTwp2sQryRTmzFsXgLLm4pt9lzaQq0ONl8nzs1XRDGaoHVeNWvxKRlna
         m9vTrMoei4UrTdFVXQHB5VAaEN3huDYu7NF0UOmHKbB5VFFXsVR0gtZ6tCAMSfwSiICV
         JI0YS5ukwM950gOe6+pI+kEEJRMGE7lkQD6SzEwzkwq0fOSoXuu0L9ewP0LAkX5hIeAc
         VN1slVOU2dEgDNS9KNQOUhwO/aIxs06OSYuVCx7iBTh1dmlNJ1jGOggNxKHFIGJ6NAMB
         WsdnY3XWilAvoSxV7AjJ+lHCZx0hATiYCDNk9uy4kJxQf4LApobGTipoA5h/nfq2O+zu
         xbQw==
X-Forwarded-Encrypted: i=1; AL+hErH3HQs7jyKlOsCBqHOckab6HG164L4biTffySLGkMQxW1dzO7WQWaoIEVFRKUM+pBJ2CvG55I7wV0zCuyJu/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2R9Yc8vOKhcGnRER0H5za3iF0nlU0+UEbTclfCY7y9Kdw/QhM
	j1I+T347wgUNqlk29wq/UsLqqTCkmx5aZUq0L9qs0PyRYaGZLVLl2LvGe9ubWQ==
X-Gm-Gg: AYBFou0Xz6sk5D8CtTYk6LG4FUZMQocPSC74rhsKdIAE5j9+lDWxHk5CpIl6pHyOLBq
	oJ1Oc39H+Mc6C+dpv1EdSgmjVm2w8BJJGFsh0gv6hw9WLZtuPUufSR3EqvDv4Ek2GUb+MjDHt5l
	Ktdzyfy4+nyPGNbWpn7w7akxrfmk+sdej774pUfiarKBGM8U8vC0UIckS2wW9YSLmU1bCVB7YNW
	cSdfQqUN1oE10P8d1WomsqVe1MXz6fQZ7FXUD1bDkdNIeLZxnQKpwfUBWFmTH7ccqEsXHurlGdq
	gfdv6yNkrP0gSyuTLzeRvUqiNCIiGlaSeEWR/BGBEyzLIkO5o+K3qB4H/3laXYnFsHkj3LiINaY
	cY5aJWnVhWtEC8shY4RcxF2U7OcWsKeJ2qTIcRqMeyarWQIz4YV00N7uV6W+9SU/gwuhs8QDgPz
	TlJgFpD6R0LQMrGVRx2etql28s/isRwKWyY4yuMk8E7zZ7SdOYML4yKyPlJlpp8/1qclJPvQk0n
	sFQmgsBk3uEK3Smxe/QMZPzRJyRpbtvGGtYc3eerdT5TOCV+sL0MZl8xI7ixsjG74XkcRhTOhrF
	nGJZG1PA5XvaTm+/FIkJqHbmNbguwt2OpxAWvjWJiNVDADQ/btjp7s8q1wwQFKzrCSrDu2dx3Rw
	rhwQz2JuEHO3qpmhwW4+6zsoYTw29jdmJKX7m0HpTyaR+/vQ=
X-Received: by 2002:a05:600c:1c28:b0:4bb:867b:f0f0 with SMTP id 5b1f17b1804b1-4bb88810708mr105298155e9.15.1795198816718;
        Fri, 20 Nov 2026 10:20:16 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:16 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 4/4] sched/deadline: Fix server stopping with runnable tasks
Date: Fri, 20 Nov 2026 19:19:49 +0100
Message-Id: <20261120181949.7528-5-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
 <20261120181949.7528-1-fcarli@gmail.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

commit ca1e8eede4fc68ce85a9fdce1a6c13ad64933318 upstream.

The deadline server can currently stop due to idle although fair tasks
are runnable. This happens essentially when:

 * the server is set to idle, a task wakes up, the server stops
 * a task wakes up, the server sets itself to idle and stops right away

Address both cases by clearing the server idle flag whenever a fair task
wakes up and accounting also for pending tasks in the definition of idle.

Fixes: f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260113085159.114226-3-gmonaco@redhat.com
[ Florent: context conflict in dl_server_start(), which still
  initializes the fair server in 6.12 ]
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 kernel/sched/deadline.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ea64ab436..2da68de70 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1482,7 +1482,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se, int
 
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	bool idle = rq->curr == rq->idle;
+	bool idle = idle_rq(rq);
 	s64 scaled_delta_exec;
 
 	if (unlikely(delta_exec <= 0)) {
@@ -1663,8 +1663,8 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  * | 8 |       B:zero_laxity-wait       |     |    |
  * |   |                                | <---+    |
  * |   +--------------------------------+          |
- * |     |              ^     ^           2        |
- * |     | 7            | 2   +--------------------+
+ * |     |              ^         ^       2        |
+ * |     | 7            | 2, 1    +----------------+
  * |     v              |
  * |   +-------------+  |
  * +-- | C:idle-wait | -+
@@ -1709,8 +1709,11 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   dl_defer_idle = 0
  *
  *
- * [1] A->B, A->D
+ * [1] A->B, A->D, C->B
  * dl_server_start()
+ *   dl_defer_idle = 0;
+ *   if (dl_server_active)
+ *     return; // [B]
  *   dl_server_active = 1;
  *   enqueue_dl_entity()
  *     update_dl_entity(WAKEUP)
@@ -1825,6 +1828,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   "B:zero_laxity-wait" -> "C:idle-wait"        [label="7:dl_server_update_idle"]
  *   "B:zero_laxity-wait" -> "D:running"          [label="3:dl_server_timer"]
  *   "C:idle-wait" -> "A:init"                    [label="8:dl_server_timer"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="1:dl_server_start"]
  *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="2:dl_server_update"]
  *   "C:idle-wait" -> "C:idle-wait"               [label="7:dl_server_update_idle"]
  *   "D:running" -> "A:init"                      [label="4:pick_task_dl"]
@@ -1850,6 +1854,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	dl_se->dl_defer_idle = 0;
 	/*
 	 * XXX: the apply do not work fine at the init phase for the
 	 * fair server because things are not yet set. We need to improve
-- 
2.39.3 (Apple Git-146)

