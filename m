Return-Path: <SRS0=USbd=57=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95BBC2BB55
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C0C2074F
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408827AbgDOKj7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:39:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408824AbgDOKjv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Apr 2020 06:39:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <sebastian.siewior@linutronix.de>)
        id 1jOfSL-0006mo-IP; Wed, 15 Apr 2020 12:39:45 +0200
Date:   Wed, 15 Apr 2020 12:39:45 +0200
From:   Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
To:     Andreas Hoefler <andreas.hoefler@ch.abb.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: pthread_mutex_timedlock can not be used with CLOCK_MONOTONIC?
Message-ID: <20200415103945.cdg2pxykkorhrvmm@linutronix.de>
References: <AM0PR06MB41964EB6F36427417BDB3F91CEC30@AM0PR06MB4196.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM0PR06MB41964EB6F36427417BDB3F91CEC30@AM0PR06MB4196.eurprd06.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-07 10:22:03 [+0000], Andreas Hoefler wrote:
> The first attempt of a solution was to use a different clock
> (CLOCK_MONOTONIC), which works fine when using conditional attributes
> (pthread_condattr_setclock in combination with pthread_cond_init) but
> unfortunately there does not seem to be a corresponding
> pthread_mutex_setclock(MISSING) for pthread_mutex_init.
>  
> Is there an good alternative for pthread or can the pthread library
> somehow be utilized for this purpose?

From glibc 2.30 announcement [0]:
|* Add new POSIX-proposed pthread_cond_clockwait, pthread_mutex_clocklock,
|  pthread_rwlock_clockrdlock, pthread_rwlock_clockwrlock and sem_clockwait
|  functions.  These behave similarly to their "timed" equivalents, but also
|  accept a clockid_t parameter to determine which clock their timeout should
|  be measured against.  All functions allow waiting against CLOCK_MONOTONIC
|  and CLOCK_REALTIME.  The decision of which clock to be used is made at the
|  time of the wait (unlike with pthread_condattr_setclock, which requires
|  the clock choice at initialization time).

You are looking for pthread_mutex_clocklock().

[0] https://sourceware.org/legacy-ml/libc-announce/2019/msg00001.html

> Thanx
> Andy

Sebastian
