Return-Path: <SRS0=4Q8Q=EM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66431C4741F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2029E22202
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 16:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgKFQOS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:14:18 -0500
Received: from mail.monom.org ([188.138.9.77]:48096 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgKFQOR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Nov 2020 11:14:17 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 39DD6500609;
        Fri,  6 Nov 2020 17:14:14 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id DD6EE500596;
        Fri,  6 Nov 2020 17:14:13 +0100 (CET)
Date:   Fri, 6 Nov 2020 17:14:13 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201106161413.7c65uxenamy474uh@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 06, 2020 at 11:54:47AM +0100, Sebastian Andrzej Siewior wrote:
> > rpi3    signaltest      5.9.0-rc8-rt12
> >   813   0_signaltest         t0-max-latency      : fail     214.00
> > rpi3    signaltest      5.9.0-rc8-rt12
> >   874   0_signaltest         t0-max-latency      : fail     217.00
> > rpi3    signaltest      5.9.0-rt16
> >   963   0_signaltest         t0-max-latency      : fail     321.00
> 
> Here, rt 13,14,15 would be interesting so we could narrow down the
> ~100us.
> v5.9-rc8-rt14 got new migrate-disable but I wouldn't expect it to cause
> it. The other changes look also harmless (like the rtmutex redo which
> should be a 0 change but then it mighe behave differently in regard to
> workqueue in some corner cases).

rpi3    signaltest      5.9.0-rc8-rt13
  1196  0_signaltest         t0-max-latency      : fail     207.00
  1196  0_signaltest         t0-avg-latency      : pass      46.00
  1196  0_signaltest         t0-min-latency      : pass      22.00
rpi3    signaltest      5.9.0-rc8-rt14
  1197  0_signaltest         t0-max-latency      : fail     301.00
  1197  0_signaltest         t0-avg-latency      : pass      47.00
  1197  0_signaltest         t0-min-latency      : pass      20.00
rpi3    signaltest      5.9.0-rt15
  1198  0_signaltest         t0-max-latency      : fail     323.00
  1198  0_signaltest         t0-avg-latency      : pass      47.00
  1198  0_signaltest         t0-min-latency      : pass      21.00

> > rpi3    signaltest      5.9.1-rt19
> >   1038  0_signaltest         t0-max-latency      : fail     341.00
> > rpi3    signaltest      5.9.1-rt20
> >   1079  0_signaltest         t0-max-latency      : fail     318.00
>
> So I have nothing to explain 20us improvement.

I think 20us is in the range of the standard deviation for this test. So
I don't think you should be concerned too much about it as long I don't
have proper statistical numbers.

One thing I also see is that the average was pretty constant at 47us for
5.9-rt and for 5.10-rt series it's around 55us. So something makes the
whole operation slightly more expensive.

> > rpi3    signaltest      5.10.0-rc1-rt1
> >   1118  0_signaltest         t0-max-latency      : fail     415.00
> > rpi3    signaltest      5.10.0-rc2-rt4
> >   1163  0_signaltest         t0-max-latency      : fail     340.00
> 
> -rt2 gained new kmap code.
> -rt3 received an update of the above

rpi3    signaltest      5.10.0-rc1-rt2
  1199  0_signaltest         t0-max-latency      : fail     399.00
  1199  0_signaltest         t0-avg-latency      : pass      55.00
  1199  0_signaltest         t0-min-latency      : pass      25.00
rpi3    signaltest      5.10.0-rc2-rt3
  1200  0_signaltest         t0-max-latency      : fail     420.00
  1200  0_signaltest         t0-avg-latency      : pass      55.00
  1200  0_signaltest         t0-min-latency      : pass      25.00

> But all this is only signal right?

Correct. I've observed this only for signaltest and sigwaittest.

> Nothing on the cyclictest front?

Correct, cyclictest doesn't show any regression.

> If lazy-preempt broke in a way then it should be only noticed by
> cyclictest. You can however disable lazy-preempt just to be sure.

Sure, will do a full run on Monday.
