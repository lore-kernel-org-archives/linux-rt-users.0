Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F60C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Oct 2022 07:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJMHek (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Oct 2022 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJMHeh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Oct 2022 03:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444911E47F
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665646474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBoaoUzktCeNhsfWLAooIBreqbEJBwoyTEZnZ6IpFLk=;
        b=GONUzANU/1V3JuWek7D9PrZ6r0SYqP8n7nsQ0p135ll0iLYsm3MGpQ/yLlA/U7UDVIAS4m
        9ZK2vXqueVm4bE5VBe3qMXnfY16FjkuqlRM8FudZ77jKfAz6OI9WhT3tAKGV2JZ4Fw4Juv
        UlsqSS73oZEIvtUn11RQDozF3ZbNqe8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-6HktQ3PJOfio8-sDHEBisg-1; Thu, 13 Oct 2022 03:34:33 -0400
X-MC-Unique: 6HktQ3PJOfio8-sDHEBisg-1
Received: by mail-ej1-f71.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so458930ejc.0
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Oct 2022 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBoaoUzktCeNhsfWLAooIBreqbEJBwoyTEZnZ6IpFLk=;
        b=RJ8do3YGe1NuhpWA52e8v/6k5YDfIm7yojQLu1UmfrUqlIODHckQq9RdtaIrUeI8q/
         a4wblakTTFrDsGnDm8okqq1ku5W2Sa3ffYfeZIO5FpD4aNCOv0u25HnaO7W0MvD7sWXC
         uabpmX+pjIAN4D4HyhYcF4w1cPrAlnqaxozhJmZA1+K14zl1sLwGXNaRHDA4CDzjI4mt
         Nt7DIbv/kh0owBviBa5gugwa9sy5nEveEUEXdW3SWpKLfemhx3WJip9wftSXfOOqYYhu
         L8ZDNrOa0ZaTzprXFZCjcFeKYuhfoZV98ybbfkH/ilFpdcJRLIWtaxYOlwuDsWTcdlCH
         o5Rw==
X-Gm-Message-State: ACrzQf35xpAzsTSPVhdUnFUs6v+LXIqhTzBi02wVAskjzWW+jyf3VaVs
        U5ON9a0GEO/JaNdKNxnuYPUAZGmqkCN42ZZkT02yKGHeMipMnQqJ46R70zFXhM4ob+gBjHOdZhH
        9RvYesDdxgdvwmgmqRqdO2pXuAIY=
X-Received: by 2002:aa7:c60a:0:b0:458:d707:117 with SMTP id h10-20020aa7c60a000000b00458d7070117mr31663809edq.258.1665646471682;
        Thu, 13 Oct 2022 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6001wYozlUpe4wPtbDC4SWgDCYzXeDgzRy/9JBURc7nGVZNoOsA4ODTR3B+y3eh2E2tDfC+g==
X-Received: by 2002:aa7:c60a:0:b0:458:d707:117 with SMTP id h10-20020aa7c60a000000b00458d7070117mr31663799edq.258.1665646471462;
        Thu, 13 Oct 2022 00:34:31 -0700 (PDT)
Received: from [192.168.0.198] (host-79-47-205-133.retail.telecomitalia.it. [79.47.205.133])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm12424355eds.97.2022.10.13.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 00:34:31 -0700 (PDT)
Message-ID: <dad264b1-1d19-4c03-736b-d4444ec8d682@redhat.com>
Date:   Thu, 13 Oct 2022 09:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: SCHED_OTHER > SCHED_FIFO?
To:     Sebastian Kuzminsky <seb@highlab.com>,
        Christophe Blaess <mailist@logilin.fr>
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
 <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
 <adfcede2-0da1-233d-09d7-004688e39178@highlab.com>
 <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
In-Reply-To: <c1ac2662-07b7-36e6-eca5-992ac6e5452e@logilin.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/13/22 08:07, Christophe Blaess wrote:
> `sysctl  kernel.sched_rt_runtime_us=-1`

rt throttling is probably the reason for the poor results. Mainly
because:

"and lots of idle time on the CPU"

The CPU goes idle because of rt throttling.

Anyways, running busy-loop tasks with real-time priority is just
wrong and misleading.

If your goal is to run a single task in a CPU, do cpu isolation.
Ideally, with CPU isolation and a single-user app, *no scheduler is
needed,* and real-time schedulers are not designed for this of
use-case.

In practice (assuming proper cpu isolation), some kernel-related
tasks might be placed in the isolated CPU. Postponing
their execution will put the system in a potentially faulty state.

To make progress one of the two "workarounds" are needed:

  - the user application needs to do periodic sleep to yield
    some CPU.
  - to user needs to use things like stalld to boost the
    starving task for a limited amount of time (like 20 us)
    using SCHED_DEADLINE.

Either way, the results will likely be worse than running the
application as SCHED_OTHER. The reason is that the current
status of cpu isolation is so good that any type of mechanism
to avoid/deal with starvation will likely be more costly
then just letting the kernel do some work in the CPU here and there.

See this paper (it is in ieeexplorer but has open access -
Thanks, Sant'Anna).

 - Operating System Noise in the Linux kernel
   https://ieeexplore.ieee.org/document/9812514

It shows that, with the system tuned, the observed
single latency of FIFO and SCHED other are very similar.

Yes, FIFO shows an improvement of 2 us in the max single
latency, but:
 -  the FIFO is doing some micro sleeps to avoid starvation - and they
    are higher than 10 us.
  - The FIFO is receiving more overall noise. See the peak of noise
    occurrences in lower latency numbers.

So in the end, the SCHED_OTHER is yielding more cpu time (less accumulative
noise), with a similar max single noise.

Thus, yes, for busy loop workload "SCHED_OTHER > SCHED_FIFO," because
SCHED_FIFO was not designed for this scenario. This scenario is a
no scheduler at all goal (even SCHED_IDLE should be > SCHED_FIFO, and
SCHED_FIFO > than SCHED_DEADLINE).

CPU Isolation is at a very good stage, and the correct fix for arbitrary
kernel workload being placed in isolated CPUs is to fix the code, not
"the scheduler."

-- Daniel

