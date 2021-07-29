Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33457C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A38F60F45
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 04:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhG2EwA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 00:52:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:48365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233660AbhG2EwA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 00:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627534306;
        bh=M0aUduVt9hJ230KHTDKM0/HpVQZIpDkRsRf3Mwsac4Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XB05mB4d3fjzamo3SlzdHE+LtbZe/5hWEATp1rnm4h0ZiPgKBucw41R3xNMKWN3O7
         SiurTwcCZDygaKXwjfmcTKaRoruQ18P8zpVj0Z4KPr93vZB0OYUyCuZEXH7kQLevx9
         2GI3CcXjzTrSW81DX7SNAXLdCUROybbMs1rkJTIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.111]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1mgogP0cet-00Z1jh; Thu, 29
 Jul 2021 06:51:46 +0200
Message-ID: <93f6d2ca59a2470ea35f3c5561a82c139191ddca.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu, 29 Jul 2021 06:51:45 +0200
In-Reply-To: <74c71cac-f36a-9c42-2ab1-837c6a068306@suse.cz>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
         <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
         <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
         <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
         <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
         <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
         <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
         <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
         <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
         <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
         <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
         <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
         <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
         <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
         <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
         <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
         <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
         <7970e9c3de5d29b93f692001a3796da1b3df45b4.camel@gmx.de>
         <74c71cac-f36a-9c42-2ab1-837c6a068306@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tY4KdP3mVSgX5kQ4T6UAkrd70zmRl0amoHPtbcsN3DhH+nbaIje
 xeOikFMAgdGCQp76h3n1eWoAgZ/03rHIQW5svvdniRSykjeHa3shvLRcV59a2K+AoIGpmDM
 bwsAVjtlWr5a3HDzCxzkCKWf3IAT35Gn03e3+klqOGGkS7p2WwqFTvjJ2ixJZ1AiWMj8kse
 UXNTykJWUUSAdDD0BaLaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PCU8uIsajHU=:VTlFzkp1zs5apzbrEQ7Ncb
 SGqHy+tB51qj1VmWgoNG90aQu+kbcTYJIrFzut9r0qxD0BeBzHtM0w/R4mRrqdl+VMBdgCW3h
 hfq0Ij669Z7OGlGhdwSHL8QnxchHmHkjO9uEWwDG9kBuYy0iVBGDHZCeuG86/57DcmLhz6Iag
 M4z+VBrrEVIS/gqTc8nJtVvoEPCG2ojmFLZ9N+/9Rs8YkTrjJrgkiOGw30Qf9AnkTcyGl7mDk
 e+vgG/jI06esXjenRJM0LCGB2GdH2Co2wsHGjhD4YcLx/g/nyD/uSPDXClOCCaqY6Ar6LNSm/
 pLa2tmrcxtuydPIntm+v3/shVHhmE/kUT5YmxzSCCyjjLeqkS/FMKWi4bQFcUzgS+4tYsurjG
 yN17JNjU3p8gflnFjJcVYDO9+NRX/ZobEO5LzjIZjKdlbjsVNGTO1LfDruNP/vPG1nWbqhUaB
 Sqj9oODMnwlytGgI3XCFb9sVsXqiVfq+fXW97aHdBYvMZ0ltQZKG1+/sT1HBonlKm+veSOy2k
 UYbEZ0T0SbIFAffyolTdZrGlkRQHnGVuF9pOtUXHbXIryzFL3dJG3VswZcYZADCATO+k+HA9W
 uLQR9i1Y4SKvonPKFdidVuZ46httM+XumsXaL+AinHpS8KcjhmFq8nAdaTkJG6rEJ6pyj8xhg
 mCgIGL1rYhuBZcpU4NI512mrpUqWC73RJMLSkMY2/6SxukKxjV9TM99G/ZfBGQq0DVnkrSCjX
 0iwQO28TMHfGaiI2AOHK/YuMVV+lDCYCFC8hfOHn1N/5hASzW6le+nd4dNtStuOx7AjF/gFPB
 VSk8/dtacRz3/Z9shhYG2DNu3AjgzB8bbnvMPAQl81jr/fz3xqkgpVMYUTiguGFaCPcwRwZmz
 AIwBewHCCiEZjjkSvyr8cjuJNusssvPYeuDjGZVZQpclirJ7yMoIbsYGgOAt5C7PjikwtsLDZ
 X49Wb+GJ1iEGQ9iynBXH+t2hAD3T84jNtVJ4aZrbCC2HBCpTdAgzzDpohxcyaCeEch8bPsxtw
 yO4LRyMh+mlGaC1ChVabuWSX80/v8ZHe9xmqWSLgXh92wqPbQADLotUeYvbexM0y2pvHRTWx5
 4xGm8j/TGKc1ufn+BS3gYSEwnYy37OFhfeK
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2021-07-28 at 18:59 +0200, Vlastimil Babka wrote:
> On 7/27/21 6:09 AM, Mike Galbraith wrote:
> > On Mon, 2021-07-26 at 23:26 +0200, Vlastimil Babka wrote:
> > > On 7/26/21 7:00 PM, Mike Galbraith wrote:
> > > >
> > > > Why not do something like the below?...
> > >
> > > Yep, sounds like a good approach, thanks. Percpu partial is not *the=
*
> > > SLUB fast path, so it should be sufficient without the lockless cmpx=
chg
> > > tricks. Will incorporate in updated series.
>
> The updated series incorporating hopefully all fixes from Mike and
> bigeasy, and rebased to 5.14-rc3 (Thomas told me RT is moving to it), is
> here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=
=3Dslub-local-lock-v3r0

I had to resurrect the hunk below to build with lockdep, but modulo
dinky speedbump, the same RT testdrive that previously exploded was as
entertainment free as such testing is supposed to be.

=2D--
 mm/slub.c |    4 ++++
 1 file changed, 4 insertions(+)

=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -2890,7 +2890,11 @@ static void *___slab_alloc(struct kmem_c

 load_freelist:

+#ifdef CONFIG_PREEMPT_RT
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
+#else
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
+#endif

 	/*
 	 * freelist is pointing to the list of objects to be used.


