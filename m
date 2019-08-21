Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D9C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78645206BA
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfHUOC6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:02:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUOC5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 10:02:57 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0RCQ-0005xS-UK; Wed, 21 Aug 2019 16:02:55 +0200
Date:   Wed, 21 Aug 2019 16:02:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org
Subject: Re: [RT PATCH 3/3] hrtimer: Prevent using uninitialized spin_lock
 in hrtimer_grab_expiry_lock()
In-Reply-To: <20190821092409.13225-4-julien.grall@arm.com>
Message-ID: <alpine.DEB.2.21.1908211557420.2223@nanos.tec.linutronix.de>
References: <20190821092409.13225-1-julien.grall@arm.com> <20190821092409.13225-4-julien.grall@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 21 Aug 2019, Julien Grall wrote:

> migration_base is used as a placeholder when an hrtimer is switching
> between base (see switch_hrtimer_timer_base). It is possible
> theoritically possible to have timer->base equal to migration_base.
> 
> Even if it is a placeholder, it would pass all the current check in
> hrtimer_grab_expiry_lock() leading to use softirq_expiry_lock
> uninitialized.
>
> This is can be prevented by checking whether the base is equal to
> the placeholder (i.e. migration_base).

That's a lame argument. The point is that it does not make sense to do that
on migration base, but not for the reason you are giving (uninitialized
lock).

If base == migration_base then there is no point to lock soft_expiry_lock
simply because the timer is not executing the callback in soft irq context
and the whole lock/unlock dance can be avoided.

But, yes. Good catch.

Thanks,

	tglx
