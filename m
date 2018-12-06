Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:52114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeLFPNr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Dec 2018 10:13:47 -0500
Date: Thu, 6 Dec 2018 16:13:44 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PREEMPT_RT and i915
Message-ID: <20181206151344.754bbqitnenejjuq@linutronix.de>
References: <CAJfkoWpnXJtTo2qkX2UkNeWX6Q7f2=g=sryi2HY1YZRtjSBVcg@mail.gmail.com>
 <20181206091008.62d7cwuwhxrx3s3b@linutronix.de>
 <CAJfkoWpCsD7cS5Ff2gV8nt4r6ZSusgzcO98riRrUb052g+L89A@mail.gmail.com>
 <20181206104140.3xvwzf7svzpc6set@linutronix.de>
 <CAJfkoWrLPTrBo0hfp0Lq-8-S_hHsgbQRyV=h5EbY8v1LcjRA4A@mail.gmail.com>
 <CAJfkoWqYENjCyBC5YfN6T-d7g5u=uHBTPHCmJRzH82uywpGbmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfkoWqYENjCyBC5YfN6T-d7g5u=uHBTPHCmJRzH82uywpGbmw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Luca Abeni <lucabe72@gmail.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-12-06 15:31:50 [+0100], Luca Abeni wrote:
> Update, after more tests:
> - With all the "*DEBUG*" entries disabled in .config, "nohz=off" in
> the kernel command line and the i915 driver disabled in .config, I
> consistently get a worst-case latency below 40us (this is the order of
> magnitude I was expecting). Good
> - With everything as in the above configuration, but enabling the i915
> driver in .config, I get a worst case latency of about 80us. Applying
> Sebastian's patch does not seem to affect the latency. I also disabled
> the various tracing options in .config, but the maximum latency is
> still around 80us.

The patch should avoid the backtrace you sent at the begin of this
thread. This one happens otherwise if you enable the i915 events.

> The latencies mentioned above have been measured with
>   cyclictest -n -p 80 -i 50 -t 1 -m -a
> while running "du -h /" and a "make -j 2" of the kernel in background.

So this should fire one thread on CPU0 up and I believe and pin it
there.
That interval looks very low. I would suggest to increment it around 200
or so.

> So, the numbers I get now are much better, but the i915 driver still
> seems to create some real-time issues.

The i915 could increase the latency a little. You could try to add
	i915.enable_dc=0 i915.enable_rc6=0

to disable power management on the GPU.

> 
> Luca
> 
Sebastian
