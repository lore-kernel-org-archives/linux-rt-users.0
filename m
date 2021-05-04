Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD98C433B4
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 May 2021 04:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D161186
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 May 2021 04:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhEDEJl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 May 2021 00:09:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:40087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDEJl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 May 2021 00:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620101273;
        bh=bsPODiDnk61cWDSdS7mJx99eO8YJm2WKRtfXTCd51KA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PkvCdTT+N31nHv2yCTKt2Arwe8CFICf3AgzrLiWiXTFWFgCt8tnbBAqjj7sCSxKf3
         aEJ7RlFSlifmxdX9ZSwRDUdp/cKSE+WuHr18R1iObQkmiE0hTQJV5hHkPySNWsanGi
         xmOxwaPAgNCDmKTCGtjRNogFw5K32BExuXFZwWwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.51.85]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1lY6RI36vU-0133gj; Tue, 04
 May 2021 06:07:52 +0200
Message-ID: <ceac7107048b6620d4b120b8f775b85f7fbee92b.camel@gmx.de>
Subject: Re: [PATCH v2 0/3] newidle_balance() PREEMPT_RT latency mitigations
From:   Mike Galbraith <efault@gmx.de>
To:     Scott Wood <swood@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 04 May 2021 06:07:50 +0200
In-Reply-To: <32a536f5688105df515e6ad9fd12fbcdbd781afb.camel@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
         <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
         <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
         <a46f9b6c719666357e568eadd1d615c05c4171ac.camel@gmx.de>
         <4170501b7c4f19ba66d870b671dc90ffbf4623d6.camel@redhat.com>
         <3773421d06bed0beed9971d03e8fa2050a14cc13.camel@gmx.de>
         <32a536f5688105df515e6ad9fd12fbcdbd781afb.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G2a6nqlATNVbHXWopLbE4WMWqfI83qPD0dxtXwZ5CU4kg5byHkO
 S3EkrUsBg0uW5cf47Qwznz+FesQvt/Wge/F4Y/rR9fPWfxzkc4ueL0NHTkllktXgFTyjrgK
 xyqHTC2UbYgXLDh4TuzUzSBUQt15x4F4yB4D+tXpZHMI3OZjcUBO0OhbI7jJl4lDM6pfxm3
 2BL1uhSXd0C7QT7wVMM8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+7HGfLjwOk=:GV3ytNAM3yGb/w6PHN2CBf
 iiWPUF7kAqYqX+dLa9egsFrOgcmmO2QNXUko9zrcrPG/Sj7L1D2V197Adk16/Gc6Ky1nhjIwE
 XFp/rS7T+50x0eBGll92U5gx6x0DaDJGa4mTDUTkjU1ye1jXfcj5lVn2oeQI/NV5nel4amC6x
 HXI3nAJOvz8B8cvIw+lRUnZVN3jeKpmwr1p38ILr3oZBynlTcH0aixfe8Ha0T0nJyub2Gy3Zt
 bUhb1mt6Pi2WjoG4ZNgKQprgCAWmGdfRbcaYN7+EZVatgEfty4qWkkqHi1dINA+MACDzzBT0D
 CucY9K/SoG7fv40yUz9Eip149hATUvS2DzKPk1MzEZ2X3kd7slJiLHs5PBRmAp3lkgTXhscxc
 QmyNbnu0mnGDt0uKXgWL7heG5d3FZj/I7mctpzre8THDQZzN9qr29bLC1N1qQDPqO5CpsGK0x
 gdTiwBSVdSkQSDLKviFZvjdQuoGVwD3uluWZcsgFezbzfX09XX3iYa+l36PyiImvzxzfN8X4w
 UewXN/CF1osMfkAUXi59bmN9wRkmyH5r+kYxJiqRN+Tn43iYUcFlcDNs7ODNlTLay6K+k53pr
 0N3U4rqit5rv9zoSUf6BhH8N3VsvN6pYSiBRRAUuLC3rq5g/N2kCw3etU8LMh+qkSiW9NyHTn
 7cVlVxP/5Wc+1HVgFa2wo0jg8szLfrWz+SW/bnOXUG5vojiSvhyoEmjeBo9UKznEjimcWjfWS
 F7DDr+EXgizwRIz4hH26eA/WR+TxddIOtsP9qfoJIjPVCA5DKmyoaw/pyOgZ9C4XK+7LN1ryq
 3y0ghA6gWp/xPkJOjpVq7sKnkWYMQYHrxAwWglU8crkX4uU5qfRJZHW/eh/RJK7gCiFmiTwSM
 5kdSWIXHk5zCOiSOPhCGh5b764ctEHk/pmXeyNHvpF4XGi4c6SzlF7ROXAVhmn38a8CFdQfnv
 q37IAKDkmFlFq1Rokb5mj7sP93EwMCCgcDQWgd0OFbljBTf23EeCIt8dBGViaR5Ra8cxhnhGB
 H3OAI75eWRQ5dy4c0IiUnudFwZXXnlT5RXfYPypWLie0HyePdjDQItWnfwLmmwBLSE73oraHm
 NRkAvgovqVk5uFKCOt+fO3e5en4Yx459naJGOomJH2f/IfYiOAybxMrXsS1Tfqf7Ya9EjP3mB
 nuYpciY9YmnkZ2ZeR3nZM+mf6+jNlmvQ7kQHpQxIMqlaoIkv8NJ4u+4m/sP/ImrpNFInw=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-05-03 at 16:57 -0500, Scott Wood wrote:
