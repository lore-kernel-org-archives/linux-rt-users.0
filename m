Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FEC3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598B2184D
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfH0O00 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:26:26 -0400
Received: from mail.thorsis.com ([92.198.35.195]:46055 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfH0O0Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 10:26:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id B642C4E3C;
        Tue, 27 Aug 2019 16:27:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6TzvyJAVDxTa; Tue, 27 Aug 2019 16:27:30 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 978834F13; Tue, 27 Aug 2019 16:27:30 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Date:   Tue, 27 Aug 2019 16:26:20 +0200
Message-ID: <1983406.XYedcDVy8E@ada>
In-Reply-To: <20190827132200.uj44quypjsqu3oup@linutronix.de>
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de> <1775495.KgcFvHdtex@ada> <20190827132200.uj44quypjsqu3oup@linutronix.de>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Sebastian,

Am Dienstag, 27. August 2019, 15:22:01 CEST schrieb Sebastian Andrzej Siewior:
> of course, !SMP. What about this:
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -934,7 +934,11 @@ void hrtimer_grab_expiry_lock(const struct hrtimer
> *timer) {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
> 
> +#ifdef CONFIG_SMP
>  	if (timer->is_soft && base != &migration_base) {
> +#else
> +	if (timer->is_soft && base && base->cpu_base) {
> +#endif
>  		spin_lock(&base->cpu_base->softirq_expiry_lock);
>  		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>  	}

Build error is gone and target system boots successfully, seems to work fine 
at first sight. Thanks for the quick response.

Greets
Alex

