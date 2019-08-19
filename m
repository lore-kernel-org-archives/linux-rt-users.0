Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0094C3A59B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 07:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9BE21852
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 07:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHSHdZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:33:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHdZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 03:33:25 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hzcAM-0006WM-3i; Mon, 19 Aug 2019 09:33:22 +0200
Date:   Mon, 19 Aug 2019 09:33:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        anna-maria@linutronix.de,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: KVM Arm64 and Linux-RT issues
Message-ID: <20190819073321.b3q2bxnslwwmdssn@linutronix.de>
References: <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
 <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
 <86zhkzn319.wl-maz@kernel.org>
 <960b5ed1-6d0f-3cee-da37-6061b4946c1a@arm.com>
 <20190813125835.5v26s4iuv44lw2xg@linutronix.de>
 <adc0b2e2-3a2e-5685-8eb5-2ce927d2139e@arm.com>
 <865zn1nidx.wl-maz@kernel.org>
 <1f76c277-665a-e962-8cbe-b3c4ecad41b0@arm.com>
 <20190816152317.pbhctfiyurjrepju@linutronix.de>
 <e9a77a95-ce0e-27a4-acb0-e997eb656e14@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e9a77a95-ce0e-27a4-acb0-e997eb656e14@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-16 17:32:38 [+0100], Julien Grall wrote:
> Hi Sebastian,
Hi Julien,

> hrtimer_callback_running() will be returning true as the callback is
> running somewhere else. This means hrtimer_try_to_cancel()
> would return -1. Therefore hrtimer_grab_expiry_lock() would
> be called.
> 
> Did I miss anything?

nope, you are right. I assumed that we had code to deal with this but
didn't find it…

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7d7db88021311..40d83c709503e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = timer->base;
 
-	if (base && base->cpu_base) {
+	if (base && base->cpu_base && base->index < MASK_SHIFT) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}

This should deal with it.

> Cheers,

Sebastian
