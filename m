Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD631C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC162339F
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfHUNtt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:49:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUNtt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 09:49:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Qzi-0005Rm-Av; Wed, 21 Aug 2019 15:49:46 +0200
Date:   Wed, 21 Aug 2019 15:49:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, maz@kernel.org, rostedt@goodmis.org
Subject: Re: [RT PATCH 2/3] hrtimer: Don't grab the expiry lock for non-soft
 hrtimer
Message-ID: <20190821134946.iyzfxv63mvhhqxox@linutronix.de>
References: <20190821092409.13225-1-julien.grall@arm.com>
 <20190821092409.13225-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821092409.13225-3-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-21 10:24:08 [+0100], Julien Grall wrote:
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index b869e816e96a..119414a2f59c 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
>  {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
>  
> -	if (base && base->cpu_base) {
> +	if (timer->is_soft && base && base->cpu_base) {
>  		spin_lock(&base->cpu_base->softirq_expiry_lock);
>  		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>  	}

right, much simpler.

Sebastian
