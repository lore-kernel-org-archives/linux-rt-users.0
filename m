Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7240C3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71A620870
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfHUNug (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:50:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55781 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUNug (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 09:50:36 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0R0T-0005Vo-Ux; Wed, 21 Aug 2019 15:50:34 +0200
Date:   Wed, 21 Aug 2019 15:50:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Julien Grall <julien.grall@arm.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, rostedt@goodmis.org
Subject: Re: [RT PATCH 1/3] hrtimer: Use READ_ONCE to access timer->base in
 hrimer_grab_expiry_lock()
In-Reply-To: <20190821134437.efc3cs55o7uatrpj@linutronix.de>
Message-ID: <alpine.DEB.2.21.1908211549040.2223@nanos.tec.linutronix.de>
References: <20190821092409.13225-1-julien.grall@arm.com> <20190821092409.13225-2-julien.grall@arm.com> <20190821134437.efc3cs55o7uatrpj@linutronix.de>
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

On Wed, 21 Aug 2019, Sebastian Andrzej Siewior wrote:

> On 2019-08-21 10:24:07 [+0100], Julien Grall wrote:
> > The update to timer->base is protected by the base->cpu_base->lock().
> > However, hrtimer_grab_expirty_lock() does not access it with the lock.
> > 
> > So it would theorically be possible to have timer->base changed under
> > our feet. We need to prevent the compiler to refetch timer->base so the
> > check and the access is performed on the same base.
> 
> It is not a problem if the timer's bases changes. We get here because we
> want to help the timer to complete its callback.
> The base can only change if the timer gets re-armed on another CPU which
> means is completed callback. In every case we can cancel the timer on
> the next iteration.

It _IS_ a problem when the base changes and the compiler reloads

   CPU0	  	       	   	CPU1
   base = timer->base;

   lock(base->....);
				switch base

   reload
	base = timer->base;

   unlock(base->....);

See?

   
