Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeEGNPH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 May 2018 09:15:07 -0400
Date: Mon, 7 May 2018 15:15:05 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT Patch and Xen
Message-ID: <20180507131505.tv6qz4rzvya5o3no@linutronix.de>
References: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CALC81-sg=86AZgZv4bGSNPJEmw3r_j=yNv5HuGPBWKMYVoXJ1A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Iain Hunter <drhunter95@gmail.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-04-30 12:05:52 [+0100], Iain Hunter wrote:
> Hi,
Hi,

> I am using 4.9-rt1 on an Ultrascale+ device which is running Xen.

I strongly suggest to use a more recent kernel.

> 
> By default whenever I enable RT Linux then Xen is disabled according
> to the patch "arm64/xen: Make XEN depend on !RT" in
> 
> https://marc.info/?l=linux-rt-users&m=144509814328860&w=2
> 
> 
> Can someone explain the background to this patch (which appears to
> still be in latest 4.14 development release)?
> 
> Is it simply because Xen drivers in the kernel fail to build due to an
> include file problem (which I have worked around)
> Is there a fundamental stability problem on 64 bit ARM when RT Linux
> is running in a DomU? Initial runs of cyclictest don’t show any.

I can't find the history behind this. Speaking as of v4.16-RT it builds
and I have no XEN setup.
If CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_ATOMIC_SLEEP and lockdep isn't
complaining then I might drop that patch with your tested-by :)

> Thanks,
> 
> Iain

Sebastian
