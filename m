Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD4C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 07:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7206018A
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 07:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhHBHTe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 03:19:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:35675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhHBHTc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 03:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627888716;
        bh=ChXftOXR8yVdG8QFcMQASenelvUXOPCJeJpZQsMwvlE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SmYy47/NlEiRWSDLAnRcwHnFt8iTbyLVWrc673/b1voLPOKUGd+ks+3rAzvCNmwk7
         05WJHYNhgck4qOVgPR9WowK5ykGwvQ+iJTTHMFuLsbPCCuCfQTl7PfhyYwg4YWx33p
         Tus2fswo5drk2lZrOnBPXw1LGu3z8fwG6MbyCy7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.211]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1mqhGU0fvq-00jrhr; Mon, 02
 Aug 2021 09:18:36 +0200
Message-ID: <edd2f9fd1489e1ff05bf526a3059a1dbb81107df.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 02 Aug 2021 09:18:34 +0200
In-Reply-To: <20210802070218.5js3exubjxvsicx6@linutronix.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
         <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
         <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
         <20210802070218.5js3exubjxvsicx6@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OrmG8K3WPQzzonRq7UWFT87Uq2HB4IWHezwt+GbZX9tGA294hhs
 XD8g1aR2yNbXbtoodtufOfmdEuUH4tZIMrwdtLU69dpeAz8+ZIuzQGEfg+5Ssmpkb4L71wL
 v6BdvznPwocY5ejD/DiCzC9odwIO7zpPL7Ke6Y/7Ncy9lmZeCzb8L6XVXG69DZXZ/K9joZz
 3ZdeWFrHZMM/g7Vg6e1KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Kt1Hr6+MTs=:fEN+JqB6ucweQH6gafMznS
 4GJE9CtG1mkLkf4dDwovE0SnmDjo6CqXeS7+cNaP/kw14Vmx2BkxO3GjuyIKZZRxuDABaTkxH
 0K581b0T7YC/j4GwuwALa9/d4PEUPU8pziP3y0LxYzjua8Gk0LEzixcB4qvyZDCOGfQdZQNJP
 8mOueg2XqUpvoc3Ryzw4hmQleM8ALKUUSjZChaBdWXY3qWNjAKHbBgBDAVZQLPqicYatLgBeL
 wER7nQvAYnZ+MLHrBXviPAFkOmCQukqPmo5zHNmBkfaFeyYZbZ7xle/+GUENd5KrvtLO5W6yg
 n/Ao5EbIP2Go550RLU3CcVMBbM6s3iYNNAMytpi3pW7CanIMi0hNzkTD9z2U9TiygC+NyCzmh
 6gZaOPEjdp7hp1dU4LJGRIbDfCpccN+LZGoNR9eAcuqdpBRVRBpVp4ebyxWXrANFzmC/zKMoh
 blP0smrCw6tib35T9bYUBA8qr2PAkN1lOXgRddh15in54xCyOzbV/RnIpwrDyzM8bGFWaXah1
 +s+QVuBpgeBseQD0sKd4a9P3eHM4qBROvp0Szt/0G3LeEaVc1p5JG4ghLxJi1kDYTyaLehCnD
 hzfLYEcEztD0nMKt3NRpasLN/enuspL9FMH+aSGvmkVT2aK4x9Pw5JjKvzOZo9BUXNWqsvllk
 KIdHWGAaVPF4ZGm52mXsN1Tly3q4Jms8GnZiNq5rEjQzFNS8thcdg9pCzK7WGIEV090VlUOdw
 OPO1hNKyeoSFT6z77hviatJGvhQzxn2iHKyVRiCtv4H9wdBtRCbi7Rw6L0cEb3hUgK9K+h62j
 1e068Lo2A8c/FVihTDmrYzeAnlgK9SXx5b04PwpcNdUQ9XgOhTtBeCqPTiGXTpj3kYj/U6RLC
 PLSFUN3X8HSsn7/RLsnxfhunSiMfbmT3dsdeX53NczQ+3+L3TUHhkdn9Use2x/2DuG9gxnl3g
 AJZ1GYO02hn0HeJ3eVxusr15f9OTLJFLBNcUIUYazmery63zYB+vNHNnZ7fNavy1dfKhGO4fb
 P7ERAWZMg5T5dkQRIotdGsNWWD6U7vc7kcJB1i+kRQM578vek7Z6CSkHztHGHC4x3nGndezGz
 Yd3MVSECGc+GbEUS5YEYMZyK8OIkqZ0B2V8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-08-02 at 09:02 +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-01 17:14:49 [+0200], Mike Galbraith wrote:
> > On Sun, 2021-08-01 at 05:36 +0200, Mike Galbraith wrote:
> > > On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> > > > >
> > > > > First symptom is KDE/Plasma's task manager going comatose.=C2=A0=
 Notice soon
> > > >
> > > > KDE/Plasma points at the new fangled rtmutex based ww_mutex from
> > > > Peter.
> > >
> > > Seems not.=C2=A0 When booting KVM box with nomodeset, there's exactl=
y one
> > > early boot ww_mutex lock/unlock, ancient history at the failure poin=
t.
> >
> > As you've probably already surmised given it isn't the ww_mutex bits,
> > it's the wake_q bits.=C2=A0 Apply the below, 5.14-rt ceases to fail.=
=C2=A0 Take
> > perfectly healthy 5.13-rt, apply those bits, and it instantly begins
> > failing as 5.14-rt had been.
>
> Given what you have replied to the locking thread/
> ww_mutex_lock_interruptible() may I assume that the wake_q bits are fine
> and it is just the ww_mutex?

Nope.  Before I even reverted the wake_q bits, I assembled a tree with
the ww_mutex changes completely removed to be absolutely certain that
they were innocent, and it indeed did retain its lost wakeup woes
despite complete loss of newfangled ww_mutex.  5.13-rt acquired those
same wakeup woes by receiving ONLY the wake_q bits, and 5.14-rt was
cured of those woes by ONLY them being reverted. I'm not seeing the
why, but those bits are either the source or the trigger of 5.14-rt
lost wakeup woes... they're toxic in some way shape fashion or form.

	-Mike

