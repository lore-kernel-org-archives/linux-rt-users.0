Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81FC25B0E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiHSJZC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbiHSJY7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FEBF2CAB;
        Fri, 19 Aug 2022 02:24:58 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySXmfVQPBEoU7V9GgVgXNe/KRz3scYHG27+RTT3RVlo=;
        b=k3yRZ330+QbNdPS5VgHBw3KlRR97K4dHNXfUxTT/p+DL0XZXEoYMtnoRlPF80babfavyj8
        u0sZsTEK2XdNOsZscxn15PlYZg3Z2jV57y/0RG3qU1NoJSnL397uMw3lEQcmxyYu6F1qak
        v4t2CVjJY/5AE0cRH8VMUetYPxXsOqeHv+yJn5oewg0KH6Nj+O9b56IcXFZJ0hyDmNPP5+
        HjjLKakpVq76kp1DczVabZND3dYed+ZihxL4mQ7v6EhMcD54YQxiqlDToKjmlSrSUsEnJv
        wRme7eXngXxllJBHetmfr7u8lgP5DTW+l9UDhWdKPIoGq1apURjJexUc4f/QQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySXmfVQPBEoU7V9GgVgXNe/KRz3scYHG27+RTT3RVlo=;
        b=EL614jE/FbyKjHXDTqrcpOo+H/4jxvJLSDn24hOcAHUCn0UkEiVpKM59/DhIZMrTg9gPCd
        ldrpzX1pypiBR8AQ==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 5/9] timers: Keep interrupts disabled for TIMER_IRQSAFE timer.
Date:   Fri, 19 Aug 2022 11:24:42 +0200
Message-Id: <20220819092446.980320-6-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Keep interrupts disabled across callback invocation for the
TIMER_IRQSAFE as expected.
This is required for the timer used by workqueue after the upcomming
rework.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af9d338103a9b..613139c7538eb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1381,8 +1381,7 @@ static void expire_timers(struct timer_base *base, st=
ruct hlist_head *head)
 		fn =3D timer->function;
 		data =3D timer->data;
=20
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
-		    timer->flags & TIMER_IRQSAFE) {
+		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
 			base->running_timer =3D NULL;
--=20
2.37.2

