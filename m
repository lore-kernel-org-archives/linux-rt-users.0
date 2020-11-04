Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C88AC388F9
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958AE2074B
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6U8IuJx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IF9+NXuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgKDPMt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDPMt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 10:12:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A98C0613D3;
        Wed,  4 Nov 2020 07:12:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604502765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHy+znafm/VyROcHvLpycULzJCGKvQvcCR6rmrfdldQ=;
        b=e6U8IuJxtG+Q+uz7AeunWosCEZjyHrzQPNRHrfw60TfFZl9Fq44C2WMnk0kWXuPiT+FMHB
        +86HzLSQuhEFRo7B9OaGDu4QjmOrU+PVT7nt8AIaMai6tEcNAJIKzjlT0ZEitPk5OpUKAs
        AdzaeW7vnR14gRag9mouf6v/hq4m33IjlkDNBp/wrQ7OcbJnHcQQoqUROhrc6X7ScE4uT+
        pRxcbKBCqPCRDhATA99z1H97mgJaiHIJzbdoTA49eLUf1vTW6qxu6XDegiTa0dDXHJqde+
        NrYMdH9cqbso6flrWubT6ztoZxNYddBYJiCic/etk/uUsHAHBMCRuoX9+IPvJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604502765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHy+znafm/VyROcHvLpycULzJCGKvQvcCR6rmrfdldQ=;
        b=IF9+NXuFztp+x16ZEFmqfhirR3N2axqAA1SitxW4k5Am6sms24TnYzKRehJ06bQm9++OjY
        HF/z/NVBiFTio7Dg==
To:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] futex: Handle transient "ownerless" rtmutex state correctly
In-Reply-To: <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com> <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de> <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de> <874km5mnbf.fsf@nanos.tec.linutronix.de> <871rh9mkvr.fsf@nanos.tec.linutronix.de> <87v9ell0cn.fsf@nanos.tec.linutronix.de> <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de>
Date:   Wed, 04 Nov 2020 16:12:44 +0100
Message-ID: <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Mike Galbraith <efault@gmx.de>

Gratian managed to trigger the BUG_ON(!newowner) in fixup_pi_state_owner().
This is one possible chain of events leading to this:

Task Prio       Operation
T1   120	lock(F)
T2   120	lock(F)   -> blocks (top waiter)
T3   50 (RT)	lock(F)   -> boosts T3 and blocks (new top waiter)
XX   		timeout/  -> wakes T2
		signal
T1   50		unlock(F) -> wakes T3 (rtmutex->owner == NULL, waiter bit is set)
T2   120	cleanup   -> try_to_take_mutex() fails because T3 is the top waiter
     			     and the lower priority T2 cannot steal the lock.
     			  -> fixup_pi_state_owner() sees newowner == NULL -> BUG_ON()

The comment states that this is invalid and rt_mutex_real_owner() must
return a non NULL owner when the trylock failed, but in case of a queued
and woken up waiter rt_mutex_real_owner() == NULL is a valid transient
state. The higher priority waiter has simply not yet managed to take over
the rtmutex.

The BUG_ON() is therefore wrong and this is just another retry condition in
fixup_pi_state_owner().

Drop the locks, so that T3 can make progress, and then try the fixup again.

Gratian provided a great analysis, traces and a reproducer. The analysis is
to the point, but it confused the hell out of that tglx dude who had to
page in all the futex horrors again. Condensed version is above. 

[ tglx: Wrote comment and changelog ]

Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/87a6w6x7bb.fsf@ni.com
---
 kernel/futex.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2380,10 +2380,22 @@ static int fixup_pi_state_owner(u32 __us
 		}
 
 		/*
-		 * Since we just failed the trylock; there must be an owner.
+		 * The trylock just failed, so either there is an owner or
+		 * there is a higher priority waiter than this one.
 		 */
 		newowner = rt_mutex_owner(&pi_state->pi_mutex);
-		BUG_ON(!newowner);
+		/*
+		 * If the higher priority waiter has not yet taken over the
+		 * rtmutex then newowner is NULL. We can't return here with
+		 * that state because it's inconsistent vs. the user space
+		 * state. So drop the locks and try again. It's a valid
+		 * situation and not any different from the other retry
+		 * conditions.
+		 */
+		if (unlikely(!newowner)) {
+			ret = -EAGAIN;
+			goto handle_err;
+		}
 	} else {
 		WARN_ON_ONCE(argowner != current);
 		if (oldowner == current) {
