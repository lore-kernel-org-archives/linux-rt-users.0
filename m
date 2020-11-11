Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420AC4742C
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9B3205CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 18:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgKKSjH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:39:07 -0500
Received: from mail.monom.org ([188.138.9.77]:42210 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgKKSjF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Nov 2020 13:39:05 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A727F500596;
        Wed, 11 Nov 2020 19:39:02 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 3EFDF500108;
        Wed, 11 Nov 2020 19:39:02 +0100 (CET)
Date:   Wed, 11 Nov 2020 19:39:01 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201111183901.GA23846@beryllium>
References: <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
 <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
 <20201109163143.tm5gjz77rr734lm5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109163143.tm5gjz77rr734lm5@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sorry for the late response, I had to reinstall my system after a FS
corruption...

On Mon, Nov 09, 2020 at 05:31:43PM +0100, Sebastian Andrzej Siewior wrote:
> > These test run only very short with hackbench as worlkload (5 minutes).
> > Though I running these tests now for more than year with v4.4-rt and
> > some times the newer -rt releases and I've never seen the latency
> > numbers above 200us unless something was broken. Given that 5 minutes is
> > not really long, I'll let those test run for longer to see if I get the
> > same results when they run for one hour.

- 5.9.0-rc8-rt12, ca 5h
  T: 0 (11626) P:80 C:15092432 Min:     17 Act:   34 Avg:   43 Max:     226

- 5.9.0-rc8-rt13, ca 1.5h
  T: 0 (24661) P:80 C:5581936 Min:     21 Act:   35 Avg:   45 Max:     250

- 5.9.0-rc8-rt14, ca 1h
  T: 0 (  942) P:80 C:6522320 Min:     20 Act:   27 Avg:   44 Max:     352

This matches with the 5 minutes runs. -rt13 was still okay and -rt14
is clearly worse.

> > 5.10.0-rc2-rt4 vs 5.10.0-rc2-rt4(lazy preemption disabled)
> >
> >   0_cyclicdeadline     t2-max-latency       pass/pass                274.00/     61.00     349.18%
>
> So the value went from 274us to 61us after disabling lazy-preempt?

Yes, that was all I changed. I want to redo this measurement. It
really looks a bit bogus. Though, one thing after the other :)

Daniel
