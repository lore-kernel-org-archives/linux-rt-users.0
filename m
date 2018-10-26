Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from web2.default.djames.uk0.bigv.io ([213.138.101.246]:43276 "EHLO
        web2.default.djames.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbeJ0DEv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Oct 2018 23:04:51 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179])
        by web2.default.djames.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <chris@64studio.com>)
        id 1gG6J3-0000WZ-Uy
        for linux-rt-users@vger.kernel.org; Fri, 26 Oct 2018 18:53:58 +0100
Received: by mail-lj1-f179.google.com with SMTP id c4-v6so1939005lja.4
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Oct 2018 10:53:57 -0700 (PDT)
MIME-Version: 1.0
From: Christopher Obbard <chris@64studio.com>
Date: Fri, 26 Oct 2018 18:53:45 +0100
Message-ID: <CAP03XeopC7CYd9BxNpKe63q+FqW+Vs2iQ93r1a0gxHRZ5zfVQg@mail.gmail.com>
Subject: RT Summit 2018 & some advice on my application running ARM big.LITTLE
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi Everyone,

First can I thank you all for a very interesting day yesterday in Edinburgh!
Unfortunately I didn't get to stay much after 16.00 as we had to catch
a plane. It was very good to meet other RT users & listen to some
developers having in-depth conversation :-).


I am a user of the RT patchset in some fairly demanding multimedia
situations with a typical multichannel (8+) audio pipeline:  DAC ->
buffer -> app -> buffer -> ADC
The buffering is handled by JACKD2 the app having the same RT
priority+scheduler as this.

Most work I am doing is on arm(+64) platform but some x86+amd64 too
and we find running RT patchset really improves audio latency.

One of the questions which came up yesterday was the scheduler and
something I have not yet thought much around:
We are just setting the audio DMA interrupt (edma_ccint) to a priority
of around 95 with SCHED_FIFO, the jack server to 90 with also
SCHED_FIFO.
Now this seems to work quite well on the single core 1 GHz Beaglebone system.
My first question: is there anything I am doing glaringly wrong here?

So now I am working on a project that needs much more performance so
naturally I want to throwing multiple cores at it.
I have found the Rockchip RK3399 which has two cores CortexA72 & four
cores CortexA53 in a big.LITTLE style arrangement.

The story yesterday seemed that SMT is very bad and should be disabled
with RT & ARM does not have this function so I am okay.
The other topic mentioned was cache lines being shared between
multiple cores causing a hard to reproduce outlier & from what I have
read bigLITTLE shares cache lines between both processor types. So I
think I am going to have to disable the HMP and use the 4 fast cores?

Can you at all offer some quick advice to see if I am on the right track?



Cheers!

Christopher Obbard
64 Studio Ltd.
