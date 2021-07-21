Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E8C07E9B
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 04:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B784611C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 04:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhGUEQB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:16:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:43123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhGUEP5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jul 2021 00:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626843382;
        bh=j3gXYD1/RFC+vfMB/LRp2Kww3W261kkIitdKWMPK0OE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jQBjJH2i2cUZR7hK9jMXh5oqlTbcqcLhKrFUIHANAOCBkhuX2NRisJK4S1HXbW9X4
         B+9KHG/AcigU31SXUkLeUBIGrK0yND7kTluPhCuSUisMWerO65V0P5YnyMD9Guq95P
         vWY50DcgnzZbrARCHd/+J4Pv3urZc37/cZIEUAF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.108]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1lNtl01mzY-00iCWl; Wed, 21
 Jul 2021 06:56:22 +0200
Message-ID: <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 21 Jul 2021 06:56:21 +0200
In-Reply-To: <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Te6jTaO4amfpJi+b83efejJQbLW7GVVDdCsg0lWhtJlSbxqmXrC
 2IN84GOSHfFhkkwjqhJX8x9seWJb07e7j5mE6ZvdyAy+mWvLE17iGnacM8kEOlAgbuxlThC
 uHeqFmZVq1zMCaQpXBaQ+gNJiN7O9wprdk0QKBSLNldvsnDKZDqGs6hpQDeU/RbeVb/0a5a
 RNqDN/slwgl3iEIkFPisg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BVJAN3Vuxio=:XasT1JG7FKa9yzD4yf/KrJ
 OmJMOTLYncxUJ4smYrApyWWVGNGDWfy1D1fwWa7Y/gPnGIdzOgsxWYLaGBa4tr6Q5a1gfhCjP
 NNfro76FQx9xt1pygABauN4js/C8CNt4eT0RM+3ktLs5TEgjF+yMvT8ggfQ5bde9hDsCPd3Ml
 nBgVOvfIgAM0HDumV02FPBGthwlVFF3ZVFokP+AhCyVKlPUAAmimsv2fxm+qRa+nGwlkJFX08
 N2sW0JBUQ0aGouC3L2/bKPhkdE9NFpU+Y85zXDnLkXX9oUqUzAcMRyTSUUGQIwcUVyUCu25K2
 hfdt1z6ZNvn8Hnd4RbtURPD0Z5fOJAy/YXX5mm/MhRoqpqxl+QLK+V4ygcsKql1UIJGK4vvC+
 SykBQmiROQoLG4W4L95pqA5SU26HYI5udDb32uYFG6qRFGNuV+XqSdFgSdNTVxKeiCYD8ICRS
 tfhBGWejHLW+XXQWeKm6yU3rhwdD/JNErD4693hW1fu9hI8rciT3cCECBuLOJRiroFVZ8rW7r
 jgfPg9GEe6z+VAhag4R3TyW9bHK3fa9aWkcWvTpbWTGYPxrqSGfQlmynYILCZZxVRLEEBEzFP
 HtjpUbUI6DhFOJwv2xFMqfO3TUA04YKsxJKu2vZaw93jdYuSa3O/EbSAAT8CrhxY1F+5sj/dT
 f2WhcjXWDcBq+kS0iK53duVtOBdjI8SC6AGUzLvFPGTmUhtdPXDSq3J+8k8IM76Ho+urWMkYQ
 pRQzMBsE1J6WhY2xCO6aBz5HgvumkyuH3si0sJnV97vOIhje3z8gND5hMB02A2xpY0LlrXcHl
 1Uq/s4mtcOxJPFYWWJfiIwJ8mWZodNZdG4sq7W90Y3uqX1WtocGTJWqHHiLTU9dE3raYThjcL
 GT7qirXFkNNo2ct/a/TQiUDcrnpEem4REvZ90OIZp7t7bgRyl/7xE1Z+jBR3HUgfC0Raty4kO
 FcdMI6uLVcvlK27aq16jCZTe0+KKuEnLx9a48v0tPZyX0+EfQpT2IQG1I4J5pYN4EOhI5ZPLa
 aJvNjrIO8A+zOLoyVS7GdvANNysQiTc4OayOyaPDsYoT8gtPHloikrGIXI0pGVa+4woecuoqm
 jtBjXJZaE1Yyk3VunrPuqh9Qw3v9iOTCjvZ
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2021-07-20 at 13:26 +0200, Mike Galbraith wrote:
> On Tue, 2021-07-20 at 10:56 +0200, Vlastimil Babka wrote:
> > > crash> bt -sx
> > > PID: 18761  TASK: ffff88812fff0000  CPU: 0   COMMAND: "hackbench"
> > >  #0 [ffff88818f8ff980] machine_kexec+0x14f at ffffffff81051c8f
> > >  #1 [ffff88818f8ff9c8] __crash_kexec+0xd2 at ffffffff8111ef72
> > >  #2 [ffff88818f8ffa88] crash_kexec+0x30 at ffffffff8111fd10
> > >  #3 [ffff88818f8ffa98] oops_end+0xd3 at ffffffff810267e3
> > >  #4 [ffff88818f8ffab8] exc_general_protection+0x195 at
> > > ffffffff8179fdb5
> > >  #5 [ffff88818f8ffb50] asm_exc_general_protection+0x1e at
> > > ffffffff81800a0e
> > >     [exception RIP: __unfreeze_partials+156]
> >
> > Hm going back to this report...
> > So could it be that it was stillput_cpu_partial() preempting
> > __slab_alloc() messing the partial list, but for some reason the
> > put_cpu_partial() side crashed this time?
>
> Thinking this bug is toast, I emptied the trash bin, so no can peek.

