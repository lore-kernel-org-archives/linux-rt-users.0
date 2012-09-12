From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 12:01:41 -0700
Message-ID: <02D8B38C-C6C2-43A8-B601-721B48612106@thebigcorporation.com>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Hartmut Behrens <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45779 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2ILTCM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 15:02:12 -0400
Received: by pbbrr13 with SMTP id rr13so2727557pbb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Sep 2012 12:02:11 -0700 (PDT)
In-Reply-To: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sep 12, 2012, at 3:20 AM, Hartmut Behrens <hartmut.behrens@gmail.com> wrote:

> Hi,
> 
> I have patched a 3.2 kernel for a OMAP compatible processor (ARM
> Cortex A8) to be used on an Gumstix Overo with the CONFIG_PREEMPT_RT
> patch.
> 
> I have noticed that the latency of the patched kernel on this platform
> is <300usec (using cyclictest), similar to what is reported for the
> ARM9 platforms at
> https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch
> 
> Is this the best performance that can be expected from ARM7/9 platforms?
> 
> Could it be improved by using different kernel config settings - e.g.
> CONFIG_LATENCY_TRACE=n  -
> https://rt.wiki.kernel.org/index.php/Cyclictest mentions that latency
> tracing adds significant kernel overhead?


There are a lot of options that can be eliminated / optimized to reduce memory footprint and overhead.

If you are not using large scale SMP features, things like cgroups, name spaces and so on may shave a few nanoseconds here and there, and that adds up.

You'll have to experiment with the configs, but for typical embedded, less is more.

Historically, if you can run a UP configured Kernel, that tends to be much more lightweight.

The OSADL configs Carsten referenced in separate email are certainly a good starting point.

If you find compile errors as you twiddle with options, please do send the relevant snippets to this list.

Thanks

Sven



> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

