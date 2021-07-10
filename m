Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B4C07E99
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Jul 2021 01:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808A6613C7
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Jul 2021 01:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGJBPm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 21:15:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:49741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhGJBPm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 21:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625879566;
        bh=AfbmQioaIgUOpX+3WohljVEyjO6jBjUFgGyewZhusW0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hje9zyy1oHWHBDlMvCmljG5K+eSqkDBwRFgLv33VWuDIp4eesCMiK7lar5t+cWvkw
         3RZ2wwPXW3pecVpi9Tj47W4b+yBrud0CdZOwc8GFQUA2qDB5oVTHgopMZ20ia07KFe
         XxV7WxDZjgRUvDUaOd/VibueFJJcXzFrhMaM6ByU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.248]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1lWWoa0sqk-00heEW; Sat, 10
 Jul 2021 03:12:46 +0200
Message-ID: <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 10 Jul 2021 03:12:45 +0200
In-Reply-To: <878s2fnv79.ffs@nanos.tec.linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
         <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
         <878s2fnv79.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xBaGWs5k2ch5diNHmWabjEqX0vryaK72xMsK6VLJRuTIyg73r8B
 ksdfQLfPf0NIPnfTcGb/uHb9GyPoDgkTWq54+rjIYrBvB5ZimcKq24oN299Qsfy9YZh5lgD
 M9IZW858fCNobJTvQdIuJ4TFhhp/Sg8IJZSUv5EaJjznN+4/8HsKDVm86Diymp+esYglTg6
 RR7B9xVc9+YyDAFIrBsAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8fbcXRQAGI=:3NFsYjLlOfHuO2tjsDGJk+
 pK/DXi7v27Kh0us8yJyQkDGFzwaw6tj9G/nDQxXDTrEbudMUsaXXnBe700ymKwsg3BSD0ZQoZ
 GgxK7N/Ha6YT9qrAD5at6awkhw8EZeix2RPLsUUukhapBl1Jl0GL7CvTZSChW/SNJ7AXNlq/c
 0VZ/IGR3lDRAsKz2e4F4MlZLe4+/ydzJzOkmJlroON8yjMzKjRsBK6TMvRfirM4K1hr2v7pK7
 j4TqnfC1SOELcIpCViCzEf00bKl6iv6kKn/bI7rJYFlaiKP/Olaje25+HEihHnvVPMI56Xvdg
 GDZGsqi08fD3hLFEBypqPxASWN8+7UEfZdmSA+3P/dmtzDTzlbYRNbsgLZj5wGva50BMDciO/
 Ea9w+JlI8xh+owVpWTgqbHtHVRuvi2a+5aXLUQa7dl31WHnJqH0JPQL8LgI7vGQ0Hppkoxcap
 n4oniSCaOAdOq5t83zd77T4532JNvQY8vcLsGf8pwB79Ft6Ua5a23eM0Ux14weonZzqKVqiRR
 jfhAp8KasQN5m264Vs1o9S36G67i1pfL90QGQk8orob9QYIbiYIC6BicT3RJB7Aq0iXBlnMTj
 azdke4/VJHOvJJLVFK8LfCe+2spZ8GKH0JtK0HUKUAQsSYGsOLLdINIDU9Ipz/bIrVDBf+8Fs
 CSarbV6BnmPTH9EIOWljgSuzMLty2RWV9enNLVLT+wdr0eJZkQtAtKzqdm6HapmEw64NkEATF
 2yF49goJTCCzNfNQqcyePLKxVc913wRr+RNXK0oiNyL/Tz4AtI3/a9HdZVNW3bAI5zpj9MScL
 bPDEoJAuEuTc1rn5xM7qUkQjkZ8AIDrA9pe0MGvzpQe+2ZEBdqWEPfmhLUWI0oM4aImmUr5du
 CziOnofTEtihZqcZIwmm9Jvtxl1GTVm4ZNOtgUxL73C5tOwaqZTDaZlooX+Sh6Ay3ABrGtjBN
 XuYbUIXSWOhmKoKhEQKWRlOsR1Yz/BohBdzv+DCnrqkPxmr7q1plJWWpPEF6saXhZBbuRJ8rT
 JXXUi3Oi24Vn1I5d3aq+CySt8TmG1RZrr2xe9DgaYRDTXBptJ3wD45YwZYhq8d2CfxkUngpAR
 5++su8qJTOrj1t7nNIVDfjLk2OBdG6y8U06
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-07-09 at 21:28 +0200, Thomas Gleixner wrote:
> On Fri, Jul 09 2021 at 07:21, Mike Galbraith wrote:
> > static bool has_cpu_slab(int cpu, struct kmem_cache *s)
> > @@ -2632,8 +2636,11 @@ static int slub_cpu_dead(unsigned int cp
> >  	struct kmem_cache *s;
> >
> >  	mutex_lock(&slab_mutex);
> > -	list_for_each_entry(s, &slab_caches, list)
> > +	list_for_each_entry(s, &slab_caches, list) {
> > +		local_lock(&s->cpu_slab->lock);
>
> This one is odd. It locks the cpu_slab lock of the CPU which runs
> thiscallback and then flushes the slab of the dead CPU.

That spot I put back only because it used to exist, ergo I documented
it as an afterthought.  Yeah, it clearly has nada to do with the
explosions, those were stopped by the other two as previously reported.

	-Mike

