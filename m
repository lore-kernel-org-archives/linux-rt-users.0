Return-Path: <SRS0=4Q8Q=EM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399AC55178
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7587620724
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 10:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+7AJwob";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+pQvHCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKFKyv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:54:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgKFKyv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Nov 2020 05:54:51 -0500
Date:   Fri, 6 Nov 2020 11:54:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604660088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qKYotRUY13kT4qJj8yVCDhzL4uOJ2Lx+7X1ta+4W8Q=;
        b=b+7AJwobaxS1fcwPIb3LoPMbciQ4ZIxLjGFpC3D7n3iCPpge+iBYyRm4DGDP+aJzpZGA8u
        m5cJrhPDezPOfSR662wyxQJ/gyIeGe6/w4YQtP9AusPN368m7qb5xs63NgRi4ma8pE5HYc
        qSF8wAZK8LZffxD6o0vbvHKTqgbL4JTnN1QiCGvo7DQLJn21eZjNnbbXjzjLQMCGEWv9QU
        21Axr4O8wd1qaCuWTwGrkDiJQBukfubzKYX4ri2luJyEjbNruD/1iLtQjgl/LAJX5Kp80m
        EuMRcdc/gEVDUJ+e7TIBfsoQRcnQ43L3T+r/QYoXIrDAJ5h3FONVm18Bvzskzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604660088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qKYotRUY13kT4qJj8yVCDhzL4uOJ2Lx+7X1ta+4W8Q=;
        b=a+pQvHCjOOXy1I5JRj7lDqFJRCw29fS8i/B5sGakjp/C/ApgTOXFHaW1f72nOZiwtyGqHq
        mxrZdSXqHvhP4RCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201104160650.b63zqof74wohgpa2@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-04 17:06:50 [+0100], Daniel Wagner wrote:
> On Wed, Nov 04, 2020 at 02:09:30PM +0100, Sebastian Andrzej Siewior wrote:
> > Could you figure out if the arm64 thingy started with -rt4 or was
> > already in rt3?
>=20
> I wrote a quick and dirty script to extract the data from my logs to see
> if the regression might be older then I remembered. I filtered out the
> obviously wrong configured runs (e.g !RT). It looks like the first
> recorded outlier is around 5.9.0-rt16. Does this already help or do you
> want me to bissect it down?

> rpi3    signaltest      5.9.0-rc8-rt12
>   813   0_signaltest         t0-max-latency      : fail     214.00
> rpi3    signaltest      5.9.0-rc8-rt12
>   874   0_signaltest         t0-max-latency      : fail     217.00
> rpi3    signaltest      5.9.0-rt16
>   963   0_signaltest         t0-max-latency      : fail     321.00

Here, rt 13,14,15 would be interesting so we could narrow down the
~100us.
v5.9-rc8-rt14 got new migrate-disable but I wouldn't expect it to cause
it. The other changes look also harmless (like the rtmutex redo which
should be a 0 change but then it mighe behave differently in regard to
workqueue in some corner cases).

> rpi3    signaltest      5.9.1-rt19
>   1038  0_signaltest         t0-max-latency      : fail     341.00
> rpi3    signaltest      5.9.1-rt20
>   1079  0_signaltest         t0-max-latency      : fail     318.00

Looking from my announcement:
|      - Tiny update to the rtmutex patches (make __read_rt_trylock()
|        static).

this could improve things but not that much.

|      - The test_lockup module failed to compile. Reported by Fernando
|        Lopez-Lezcano.

unrelated.

|      - The `kcompactd' daemon together with MEMCG could have accessed
|        per-CPU variables in preemtible context.

an additional lock=E2=80=A6

|      - The patch for the crash in the block layer (previously reported by
|        David Runge) has been replaced with another set of patches which
|        were submitted upstream.

looks also innocent.

So I have nothing to explain 20us improvement.

> rpi3    signaltest      5.10.0-rc1-rt1
>   1118  0_signaltest         t0-max-latency      : fail     415.00
> rpi3    signaltest      5.10.0-rc2-rt4
>   1163  0_signaltest         t0-max-latency      : fail     340.00

-rt2 gained new kmap code.
-rt3 received an update of the above

This is the only outstanding thing between rt1 and rt4.

But all this is only signal right? Nothing on the cyclictest front? If
lazy-preempt broke in a way then it should be only noticed by
cyclictest. You can however disable lazy-preempt just to be sure.

Sebastian
