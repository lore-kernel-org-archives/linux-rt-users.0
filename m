Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB4DC2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6102082F
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 10:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLKUM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:20:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLKUM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 05:20:12 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j1p7m-0001ge-RC; Wed, 12 Feb 2020 11:20:06 +0100
Date:   Wed, 12 Feb 2020 11:20:06 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.4.17-rt9
Message-ID: <20200212102006.m4psb6rqdps2jw2w@linutronix.de>
References: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
 <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
 <1581055866.25780.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581055866.25780.7.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-07 07:11:06 [+0100], Mike Galbraith wrote:
> drm/i915/gt: use a LOCAL_IRQ_LOCK in __timeline_mark_lock()
> 
> Quoting drm/i915/gt: Mark up the nested engine-pm timeline lock as irqsafe
> 
>     We use a fake timeline->mutex lock to reassure lockdep that the timeline
>     is always locked when emitting requests. However, the use inside
>     __engine_park() may be inside hardirq and so lockdep now complains about
>     the mixed irq-state of the nested locked. Disable irqs around the
>     lockdep tracking to keep it happy.
> 
> This lockdep appeasement breaks RT because we take sleeping locks between
> __timeline_mark_lock()/unlock().  Use a LOCAL_IRQ_LOCK instead.
> 
> Signed-off-by: Mike Galbraith <efaukt@gmx.de>

Applied, thank you.

Sebastian
