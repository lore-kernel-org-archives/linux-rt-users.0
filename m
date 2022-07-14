Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2772C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jul 2022 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiGNPT2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbiGNPT1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Jul 2022 11:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48C364C631
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jul 2022 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657811965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3g/51Am7hhNBKok4aSvT7atGRsltefp8gJyPRmGJItU=;
        b=TaP3dB1hkHqjuo1+RZe/sejN8XD5XWaHO/EDYdZsI/Fq4iA3cJlCiwshxF0mnWI6bNfGsO
        NX2s3z9jkpdk6ZDgIbaqJzrtICId+/asG+B9V3oun293aGhFQflabQfahEmP0DBnOw64PG
        9lZLv2rU2wu1l8vOGif4uRbMmZPTXM0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-384jWHiUM1mBB6t9-YJxhA-1; Thu, 14 Jul 2022 11:19:24 -0400
X-MC-Unique: 384jWHiUM1mBB6t9-YJxhA-1
Received: by mail-qt1-f199.google.com with SMTP id u2-20020ac80502000000b002f94701339eso1703583qtg.13
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Jul 2022 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3g/51Am7hhNBKok4aSvT7atGRsltefp8gJyPRmGJItU=;
        b=nIpEIyUbz2vJwcj8LD+f9TzkCvdo9bif5i4EJYyz+iroM5qs/CM6hDgmzMr70NS5MC
         OZvaHI2WnQOVLgGwLJikrC23qLXNgNZ9rQKm4r9U5fQ//WGgz3f2fszdA+UCYXk3zbmE
         d3oaSmXUYQKYHNsB7GXOAKvaq1CAAqXdbYOCwmnJBF2a2F8SiDnwRg/8Hk7yD7wAMOZC
         JAB7BC2gEl5xysRRpN51dJzcl0XTwwaLN+3CcHbheyoIc/C8KkQiqBw0efjUuPmGGm6y
         1RJCbfwA5yEgT81C4W4lAj77AD5v5cTi7O7HAliKYxPz7w5L0sLLjzkk2J7NBFP150GS
         XW7w==
X-Gm-Message-State: AJIora/Rgb1LqVhzBZIcF1kJHdjfE8dKQ/vo+vqUnXWf9jdeVlqF9NUv
        Oj5E8NL64faDjKd67VgHUaaWaKR9COMyk9eqXOgLHR6fGQE0q8wn08vRqZTTw9lfcDFTjSgNEDD
        35M8wMZP1/GYc7Tp/Fx3u+hcphys=
X-Received: by 2002:ac8:7fcf:0:b0:31e:cb6f:2487 with SMTP id b15-20020ac87fcf000000b0031ecb6f2487mr7776892qtk.528.1657811961170;
        Thu, 14 Jul 2022 08:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuDG1f+p3VMd/jpv+jcJjxRHrYm4T6wO2lWr00narn1rhXbhrgFy56BIisbhuc7XIW2VKVrw==
X-Received: by 2002:ac8:7fcf:0:b0:31e:cb6f:2487 with SMTP id b15-20020ac87fcf000000b0031ecb6f2487mr7776859qtk.528.1657811960888;
        Thu, 14 Jul 2022 08:19:20 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.62.255])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a445200b006a37c908d33sm1662031qkp.28.2022.07.14.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:19:20 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v2] sched/deadline: Fix BUG_ON condition for deboosted tasks
Date:   Thu, 14 Jul 2022 17:19:08 +0200
Message-Id: <20220714151908.533052-1-juri.lelli@redhat.com>
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

Fixes: 64be6f1f5f71 ("sched/deadline: Don't replenish from a !SCHED_DEADLINE entity")
Cc: stable@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
v1->v2
 - Make detection of faulty condition less fatal [Peter Zijlstra]
 - Cc stable and update fixes tag [Srivatsa S. Bhat]
---
 kernel/sched/deadline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5867e186c39a..0ab79d819a0d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1703,7 +1703,10 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		 * the throttle.
 		 */
 		p->dl.dl_throttled = 0;
-		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
+		if (!(flags & ENQUEUE_REPLENISH))
+			printk_deferred_once("sched: DL de-boosted task PID %d: REPLENISH flag missing\n",
+					     task_pid_nr(p));
+
 		return;
 	}
 
-- 
2.36.1

