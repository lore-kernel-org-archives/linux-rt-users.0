Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F0C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522612077D
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgE2QPV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QPV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 12:15:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A2C03E969;
        Fri, 29 May 2020 09:15:21 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jehfC-0000nm-H5; Fri, 29 May 2020 18:15:18 +0200
Date:   Fri, 29 May 2020 18:15:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Marshall <markmarshall14@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200529161518.svpxhkeljafbtdz2@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-29 17:38:39 [+0200], Mark Marshall wrote:
> Hi Sebastian & list,
Hi,

> I had assumed that my e-mail had got lost or overlooked, I was meaning to
> post a follow up message this week...
> 
> All I could find from the debugging and tracing that we added was that
> something was going wrong with the mm data structures somewhere in the
> exec code.  In the end I just spent a week or two pouring over the diffs
> of this code between the versions that I new worked and didn't work.
> 
> I eventually found the culprit.  On the working kernel versions there is
> a patch called "mm: Protect activate_mm() by preempt_[disable&enable]_rt()".
> This is commit f0b4a9cb253a on the V4.19.82-rt30 branch, for instance.
> Although the commit message talks about ARM, it seems that we need this for
> PowerPC too (I guess, any PowerPC with the "nohash" MMU?).

Could you drop me your config, please? I need to dig here a little and I
should have seen this on qemu, right?

> Could you please add this commit back to the RT branch?  I'm not sure how
> to find out the history of this commit.  For instance, why has it been
> removed from the RT patchset?  How are these things tracked, generally?

I dropped that patch in v5.4.3-rt1. I couldn't reproduce the issue that
was documented in the patch and the code that triggered the warning was
removed / reworked in commit
    b5466f8728527 ("ARM: mm: remove IPI broadcasting on ASID rollover")

So it looked like no longer needed and then got dropped during the
rebase.
In order to get it back into the RT queue I need to understand why it is
required. What exactly is it fixing. Let me stare at for a little…

> Best regards,
> Mark

Sebastian
