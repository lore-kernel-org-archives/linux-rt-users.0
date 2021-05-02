Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDDDC433ED
	for <linux-rt-users@archiver.kernel.org>; Sun,  2 May 2021 03:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0507611C2
	for <linux-rt-users@archiver.kernel.org>; Sun,  2 May 2021 03:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEBD11 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 1 May 2021 23:27:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:47633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhEBD1S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 May 2021 23:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619925937;
        bh=2N9IcHZFQtoPTdk//339A4s/KH/fyDjSlR40GygCdgs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=F9HhQnROq9lb7hO4N3fbikRju1DQ74c8of6ozU/Vvg/jI/ZHrGo7qC5RpOHj/Bqat
         +wsRwN71bU350gKhLUU/UtbHPkrS4YGdJ08Xj19UPUgqG280oTy3Myo1a9+uP2NpQq
         uu4EhOA5QPcpQP7jAZ+pU7a+5uZFJ4mcLb98Twwo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.51.49]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1lAKU60nal-00lEsn; Sun, 02
 May 2021 05:25:37 +0200
Message-ID: <a46f9b6c719666357e568eadd1d615c05c4171ac.camel@gmx.de>
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
Date:   Sun, 02 May 2021 05:25:35 +0200
In-Reply-To: <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
         <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
         <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VEVNQPCsUrHT38mp2SxP6v0WAoW4DvawsjmXK65jqDr2eSkOTyF
 WAdf9cUjsu09bTqWu0V5samCXKjKshzqo5bYXjdrWfYWPGEwmID379BTw79aeh5fgwlA/Hi
 M5KKV5mx5MhJ1BZuUJbb1geg5GSEkZxgCFTvSzmXa7EhpQ44Orv8y0X347921jpKhmoGMbP
 gWeDyGb6+EA926whOoacA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9Wdx0HjpFw=:VLQ86+kYT2pLlPGak2FY7u
 Qz2JWRtqpxR1nvIw3WF6RzDZBZ08Kpd950rTrlyN+ZpP8+1Q6GSnLoDDk7Yzps0mtxz167zeS
 TEFaW7oKrzWEhx2vv98VIEwKODJPUk3o4hezLjMnGaGelSOyjXhtQTbFbuDsZeaP90XDlV1XE
 cSDAmWvjh4iSmip2q9FA1h0GlvWQQUvKzKOiwDE7IYuHXxsEGaIEJ15gRMdSUDVLxUwccLLBl
 xMgj3fKDlz1AuXuM209Jc3nb8aJ0y3SnSEeSQbqikTClO4ovULTRx+jBONOFYQIgarcUjqfvs
 f5ekeI7pC2b32skkvFWPjyDw9RTBWhfZzMhPif2teNC5X76Wi1Ys6MF6lh5j7RRWPCaM0RKii
 ebeiUFlnCVh3jL00orrhueeK4con/Lw6Rnq2vOabVK83X7nyN6839GZD/mzPiVWzgEGryuNSH
 MsI4Jg4cHaLV/1tuYe3PRN/JQJEWJzDOn6btCSWY8VJmuXhgRXGpoJ0j8MtnKZ53WHjMRZ590
 IPYSJp25ACv54X6CnQKZwdXFTiAn0EwXlIXd7LvIcowQt2MBGZcZy2SQ4DGH/Hg0xV7YnmHs5
 0oXKwnMZhMI8lLvg3UXsbqn0wswkxDGOmxtOkncFAVodS/T665aBfo91WEnbgxh6JGoK1U2+t
 1cSvdn0jfsqE8C1T2lexSAY1SuZ1qinrsp0nhABq/9OizX8zVAVHnKAJKEOq1cpRDU/xZk7Fp
 WvyWQ/y9f9zSyu0qb4Bm2hfb4MTwk8P/mD2nfDTSO+xrXJDReZZVGouulI0DUsvemR2qrMKoP
 OhOLOhJSnYKK9ckwxWwdNrGiF7s5r3QSp8BaH9IMXVv4VOC1Y++9/pzu7O1RAZj/TWljQCsBX
 YnEe6Ho3Q51okOyo/IWVaUZDCoebZsoqGmujgD95WaI7mED1EfEkNX8qCjczaqojtGWrm5wzR
 D+jLkbqv4j4DoEUKT9+piqzX4FfM8sh8cTskiPTLRkYKzfLBpocpRuS+joSrshW3xhIUzMhMr
 oqH7bl5ZTwVHxoNvhzmQxW28oCJK7Euy6KMCcHDUaPtcv5JFjBVmqFWIu2r22jcGKQ76lU8JM
 pukl8wCx52SBWsJqu+tcP/FMmWp/NMOyYbe+9sr6o9pV7HLjkkStgYdqp6iCqu0PM3eIj67u/
 GyAWjsw0oIMgZcKkguDlHNYLa3L1t2XW+kPN2a0e5p0SDF7wDnbsRNY+3stOFDp5GUDqY=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 2021-05-01 at 17:03 -0500, Scott Wood wrote:
> On Thu, 2021-04-29 at 09:12 +0200, Vincent Guittot wrote:
> > Hi Scott,
> >
> > On Thu, 29 Apr 2021 at 01:28, Scott Wood <swood@redhat.com> wrote:
> > > These patches mitigate latency caused by newidle_balance() on large
> > > systems when PREEMPT_RT is enabled, by enabling interrupts when the =
lock
> > > is dropped, and exiting early at various points if an RT task is
> > > runnable
> > > on the current CPU.
> > >
> > > On a system with 128 CPUs, these patches dropped latency (as measure=
d by
> > > a 12 hour rteval run) from 1045us to 317us (when applied to
> > > 5.12.0-rc3-rt3).
> >
> > The patch below has been queued for v5.13 and removed the update of
> > blocked load what seemed to be the major reason for long preempt/irq
> > off during newly idle balance:
> > https://lore.kernel.org/lkml/20210224133007.28644-1-vincent.guittot@li=
naro.org/
> >
> > I would be curious to see how it impacts your cases
>
> I still get 1000+ ms latencies with those patches applied.

If NEWIDLE balancing migrates one task, how does that manage to consume
a full *millisecond*, and why would that only be a problem for RT?

	-Mike

(rt tasks don't play !rt balancer here, if CPU goes idle, tough titty)

