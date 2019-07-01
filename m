Return-Path: <SRS0=4NjT=U6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EEBC06510
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC23F21721
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Jul 2019 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpJ53oWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfGATKL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:10:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41832 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGATKK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Jul 2019 15:10:10 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so31269946ioc.8;
        Mon, 01 Jul 2019 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=emRJcnTtw5aSYB2dXLemJk0HV3s3ejeGzXLaOETmDMc=;
        b=OpJ53oWdu24vPuFb/tmw91yU9U4su5Q7jKXYCBo4zjCo1szJtHaLLdrkPqeLXmq5Lc
         SsoApBqqkbfU0R2IFq/yLXRHDknfD+kgJOcQK+uyZXiRXs1LcKnFgy2GjBZ8TyBO23wR
         eaoXLsHuabhldTFvoWZHjQvIORRc7ki+1Sn+nuTJ60kyKL0W/lxc3Ln1Ld/ZfxtXrqws
         gNhnJUF2mXAk8UTUV4u9HSYdhNxrE5yrV66oy6MjLjPNEVImul0+ToNnv1llOnSziIjW
         XpHOyqIUicKzdxYtCG8WTYTXJ9wuXWKSYjIW350hd3wKwgzIu0E5iD833jM/E0pWL6j5
         eKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=emRJcnTtw5aSYB2dXLemJk0HV3s3ejeGzXLaOETmDMc=;
        b=gXDM9gXhScJC//fbphAz1kQwDoLVwa32fcFJ6GFoIJsmfTlTuYpyGhL/iiKpESQ7TS
         pjmj+lo64WAuGFfl+jhnMlLUb9CWm7ih2lSXNCd+e1572Mde8kOcu1zl4CtHwqe8XF5i
         YYxg/ZH8Ce1FHUqdsk0FqapgFaxUgLnOmzTmZXsG6jHi7rtvtZQZIJANk6SmFIqKj2uP
         gF4znWI+78bTH/bf3CwrJ8d8AvBKnB9EzclxxE5iCbUfFFBaP0pcKjQPW5dc3INyuP4a
         gB+ypZ7twuK2uU28vVVeeybHVMO1yfrzllDk3AEsqjpMULep3Posh4VHMEt86KrsL5dg
         uSYw==
X-Gm-Message-State: APjAAAUj4MuejcRmzshPDtr39FPPb+4S1SyB1MKtb5IGaaXM2/aRBiCk
        IkHz7ars3cn5GVUIx1RvtQ==
X-Google-Smtp-Source: APXvYqw2upm3DxWP5X8c+UGFfWyuMUj8NmXd7S1ELO8WStFW5LmA5vn0KRToEz/jHV59fdudW6D3bg==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr31603978jaa.86.1562008209669;
        Mon, 01 Jul 2019 12:10:09 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id y20sm10356970iol.34.2019.07.01.12.10.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 12:10:08 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9575:16b6:1dd6:2173])
        by serve.minyard.net (Postfix) with ESMTPSA id 8B9701800D1;
        Mon,  1 Jul 2019 19:10:06 +0000 (UTC)
Date:   Mon, 1 Jul 2019 14:09:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190701190949.GB4336@minyard.net>
Reply-To: minyard@acm.org
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628214903.6f92a9ea@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jun 28, 2019 at 09:49:03PM -0400, Steven Rostedt wrote:
> On Fri, 10 May 2019 12:33:18 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2019-05-09 14:33:20 [-0500], minyard@acm.org wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > > 
> > > The function call do_wait_for_common() has a race condition that
> > > can result in lockups waiting for completions.  Adding the thread
> > > to (and removing the thread from) the wait queue for the completion
> > > is done outside the do loop in that function.  However, if the thread
> > > is woken up, the swake_up_locked() function will delete the entry
> > > from the wait queue.  If that happens and another thread sneaks
> > > in and decrements the done count in the completion to zero, the
> > > loop will go around again, but the thread will no longer be in the
> > > wait queue, so there is no way to wake it up.  
> > 
> > applied, thank you.
> > 
> 
> When I applied this patch to 4.19-rt, I get the following lock up:

I was unable to reproduce, and I looked at the code and I can't really
see a connection between this change and this crash.

Can you reproduce at will?  If so, can you send a testcase?

-corey

> 
> watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [sh:745]
> Modules linked in: floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea iosf_mbi i2c_algo_bit video
> CPU: 2 PID: 745 Comm: sh Not tainted 4.19.56-test-rt23+ #16
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
> RIP: 0010:_raw_spin_unlock_irq+0x17/0x4d
> Code: 48 8b 12 0f ba e2 12 73 07 e8 f1 4a 92 ff 31 c0 5b 5d c3 66 66 66 66 90 55 48 89 e5 c6 07 00 e8 de 3d a3 ff fb bf 01 00 00 00 <e8> a7 27 9a ff 65 8b 05 c8 7f 93 7e 85 c0 74 1f a9 ff ff
>  ff 7f 75
> RSP: 0018:ffffc90000c8bbb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: ffffc90000c8bd58 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: ffffffff8108ffab RDI: 0000000000000001
> RBP: ffffc90000c8bbb8 R08: ffffffff816dcd76 R09: 0000000000020600
> R10: 0000000000000400 R11: 0000001c0eef1808 R12: ffffc90000c8bbc8
> R13: ffffc90000f13ca0 R14: ffff888074b2d7d8 R15: ffff8880789efe10
> FS:  0000000000000000(0000) GS:ffff88807b300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000030662001b8 CR3: 00000000376ac000 CR4: 00000000000006e0
> Call Trace:
>  swake_up_all+0xa6/0xde
>  __d_lookup_done+0x7c/0xc7
>  __d_add+0x44/0xf7
>  d_splice_alias+0x208/0x218
>  ext4_lookup+0x1a6/0x1c5
>  path_openat+0x63a/0xb15
>  ? preempt_latency_stop+0x25/0x27
>  do_filp_open+0x51/0xae
>  ? trace_preempt_on+0xde/0xe7
>  ? rt_spin_unlock+0x13/0x24
>  ? __alloc_fd+0x145/0x155
>  do_sys_open+0x81/0x125
>  __x64_sys_open+0x21/0x23
>  do_syscall_64+0x5c/0x6e
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> I haven't really looked too much into it though. I ran out of time :-/
> 
> -- Steve
