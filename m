Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C436EC433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Oct 2022 23:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJLXOT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLXOS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2022 19:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC3125733
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2022 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665616456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqwb/Kivn0cVLODbKZk5dVLdc2SwAlFYIctunMKpz+0=;
        b=gm8bY2k1l2YQcik53+2HZItVlOhfeVoOFbXFMo0n1SOmTVKBAGtWWZMmJZ36ZDv6WPzUPU
        gqBF0IWVaFJF8ZtlxnjiFml5etKxj5JVwk/xuRTw9vtCbMBtU8GnSWSngwBUGpUPvS5HrD
        k7SzPOfUE9+qSKTnoAKR5iv+pWQtESo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-XF-eMfydO8OnrY_PQ1aGGw-1; Wed, 12 Oct 2022 19:14:15 -0400
X-MC-Unique: XF-eMfydO8OnrY_PQ1aGGw-1
Received: by mail-lj1-f197.google.com with SMTP id q5-20020a2e84c5000000b0025ec9ff93c8so108025ljh.15
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2022 16:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqwb/Kivn0cVLODbKZk5dVLdc2SwAlFYIctunMKpz+0=;
        b=MwEjRgRmB9L77P090MDvm5dZ9fU5VKImCAU9Tb6v/pYnYZnux8ZWWzBpijDEuItc7E
         8nkPc7AnIFeyz2mpO0O+7J2MZ4OcvjzygXe5Lz+cE0P1k/+/9Ar+2F9D53XQJ9uC8Eok
         Ci5oxwXwaBBPXH2kvNrhr7l9wB0x0DBYVZkK3QcT/e5JKCDfSwKg/4IcnKYzns8pqRNy
         +PEI8fV3HC9Ip9xnke0eG2FLueRupMkVcvdIhpNDN8OkkV/qVPjnSiesgsi7UfAGXV84
         oVCyMXc9QMribwjm7N0+tbh1aZCjyCwhhCdirhbPTbe8A64DnGyG1S/ILPfhnjSvnbp9
         CXEA==
X-Gm-Message-State: ACrzQf3F1eEO35kRSIuollohoTanQu3VjsctCI8KVDNyp8ljxYIhLZpV
        b63qzicdyKAOglso8tYAwmkxk+LkTV1+mahAXgNdFq84CRopIcKil8PS+xn85D3MQCwcjHsxoGr
        rovGgl2zaLtqoNj8nomtFbG/YWO2VGmN0SaHVWNM+sFo=
X-Received: by 2002:a05:6512:511:b0:4a1:7ac2:2a83 with SMTP id o17-20020a056512051100b004a17ac22a83mr10692784lfb.175.1665616453597;
        Wed, 12 Oct 2022 16:14:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM62ixw97/4G385DFzE8zkXiKtey4eHUSifH3sEdkcoIW925+Ov5lrbeK2wxu6JLmnueQs1uMNi4Fx5ENUfaioU=
X-Received: by 2002:a05:6512:511:b0:4a1:7ac2:2a83 with SMTP id
 o17-20020a056512051100b004a17ac22a83mr10692777lfb.175.1665616453310; Wed, 12
 Oct 2022 16:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
In-Reply-To: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
From:   Clark Williams <williams@redhat.com>
Date:   Wed, 12 Oct 2022 23:14:02 +0000
Message-ID: <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
Subject: Re: SCHED_OTHER > SCHED_FIFO?
To:     Sebastian Kuzminsky <seb@highlab.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

It's never a good idea to use fifo:99 for a realtime application; the
migration thread uses fifo:99 and all the interrupt threads run at
fifo:50, so your busy-wait fifo:99 thread is holding off interrupts
(devices, IPIs, etc) on tho

Try running your SCHED_FIFO thread at something like fifo:2 and see if
your performance improves.

Clark

On Wed, Oct 12, 2022 at 9:35 PM Sebastian Kuzminsky <seb@highlab.com> wrote:
>
> Hi folks, I'm seeing a behavior I don't understand, that I'm hoping you
> can help me with.
>
> The setup is:
>      Raspberry Pi 4 (4x ARMv8 Cortex-A72)
>      Debian Bookworm arm64 (https://raspi.debian.net/tested-images/)
>      Linux 5.19.14 with 5.19-rt10 patches (config in git repo below)
>      cmdline:
>         irqaffinity=0-1
>         rcu_nocbs=2-3
>         rcu_nocb_poll
>         nohz_full=2-3
>         isolcpus=nohz,domain,managed_irq,2-3
>
> On this system I run a realtime thread that does all the
> latency-reducing tricks I know of:
>      kernel command line as specified above
>      cpufreq scaling governor = performance
>      mlockall()
>      set cpu affinity to an isolcpu processor
>      run in userspace continuously, never sleep or yield the cpu
>
> The surprising behavior is that if I set the realtime thread to use
> scheduling policy SCHED_FIFO, and set its priority to the max, i get
> terrible behavior - lots of preemption, and lots of idle time on the
> CPU.  On the other hand, if I leave the realtime thread with scheduling
> policy SCHED_OTHER, and the default priority of 0, then the system
> performs great - hardly any preemption.
>
> The test program is here:
>      https://github.com/SebKuzminsky/preempt-rt-latency-test
>
> That program does the process-wide realtime setup, then runs a realtime
> thread with SCHED_OTHER (which performs well), joins that thread and
> instead runs a second thread with SCHED_FIFO (which performs poorly).
> It doesn't matter which order I run the threads in, SCHED_FIFO first
> still performs poorly.  Both threads run the same function:
>      busywait 1 ms (using the hardware cycle counter for timing)
>      check the cycle count
>      repeat 10k times
>      return
>
> So it doesn't do anything useful, it just looks for latency.
>
> The results look like this:
>
> > using PTHREAD_INHERIT_SCHED to keep SCHED_OTHER (with default priority)
> > scheduling policy: SCHED_OTHER
> > scheduling parameter priority: 0 (min=0, max=0)
> > cpu affinity: 3
> > after 10000 iterations:
> >     min=54001 cycles (1000.019 us, 1.000 ms)
> >     avg=54002.001 cycles (1000.037 us, 1.000 ms)
> >     max=54009 cycles (1000.167 us, 1.000 ms)
> > OK: worst latency < 2 ms
> >
> > using PTHREAD_EXPLICT_SCHED to set SCHED_FIFO (with highest priority)
> > scheduling policy: SCHED_FIFO
> > scheduling parameter priority: 99 (min=1, max=99)
> > cpu affinity: 3
> > after 10000 iterations:
> >     min=54001 cycles (1000.019 us, 1.000 ms)
> >     avg=78900.171 cycles (1461.114 us, 1.461 ms)
> >     max=53188533 cycles (984972.833 us, 984.973 ms)
> > ERROR: worst latency > 2 ms
>
> The results with SCHED_OTHER are great, but the results with SCHED_FIFO
> are terrible.  This is surprising to me!  I'd expect a thread using
> SCHED_FIFO with max priority to behave at least as well as a thread
> using SCHED_OTHER with the default priority.  Am I misunderstanding
> something here, or is this a bug?
>
> I'm happy to run any experiments people suggest.
>
>
> --
> Sebastian Kuzminsky
>

