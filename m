Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B3C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 07:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698E160EC0
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 07:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHEHAZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:00:25 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:49298 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHEHAZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 03:00:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7936A5E3F6;
        Thu,  5 Aug 2021 09:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1628146810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=sBnw6VrFx5VEjNLQ2c5cKD6rn/cZTE5HdUq027f8t8Y=;
        b=CjegqgPEaX1E9LbSnKxH7OtqHMB2su3yHi6rLENcAdqO2uuKAEQvNJNZxjFy5tWTxJx5R8
        Vq5CciyB2MsxDEWa2doYFTBpb4atJm5NU3shU9CVqZy4PNKLcV/nj+iyKzKITkFljpmg/g
        90NVUoJUy+ETslRAoW5g2+bNJrmQL4A3GdYvgtDwoua41hb89wcy0BUQZ4kQzY/+Qs/c7k
        BYxHo/P/k9lvidk+SYXcshQCdtOHLAJyPrCk3oaIXT7izPf0Ops5xku2SvhY229/OqwVSW
        YGsLmYqrST2woHGqh38zulmCPnI2eO/kmWXNirYbjHyhNQ8go/0iqa2AJ4CVfA==
Date:   Thu, 5 Aug 2021 09:00:08 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
Message-ID: <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
 <20210805063123.mj4rggncauziryv4@beryllium.lan>
 <20210805065351.c7eieltqihduwisr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805065351.c7eieltqihduwisr@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 05, 2021 at 08:53:53AM +0200, Daniel Wagner wrote:
> On Thu, Aug 05, 2021 at 08:31:23AM +0200, Daniel Wagner wrote:
> > Just a heads up. I get these build errors:
> 
> I suppose this should be:

and while at it, there are two more compile errors. The first one is
obvious, the second one is just guessing.

diff --git a/kernel/futex.c b/kernel/futex.c
index c05a33a2f865..41e3d63160a7 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1896,14 +1896,14 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
                if (locked >= 0) {
                        /* Requeue succeeded. Set DONE or LOCKED */
                        WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
-                                    old != Q_REQUEUE_PI_WAIT)
+                                    old != Q_REQUEUE_PI_WAIT);
                        new = Q_REQUEUE_PI_DONE + locked;
                } else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
                        /* Deadlock, no early wakeup interleave */
                        new = Q_REQUEUE_PI_NONE;
                } else {
                        /* Deadlock, early wakeup interleave. */
-                       WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_WAIT);
+                       WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
                        new = Q_REQUEUE_PI_IGNORE;
                }
        } while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
