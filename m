Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38012 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeLFOcD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Dec 2018 09:32:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so524232oii.5
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Dec 2018 06:32:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJfkoWpnXJtTo2qkX2UkNeWX6Q7f2=g=sryi2HY1YZRtjSBVcg@mail.gmail.com>
 <20181206091008.62d7cwuwhxrx3s3b@linutronix.de> <CAJfkoWpCsD7cS5Ff2gV8nt4r6ZSusgzcO98riRrUb052g+L89A@mail.gmail.com>
 <20181206104140.3xvwzf7svzpc6set@linutronix.de> <CAJfkoWrLPTrBo0hfp0Lq-8-S_hHsgbQRyV=h5EbY8v1LcjRA4A@mail.gmail.com>
In-Reply-To: <CAJfkoWrLPTrBo0hfp0Lq-8-S_hHsgbQRyV=h5EbY8v1LcjRA4A@mail.gmail.com>
From: Luca Abeni <lucabe72@gmail.com>
Date: Thu, 6 Dec 2018 15:31:50 +0100
Message-ID: <CAJfkoWqYENjCyBC5YfN6T-d7g5u=uHBTPHCmJRzH82uywpGbmw@mail.gmail.com>
Subject: Re: PREEMPT_RT and i915
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org

Update, after more tests:
- With all the "*DEBUG*" entries disabled in .config, "nohz=off" in
the kernel command line and the i915 driver disabled in .config, I
consistently get a worst-case latency below 40us (this is the order of
magnitude I was expecting). Good
- With everything as in the above configuration, but enabling the i915
driver in .config, I get a worst case latency of about 80us. Applying
Sebastian's patch does not seem to affect the latency. I also disabled
the various tracing options in .config, but the maximum latency is
still around 80us.

The latencies mentioned above have been measured with
  cyclictest -n -p 80 -i 50 -t 1 -m -a
while running "du -h /" and a "make -j 2" of the kernel in background.

So, the numbers I get now are much better, but the i915 driver still
seems to create some real-time issues.


Luca

On Thu, 6 Dec 2018 at 12:16, Luca Abeni <lucabe72@gmail.com> wrote:
>
> Hi Sebastian,
>
> On Thu, 6 Dec 2018 at 11:41, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> [...]
> > > BTW, playing with some options I discovered that if I add "nohz=off"
> > > to the kernel commandline I get a maximum latency of about 150us when
> > > using the i915 driver, and less than 100us when not using it. I am
> > > going to test your patch, and to disable debugging and tracing... I'll
> > > let you know the results.
> >
> > Is it better or worse with nohz=off? And do you get the backtrace?
>
> The latency with "nohz=off" is about 150us smaller than without this
> boot option.
> I did not get any other backtrace.
>
> Some preliminary tests show that disabling debug options and .config
> reduces the latency to less than 50us (but I am still running
> experiments). I'll also check if your patch allows to get the same
> latency values with and without the i915 driver.
>
> Thanks,
> Luca
