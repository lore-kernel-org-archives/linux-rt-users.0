Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BBAC56202
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277D22403
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgKTVtr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTVtr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 16:49:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5541221FB;
        Fri, 20 Nov 2020 21:49:45 +0000 (UTC)
Date:   Fri, 20 Nov 2020 16:49:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.10-rc3-rt7
Message-ID: <20201120164944.00fbfadf@gandalf.local.home>
In-Reply-To: <20201112165824.s56wsbzsovunzwwg@linutronix.de>
References: <20201112165824.s56wsbzsovunzwwg@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 12 Nov 2020 17:58:24 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
> 
> I'm pleased to announce the v5.10-rc3-rt7 patch set. 
> 
> Changes since v5.10-rc3-rt6:
> 
>   - Mike Galbraith reported a lockdep warning triggered by the nouveau
>     driver with threaded interrupts.

Although these patches have:

Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")

Which exists in 5.4, I'm guessing it's not needed for 5.4-rt as there's no
stable-rt tag in them?

-- Steve


> 
>   - The recently reworked highmem code could trigger a warning on
>     certain ARM configurations. Reported upstream once parts of the code
>     hit linux-next. Patch by Thomas Gleixner.
> 
>   - Update the softirq patches by Thomas Gleixner to newer version.
> 
> Known issues
>      - It has been pointed out that due to changes to the printk code the
>        internal buffer representation changed. This is only an issue if tools
>        like `crash' are used to extract the printk buffer from a kernel memory
>        image.
> 
> The delta patch against v5.10-rc3-rt6 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc3-rt6-rt7.patch.xz
> 
> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc3-rt7
> 
> The RT patch against v5.10-rc3 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc3-rt7.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc3-rt7.tar.xz
> 
> Sebastian
> 