I made fireworks while waiting for bike riding time, boom #10 was
finally the right flavor, but...

crash> bt -sx
PID: 32     TASK: ffff888100a56000  CPU: 3   COMMAND: "rcuc/3"
 #0 [ffff888100aa7a90] machine_kexec+0x14f at ffffffff81051c8f
 #1 [ffff888100aa7ad8] __crash_kexec+0xd2 at ffffffff81120612
 #2 [ffff888100aa7b98] crash_kexec+0x30 at ffffffff811213b0
 #3 [ffff888100aa7ba8] oops_end+0xd3 at ffffffff810267e3
 #4 [ffff888100aa7bc8] exc_general_protection+0x195 at ffffffff817a2cc5
 #5 [ffff888100aa7c60] asm_exc_general_protection+0x1e at ffffffff81800a0e
    [exception RIP: __unfreeze_partials+149]
    RIP: ffffffff8124a295  RSP: ffff888100aa7d10  RFLAGS: 00010202
    RAX: 0000000000190016  RBX: 0000000000190016  RCX: 000000017fffffff
    RDX: 00000001ffffffff  RSI: 0000000000000023  RDI: ffffffff81e58b10
    RBP: ffff888100aa7da0   R8: 0000000000000000   R9: 0000000000190018
    R10: ffff888100aa7db8  R11: 000000000002d9e4  R12: ffff888100190500
    R13: ffff88810018c980  R14: 00000001ffffffff  R15: ffffea0004571588
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff888100aa7db0] put_cpu_partial+0x8e at ffffffff8124a56e
 #7 [ffff888100aa7dd0] kmem_cache_free+0x3a8 at ffffffff8124d238
 #8 [ffff888100aa7e08] rcu_do_batch+0x186 at ffffffff810eb246
 #9 [ffff888100aa7e70] rcu_core+0x25f at ffffffff810eeb2f
#10 [ffff888100aa7eb0] rcu_cpu_kthread+0x94 at ffffffff810eed24
#11 [ffff888100aa7ee0] smpboot_thread_fn+0x249 at ffffffff8109e559
#12 [ffff888100aa7f18] kthread+0x1ac at ffffffff810984dc
#13 [ffff888100aa7f50] ret_from_fork+0x1f at ffffffff81001b1f
crash> runq
...
CPU 3 RUNQUEUE: ffff88840ece9980
  CURRENT: PID: 32     TASK: ffff888100a56000  COMMAND: "rcuc/3"
  RT PRIO_ARRAY: ffff88840ece9bc0
     [ 94] PID: 32     TASK: ffff888100a56000  COMMAND: "rcuc/3"
  CFS RB_ROOT: ffff88840ece9a40
     [120] PID: 33     TASK: ffff888100a51000  COMMAND: "ksoftirqd/3"
...
crash> bt -sx 33
PID: 33     TASK: ffff888100a51000  CPU: 3   COMMAND: "ksoftirqd/3"
 #0 [ffff888100aabdf0] __schedule+0x2d7 at ffffffff817ad3a7
 #1 [ffff888100aabec8] schedule+0x3b at ffffffff817ae4eb
 #2 [ffff888100aabee0] smpboot_thread_fn+0x18c at ffffffff8109e49c
 #3 [ffff888100aabf18] kthread+0x1ac at ffffffff810984dc
 #4 [ffff888100aabf50] ret_from_fork+0x1f at ffffffff81001b1f
crash>

