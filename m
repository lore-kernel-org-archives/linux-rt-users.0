Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C3C19F2C
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 16:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiHCQKv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiHCQKu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 12:10:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340432D9E
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 09:10:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D65B81FE56;
        Wed,  3 Aug 2022 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659543047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqa9TBGcG8kdU7AXQOO2v2vxv1TJry968wBF0MPY7VY=;
        b=JNdQDwMb2VUT55m+NG7hUlb6wqhZaoNdjgchkvNZFNCCKMXupz+4xfuaQskSbrYbpl430e
        KZOCIjfQVSIof3E3rYjmGgNXSAesD8GIT0VN5VQF0k76skd5aJJUIvmmZ4mDt8pmNo6niF
        93ExxrSA3NdDrphSb/EN5OZTc9DKB5I=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ADC332C141;
        Wed,  3 Aug 2022 16:10:47 +0000 (UTC)
Date:   Wed, 3 Aug 2022 18:10:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
Message-ID: <YuqeB6Z0ZYNb2TxC@alley>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de>
 <87wnd616ds.fsf@jogness.linutronix.de>
 <87tu8a16bm.fsf@jogness.linutronix.de>
 <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
 <Yt5RDajSVTPqahV4@linutronix.de>
 <87h735ikdh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h735ikdh.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon 2022-07-25 12:04:50, John Ogness wrote:
> On 2022-07-25, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > I remember asking why it is needed to disable interrupts across
> > vsnprintf(). John, can I take this as-it or are you sending a new
> > batch?
> 
> Mike's patch only addresses the vsnprintf() to print the prefix and get
> the message length. There is also a vscnprintf() for the message itself,
> which is still happening with interrupts disabled (see
> printk_sprint()). I suppose this patch side-steps the splat because the
> first vsnprintf() already triggered the random bytes for the pointer
> hash.
> 
> I am preparing a new series that addresses this by completely removing
> interrupt disabling from the printk() path. This required changes to the
> printk_enter() macro, recursion handling, and the printk-ringbuffer
> itself.
> 
> The focus of my new series are the various non-RT issues reported during
> the early 5.19-rc cycles. I still need more time to get the series into
> shape for LKML.

The pull request for-5.20 was a great fiasko, see
https://lore.kernel.org/r/CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com
We need to be super careful with the next pull request if there will
be any.

My proposal is to start with as conservative version of printk
kthread(s) as possible. It means to start either with a single
kthread. Or use per-console kthreads where the critical section
will be guarded by per-console.

The single kthread will help to avoid any races that were originally
prevented by console_sem().

The spin lock will cause that printk kthreads will never block
the global console_lock while sleeping (at least on non-RT system).

I am not going to accept any removal of disabled interrupts in
the first round. It opens another can of worms.

I understand that enabled interrupts will be needed on RT kernel.
We could do it later when the conservative kthread(s) are accepted.
And we could do it RT-specific. But we have to keep consoles
as reliable as possible in non-RT system.

Best Regards,
Petr
