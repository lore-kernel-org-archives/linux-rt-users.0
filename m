Return-Path: <SRS0=Ir0P=V4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40736C433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225C3206A3
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfGaKhk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:37:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfGaKhk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Jul 2019 06:37:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so69072583wru.10
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jul 2019 03:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8iV1zA5X3Fl6os5LyVIh5yLsEGaYfREzD+XcT87bP0=;
        b=hhjpF9OXoxFkweLVvfOmgk0kiCwGVS1x7qXgnx+H5joQ6kBpHSMa7ZPoAc2VQLlZcc
         8bGJjUW4xXtnLkzqod1I5hRaWkSlCtHDtmxL6kbxhYoSr1gEOUyaaxNDzKJqzPof5udC
         8VtNUCn4RcOK2an/AUPM820OoEkwL3PMGi/Tdiu6M2AJBaM8reOwPFLo8ZRFN0rx944s
         zb5dpSx/NrJDLEVPhZu8MwF7kzWy7Apsy1dH9Q7QBMNSrIkUOELzijxg1PhXsiAEj9GD
         0v+IcCuvQnDLLOUGhO5qhMS0/SNcx3ky3/ftWDIoiF70oC133nYtXiDDQhbcMgDDKM2E
         JFiw==
X-Gm-Message-State: APjAAAWigdh1i3Qm82pxOhGoQr7mFosA57agpy5NwwuQs0BXRscQisYR
        U4+fzuJbW9QFpIvH7LU6hQyiEg==
X-Google-Smtp-Source: APXvYqzD5GnZ2oX3ivmVwh9gHiLMdPlFIqAWZvrVxayj9sB0Cvqa9vaVFTrf5abCsI1zTL6R9RzbFw==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr5644912wrp.188.1564569458406;
        Wed, 31 Jul 2019 03:37:38 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id s2sm55015229wmj.33.2019.07.31.03.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 03:37:37 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RT PATCH] sched/deadline: Make inactive timer run in hardirq context
Date:   Wed, 31 Jul 2019 12:37:15 +0200
Message-Id: <20190731103715.4047-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SCHED_DEADLINE inactive timer needs to run in hardirq context (as
dl_task_timer already does).

Make it HRTIMER_MODE_REL_HARD.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

Both v4.19-rt and v5.2-rt need this.

Mainline "sched: Mark hrtimers to expire in hard interrupt context"
series needs this as well (20190726185753.077004842@linutronix.de in
particular). Do I need to send out a separate patch for it?

Best,

Juri
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1794e152d888..0889674b8915 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
-- 
2.17.2