> On Mon, 2021-05-03 at 20:52 +0200, Mike Galbraith wrote:
> > On Mon, 2021-05-03 at 11:33 -0500, Scott Wood wrote:
> > > On Sun, 2021-05-02 at 05:25 +0200, Mike Galbraith wrote:
> > > > If NEWIDLE balancing migrates one task, how does that manage to
> > > > consume
> > > > a full *millisecond*, and why would that only be a problem for RT?
> > > >
> > > > 	-Mike
> > > >
> > > > (rt tasks don't play !rt balancer here, if CPU goes idle, tough ti=
tty)
> > >
> > > Determining which task to pull is apparently taking that long (again=
,
> > > this is on a 128-cpu system).  RT is singled out because that is the
> > > config that makes significant tradeoffs to keep latencies down (I
> > > expect this would be far from the only possible 1ms+ latency on a
> > > non-RT kernel), and there was concern about the overhead of a double
> > > context switch when pulling a task to a newidle cpu.
> >
> > What I think has be going on is that you're running a synchronized RT
> > load, many CPUs go idle as a thundering herd, and meet at focal point
> > busiest.  What I was alluding to was that preventing such size scale
> > pile-ups would be way better than poking holes in it for RT to try to
> > sneak through.  If pile-up it is, while not particularly likely, the
> > same should happen with normal tasks, wasting cycles generating heat.
> >
> > The main issue I see with these patches is that the resulting number i=
s
> > still so gawd awful as to mean "nope, not rt ready", making the whole
> > exercise look a bit like a noop.
>
> It doesn't look like rteval asks cyclictest to synchronize, but
> regardless, how is this "poking holes"?

Pulling a single task is taking _a full millisecond_, which I see as a
mountain of cycles, directly through which you open a path for wakeups.
That "poking holes" isn't meant to be some kind of crude derogatory
remark, it's just the way I see what was done.  The mountain still
stands, you didn't remove it.

>   Making sure interrupts are
> enabled during potentially long-running activities is pretty fundamental
> to PREEMPT_RT.  What specifically is your suggestion?

Try to include fair class in any LB improvement if at all possible,
because that's where most of the real world benefit is to be had.

> And yes, 317 us is still not a very good number for PREEMPT_RT, but
> progress is progress.  It's hard to address the moderate latency spikes
> if they're obscured by large latency spikes.  One also needs to have
> realistic expectations when it comes to RT on large systems, particularl=
y
> when not isolating the latency-sensitive CPUs.

Agreed.  But.  Specifically because the result remains intolerable to
anything remotely sensitive, users running such on their big boxen are
not going to be doing mixed load, that flat does not work, which is why
I said the patch set looks a bit like a noop: it excludes the audience
that stands to gain.. nearly anything.  Big box HPC (acronym includes
RT) gains absolutely nothing, as does big box general case with its not
particularly prevalent, but definitely existent RT tasks.  Big box
users who are NOT running anything they care deeply about do receive
some love.. but don't care deeply, and certainly don't care more any
more deeply than general case users do about these collision induced
latency spikes.

	-Mike

