Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF9C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Jul 2022 07:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiGMHuu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiGMHus (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Jul 2022 03:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D84C313A4
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 00:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657698646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UUUAyRjzYTQJMt+N0hTGhBJ/lch625duUKNPGtSQaX4=;
        b=RxLFJCO9g3+H8Op5wKse5Dly+6fEFsbhf9475+2IhpCLZGUh+z1fxMhUdxgt9fK5LZ7aJB
        X1+Uzmlm27uyHYn2MKIoht87I6y2GpsBQXJ8JTzQBP1Q8VSbICM7NQse7nsBTsfTF5+LY7
        Hj4uHkEGo47piBg4MI+x7xr2z1oll5A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-LySI4K8NNx2t5MiSomc-rQ-1; Wed, 13 Jul 2022 03:50:39 -0400
X-MC-Unique: LySI4K8NNx2t5MiSomc-rQ-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003a19b3b9e6cso718639wma.5
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUUAyRjzYTQJMt+N0hTGhBJ/lch625duUKNPGtSQaX4=;
        b=P2nY5Mz3RvAYNs+PTWUgMWZibY4Z40ZgD5K6W35cuocVTf3r4eloqNhfDQaDyFGgMC
         kgI3nbZv08O4NhX5VxgRdgfqbS2lrgVfK4DBoczQIFXP9k0kbhf1nwhT9U2KdglDVWho
         BEVqcZW0Xhzow/Q1X4Zp3x7GOOb7YlHvTyoorW4+CnzRBTfFZwa6cpCH6XVdZJ1tyd9x
         6YOFmYQyb/IZQRiVtS+adoXwE+GBzidIXcdx0hEBk+gPz3cSVJiaXgmrrDesq/DeAoJg
         1FF8CfFVg6i1Egm+f3brmQWk34gkYccIS22RaMmBYq9oYDshj1vpYu24NzLWaO+hwbXk
         G6cQ==
X-Gm-Message-State: AJIora9sJkUrW8hGjpQZgy7kKFYCWQRw/sX1uGWcaaCODUyl9E1+okaP
        a+gMorp5042coDF/f2yrbgog9gTbQxJxwMC/z/PNEuHWxSuLnqagnJw/eFhp8Aa/5apk023Aeuz
        rKZH8TYf8OZzql9/2xU30ves9LNE=
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr1868509wrx.546.1657698638210;
        Wed, 13 Jul 2022 00:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVAaqjUmmT74Sd86HbMQeLDUALnySAzJYvk/gvhv1S4gh1URgjketeKTeNtjKaCdqglG2bdQ==
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr1868479wrx.546.1657698637897;
        Wed, 13 Jul 2022 00:50:37 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0021db7b0162esm2220413wrs.105.2022.07.13.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:50:37 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Date:   Wed, 13 Jul 2022 09:50:14 +0200
Message-Id: <20220713075014.411739-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Tasks the are being deboosted from SCHED_DEADLINE might enter
enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
since they are not boosted anymore, the if (is_dl_boosted()) branch is
not taken, but the else if (!dl_prio) is and inside this one we
BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
otherwise we had entered the if branch above. Long story short, the
current condition doesn't make sense and always leads to triggering of a
BUG.

Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
to be present, but additional flags are not a problem.

Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5867e186c39a..0447d46f4718 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1703,7 +1703,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		 * the throttle.
 		 */
 		p->dl.dl_throttled = 0;
-		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
+		BUG_ON(!(flags & ENQUEUE_REPLENISH));
 		return;
 	}
 
-- 
2.36.1

