Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF181C32772
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbiHSJZB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347715AbiHSJY5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D1F2CAF;
        Fri, 19 Aug 2022 02:24:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj6l0sOFTFP1mnRa3jwuVGAZkLkx4JEWQDKna3c6AeU=;
        b=i0FtIACT3+YPfufxGVdqizjMTc92Htf4UDZkf2KSOMJfe+Xbf6guRbofUBMb1ap6fSEeCU
        ZaPNrpfmkmqosdQJNQwLtyITRAjz3JjEQMr+mgnimhZdBlpy23RV15XFMrmrs95SOosF1f
        efCq+vRSgLX4IyUyUqU3LisMPKMon8n8c8T9WY42kr1sazPTBtFhAo3/EP3mRizzYI8O4I
        5Mt4SmTFJSj4hegFQlPSvOEAFemK+i5Nlo5FDxqIy2sJkbFkfh0cSPATPN+mQx+H6Q90CB
        gy1dYy3PnhY6j0ZV5gw+L3zh+qu3+KqASG7ZjPEqBcM9uERaojbKwaMnS9nFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj6l0sOFTFP1mnRa3jwuVGAZkLkx4JEWQDKna3c6AeU=;
        b=jFkNEuk/NFO00Dn7NLw5+NwtKDqevZhBbIm01g4uJCCbGMo5oDrkn6I7fFWDCN/QK9i7Fj
        vsOw9ZazxTe04CBg==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 2/9] random: schedule mix_interrupt_randomness() less often
Date:   Fri, 19 Aug 2022 11:24:39 +0200
Message-Id: <20220819092446.980320-3-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

Upstream commit 534d2eaf1970274150596fdd2bf552721e65d6b2

It used to be that mix_interrupt_randomness() would credit 1 bit each
time it ran, and so add_interrupt_randomness() would schedule mix() to
run every 64 interrupts, a fairly arbitrary number, but nonetheless
considered to be a decent enough conservative estimate.

Since e3e33fc2ea7f ("random: do not use input pool from hard IRQs"),
mix() is now able to credit multiple bits, depending on the number of
calls to add(). This was done for reasons separate from this commit, but
it has the nice side effect of enabling this patch to schedule mix()
less often.

Currently the rules are:
a) Credit 1 bit for every 64 calls to add().
b) Schedule mix() once a second that add() is called.
c) Schedule mix() once every 64 calls to add().

Rules (a) and (c) no longer need to be coupled. It's still important to
have _some_ value in (c), so that we don't "over-saturate" the fast
pool, but the once per second we get from rule (b) is a plenty enough
baseline. So, by increasing the 64 in rule (c) to something larger, we
avoid calling queue_work_on() as frequently during irq storms.

This commit changes that 64 in rule (c) to be 1024, which means we
schedule mix() 16 times less often. And it does *not* need to change the
64 in rule (a).

Fixes: 58340f8e952b ("random: defer fast pool mixing to worker")
Cc: stable@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by:: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 860dc427000e9..40c97d09aeadc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1002,7 +1002,7 @@ void add_interrupt_randomness(int irq)
 	if (new_count & MIX_INFLIGHT)
 		return;
=20
-	if (new_count < 64 && !time_is_before_jiffies(fast_pool->last + HZ))
+	if (new_count < 1024 && !time_is_before_jiffies(fast_pool->last + HZ))
 		return;
=20
 	if (unlikely(!fast_pool->mix.func))
--=20
2.37.2

