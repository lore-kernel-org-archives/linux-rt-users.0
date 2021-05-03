Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8082C433ED
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E942611AC
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 May 2021 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhECSyf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 May 2021 14:54:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:45123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECSyd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 May 2021 14:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620067967;
        bh=A/TMQuiuLC0Rhe8BIv4n8MfCqBTIsiRGtqT7aR8Go+c=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Bt8LcCaWzXzngxXIo/78yKF3ejeuqziaBI0HxUJWn20pc/cG0fEjL9JmK6jf6XfoN
         ZJyDbbZnzluHeVe2lzaiJQg2RGIGug3m8cG8QOXcLtJcvZY9tjwTmYRjcphEiRDYRc
         f4OpsdrICM+1DVa28YcmDJP0LoTPfdUWtuu5z5hc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.135]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1lgfgb3KaR-0039e8; Mon, 03
 May 2021 20:52:46 +0200
Message-ID: <3773421d06bed0beed9971d03e8fa2050a14cc13.camel@gmx.de>
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
Date:   Mon, 03 May 2021 20:52:45 +0200
In-Reply-To: <4170501b7c4f19ba66d870b671dc90ffbf4623d6.camel@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
         <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
         <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
         <a46f9b6c719666357e568eadd1d615c05c4171ac.camel@gmx.de>
         <4170501b7c4f19ba66d870b671dc90ffbf4623d6.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8I6k35QKpm5b64+O31dj4ji8yjXkdtha+BrTy2xVijV8+VkWomv
 Me0Nj/S8RvSf/UagzWJzEPC+eReBwbojYTD/Yy8pKtXOIBNtPTqDeclq4H2xCJV54ArB+Vc
 tcezZx3xv/gUPatLloEWn3R8qGnbg+PF6B1WRtf3up057DDtmqn5NvjI0FPjPtZq+Wk2RHD
 uB7yte0vf/Dmh22yxrfEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tos9M+1xUEY=:1vA/k0uxL40hk+lHdttlXR
 7a59s/dq9EIDkRWbKSbhEuhyZHt9Snfx093H5u3ck/IeTQEyMI98Cw1qw3Y0evWBuqGp/visP
 8tPkKSpeV8ObeiAvrWnGBF74S21RNYV8R5u3xeoVX8k3K5omv8B/DVMNeHiHjlUdP1m/6GVHI
 4NGRptgGBtVeXq26cTc2+ov1vQs/7lG33exrvy77ERmfp2OkuB8VsIy38WNr/rv3ooOIHI4rX
 oGRa4vhYAygFHBMpdFFU3ZlXhx11Nt02GqFM5kip35usa7iNTNfIRRCGjPYjhHH1p4oqTDt7I
 LM+30XQGZoKGfoYNRISt2XeQY6wI6yWWB8ZufEGOEBt/sWXWQacERxV5gqqZPN5iogrPqBarU
 IKjEbRknMSqwlrfTAqy8+WkLt9cjT4NIiaGV2R+XRWXJ57PxXshofUWHfJeMb+99dB7JcovWa
 uO3Kk+OGi1dVlnOdrKesq4GZU3i12wst3OzsS6icfXSVKOGJLSvojS7nJwmSLHMn2UUf1yjQI
 4npDO8AneMDDlIIYnoXEXUMa6MKUui9uMiVRoItrF7/0zM1NxAMT9lDPQU67j15DjH0bqUrl8
 jGCy1WdbL7/85ZxA2OBv2lEMKTHWzAA15953eQdtKKG1Q5Gexw1bdJ8MVugKtw8yMQtLV+I73
 xjawWUeTt/SMlLyMQ4cwJ64+hpi3STQ2n1GIgU8LSsCFJjj81s+Al7stAfTfOlclsAggnQbEq
 boZhPcYmllhWTKaCn0avwZ8UbwTilGRih0OqK6D8Y9MLwEZ8N465Cadb7S+edl7lH5joopMAo
 HrE6BxkC8f2cD5XYk2Z3grUmaOjmmQJydxF14Fd1YPQfoG6emrULUrkYZ4pkp8ZYgAVTxV2ug
 L+HjohJdjQdC6Rc9XxMMpcudeFdxbWTKmsn8/HqAQwF0fBpsTLi/cHGm5QgG7FQm1/NiJHXvm
 kEfizEls1Vgj+UxjLoeAnoqvF1Ec0CjXOm+cYrd9hYpGittDadhXNGydcCzhTNLNW76ofhGZl
 QAA8UBJqVFgTEjTLdHZ1AxG0tIDar378DpKA521Ldo5JMmC6Q5Ulw0fv3HdK/YOFTc19hKJVv
 mcytuaFtwcQ670lQBFPYlZFZ9bm0H/R4SmqPTl7FvOX/7ZlB3fpQfmlhdPBj+P5IJvwQ1RszV
 nixAyivthEXQWf55hsbugMkODwey5cXuYru3fDYhgpvyqqooSbeF0HqEqeOgSQJO3yHwY=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2021-05-03 at 11:33 -0500, Scott Wood wrote:
> On Sun, 2021-05-02 at 05:25 +0200, Mike Galbraith wrote:
> > On Sat, 2021-05-01 at 17:03 -0500, Scott Wood wrote:
> > > On Thu, 2021-04-29 at 09:12 +0200, Vincent Guittot wrote:
> > > > Hi Scott,
> > > >
> > > > On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
> > > > > These patches mitigate latency caused by newidle_balance() on la=
rge
> > > > > systems when PREEMPT_RT is enabled, by enabling interrupts when =
the
> > > > > lock
> > > > > is dropped, and exiting early at various points if an RT task is
> > > > > runnable
> > > > > on the current CPU.
> > > > >
> > > > > On a system with 128 CPUs, these patches dropped latency (as
> > > > > measured by
> > > > > a 12 hour rteval run) from 1045us to 317us (when applied to
> > > > > 5.12.0-rc3-rt3).
> > > >
> > > > The patch below has been queued for v5.13 and removed the update o=
f
> > > > blocked load what seemed to be the major reason for long preempt/i=
rq
> > > > off during newly idle balance:
> > > > https://lore.kernel.org/lkml/20210224133007.28644-1-vincent.guitto=
t@linaro.org/
> > > >
> > > > I would be curious to see how it impacts your cases
> > >
> > > I still get 1000+ ms latencies with those patches applied.
> >
> > If NEWIDLE balancing migrates one task, how does that manage to consum=
e
> > a full *millisecond*, and why would that only be a problem for RT?
> >
> > 	-Mike
> >
> > (rt tasks don't play !rt balancer here, if CPU goes idle, tough titty)
>
> Determining which task to pull is apparently taking that long (again, th=
is
> is on a 128-cpu system).  RT is singled out because that is the config t=
hat
> makes significant tradeoffs to keep latencies down (I expect this would =
be
> far from the only possible 1ms+ latency on a non-RT kernel), and there w=
as
> concern about the overhead of a double context switch when pulling a tas=
k to
> a newidle cpu.

What I think has be going on is that you're running a synchronized RT
load, many CPUs go idle as a thundering herd, and meet at focal point
busiest.  What I was alluding to was that preventing such size scale
pile-ups would be way better than poking holes in it for RT to try to
sneak through.  If pile-up it is, while not particularly likely, the
same should happen with normal tasks, wasting cycles generating heat.

The main issue I see with these patches is that the resulting number is
still so gawd awful as to mean "nope, not rt ready", making the whole
exercise look a bit like a noop.

	-Mike

