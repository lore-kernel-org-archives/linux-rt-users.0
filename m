Return-Path: <SRS0=BKJB=EP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794BEC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F083A207BC
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4NMbp6Op";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9AKLaLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKIMrh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:47:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgKIMrW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 07:47:22 -0500
Date:   Mon, 9 Nov 2020 13:47:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604926039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wcUoyYHMIwEeentgdf0GLAjnZFrqAPKCQFNHSrl3lg=;
        b=4NMbp6OpOcP0ybSkoFJb2GfnisaH2XXcNYsuC8MWz2/oNRf8JOvvr3QpsdGP2mbOWJ5GFK
        8vrg5X2qcUvTpoNygqfSJcqMXkDnRlWsUHWIRC0Cfumr/oOWwIaaTAGpqRmS+e7hwWzisu
        iZd1geU1m1I5ENsMUFXvjDHwV0I1U9CLUfXUx/evlks582VLqmSjeOkzq44yS3vy5DinKK
        jp1C/ncfP3wRAa3fZnXyBo7ws0UIgMg6RXSrcTtqzMrMAWFhintp4n5+GkI7+gYiAa4Td8
        ImM/TCUt9JhDvm+fleRNqX3R3iE9T2TVv0OEprpjxQc8Mm6Ok1pIs3a4XmUiZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604926039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wcUoyYHMIwEeentgdf0GLAjnZFrqAPKCQFNHSrl3lg=;
        b=m9AKLaLsrviv7UUz+nZhQ5KmsiqlIyt4DbmIBD9Gmd5W5Ehiiu4RrZq5A1/1OF9yeHUfqG
        wf1T3JezoZbUkNBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201109124718.ljf7inok4zakkjed@linutronix.de>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106161413.7c65uxenamy474uh@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-06 17:14:13 [+0100], Daniel Wagner wrote:
> On Fri, Nov 06, 2020 at 11:54:47AM +0100, Sebastian Andrzej Siewior wrote:
> > > rpi3    signaltest      5.9.0-rc8-rt12
> > >   813   0_signaltest         t0-max-latency      : fail     214.00
> > > rpi3    signaltest      5.9.0-rc8-rt12
> > >   874   0_signaltest         t0-max-latency      : fail     217.00
> > > rpi3    signaltest      5.9.0-rt16
> > >   963   0_signaltest         t0-max-latency      : fail     321.00
> > 
> > Here, rt 13,14,15 would be interesting so we could narrow down the
> > ~100us.
> > v5.9-rc8-rt14 got new migrate-disable but I wouldn't expect it to cause
> > it. The other changes look also harmless (like the rtmutex redo which
> > should be a 0 change but then it mighe behave differently in regard to
> > workqueue in some corner cases).
> 
> rpi3    signaltest      5.9.0-rc8-rt13
>   1196  0_signaltest         t0-max-latency      : fail     207.00
>   1196  0_signaltest         t0-avg-latency      : pass      46.00
>   1196  0_signaltest         t0-min-latency      : pass      22.00
> rpi3    signaltest      5.9.0-rc8-rt14
>   1197  0_signaltest         t0-max-latency      : fail     301.00
>   1197  0_signaltest         t0-avg-latency      : pass      47.00
>   1197  0_signaltest         t0-min-latency      : pass      20.00
> rpi3    signaltest      5.9.0-rt15
>   1198  0_signaltest         t0-max-latency      : fail     323.00
>   1198  0_signaltest         t0-avg-latency      : pass      47.00
>   1198  0_signaltest         t0-min-latency      : pass      21.00

So it is the new migrate-disable code? If you have stable 100us you
should be able bisect it within the few commits between rt13 and rt14.

> > > rpi3    signaltest      5.9.1-rt19
> > >   1038  0_signaltest         t0-max-latency      : fail     341.00
> > > rpi3    signaltest      5.9.1-rt20
> > >   1079  0_signaltest         t0-max-latency      : fail     318.00
> >
> > So I have nothing to explain 20us improvement.
> 
> I think 20us is in the range of the standard deviation for this test. So
> I don't think you should be concerned too much about it as long I don't
> have proper statistical numbers.
> 
> One thing I also see is that the average was pretty constant at 47us for
> 5.9-rt and for 5.10-rt series it's around 55us. So something makes the
> whole operation slightly more expensive.
> 
> > > rpi3    signaltest      5.10.0-rc1-rt1
> > >   1118  0_signaltest         t0-max-latency      : fail     415.00
> > > rpi3    signaltest      5.10.0-rc2-rt4
> > >   1163  0_signaltest         t0-max-latency      : fail     340.00
> > 
> > -rt2 gained new kmap code.
> > -rt3 received an update of the above
> 
> rpi3    signaltest      5.10.0-rc1-rt2
>   1199  0_signaltest         t0-max-latency      : fail     399.00
>   1199  0_signaltest         t0-avg-latency      : pass      55.00
>   1199  0_signaltest         t0-min-latency      : pass      25.00
> rpi3    signaltest      5.10.0-rc2-rt3
>   1200  0_signaltest         t0-max-latency      : fail     420.00
>   1200  0_signaltest         t0-avg-latency      : pass      55.00
>   1200  0_signaltest         t0-min-latency      : pass      25.00

this looks odd. So rt1 has 415, rt2 has 399 and rt3 has 420 so lets say
it is the same. And then rt4 should reduce it to 340. The only part that
could have some influence is the are the highmem/kmap patches. But for
ARM64 these are still a nop and in both cases kmap_atomic() disables
migrate & page-fault.

Are you sure those numbers always reproducible and not something that
goes wrong and sometimes it is captured at 300us and sometimes 400us.

I've been staring at the code of signaltest on Friday and I might need
to stare longer to figure out what it does.

Sebastian
