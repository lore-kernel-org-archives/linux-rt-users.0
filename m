Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6571C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8CB208D5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgFPQsA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQsA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 12:48:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA4C061573;
        Tue, 16 Jun 2020 09:48:00 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlEkf-0004D3-Qr; Tue, 16 Jun 2020 18:47:57 +0200
Date:   Tue, 16 Jun 2020 18:47:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.17-rt10
Message-ID: <20200616164757.o6qlarnluib2szl5@linutronix.de>
References: <20200616124502.vfmbsec3avnbhupz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616124502.vfmbsec3avnbhupz@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-16 14:45:03 [+0200], To Thomas Gleixner wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.6.17-rt10 patch set. 
> 
> Changes since v5.6.17-rt9:
> 
>   - Add the seqcount series by Ahmed S. Darwish.
>     The series annotates the lock protecting the struct seqcount against
>     multiple writer. In RT the lock annotation can be utilized to block
>     on in case the writer is active. This is the same technique that is
>     used now but we can avoid replacing the seqcount with a seqlock and
>     have code that is closer to mainline.
>     
>     As part of the integration I dropped seqcount replacements which
>     are no longer needed, like in NFS or vfs.
> 
>   - Added down_read_non_owner() for RT. There is no owner tracking since
>     we allow multiple reader locking on struct rw_semaphore. This
>     removes on patch from the NFS subsystem and allows to enable bcache.
> 
>   - Drop the lock raw_spinlock_t from struct hlist_bl_head. The struct
>     hlist_bl_head uses bit_spin_lock() for locking so we are still
>     spinning.
> 
> Known issues
>      - It has been pointed out that due to changes to the printk code the
>        internal buffer representation changed. This is only an issue if tools
>        like `crash' are used to extract the printk buffer from a kernel memory
>        image.
> 
> The delta patch against v5.6.17-rt9 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.17-rt9-rt10.patch.xz
> 
> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.17-rt10
> 
> The RT patch against v5.6.17 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.17-rt10.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.17-rt10.tar.xz

Again without the delta diff since the email was too huge. It can be
still look on at
   https://git.kernel.org/rt/linux-rt-devel/d/v5.6.17-rt10/v5.6.17-rt9

Sebastian
