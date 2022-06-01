Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7162EC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Jun 2022 09:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350353AbiFAJUQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jun 2022 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350194AbiFAJUC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jun 2022 05:20:02 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 02:20:00 PDT
Received: from smtp.uni-bielefeld.de (uhrz-exch-pmb02.ad.uni-bielefeld.de [129.70.43.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292F5642F
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Jun 2022 02:20:00 -0700 (PDT)
Received: from [129.70.76.171] (129.70.44.110) by
 uhrz-exch-pmb02.ad.uni-bielefeld.de (129.70.43.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 11:04:56 +0200
Message-ID: <772b9e2b-f780-9eb1-59cb-eecfab7cce35@uni-bielefeld.de>
Date:   Wed, 1 Jun 2022 11:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     <linux-rt-users@vger.kernel.org>
Content-Language: en-US
From:   Florian Paul Schmidt <florian_paul.schmidt@uni-bielefeld.de>
Subject: raspberry pi 4b preempt_rt performance 32 bit vs 64 bit kernels
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: uhrz-exch-pmb10.ad.uni-bielefeld.de (129.70.43.220) To
 uhrz-exch-pmb02.ad.uni-bielefeld.de (129.70.43.212)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hi list,

I spent some time trying to evaluate some different 
raspberrypi-kernel/preempt_rt patch combinations and found some 
"interesting" results which maybe one of you can shed a bit of light on.

I am aware that the raspberrypi-kernel is not really vanilla anymore and 
so it's possible that nothing much can be said about the issue, but I'm 
giving it a shot nonetheless.

As a preamble here's my evaluation routine:

- Set scaling_governor to performance for all cpus
- pin the gpu frequency to either 250 or 500 mhz

I use the 32 bit or 64 bit raspberry os on the rpi 4b to build/run 32 
bit and 64 bit kernels respectively.

The major kernel configuration options (found mostly by trial and error 
besides PREEMPT_RT):

- disable all kernel profiling, latency measurement and debugging options
- disable process accounting
- use a 1000 Hz timer
- use periodic timer instead of dynamic ticks

I then boot the different kernels, run

sudo ./cyclictest -M -p 90 -S --mlockall

and in another terminal trigger a rebuild of a linux kernel with -j4. 
Then I wait for a while and note down the maximum. Here's some results:

32 bit kernels:

4.19.71-rt24:   ca. 130 us
5.10.90-rt61:   ca. 140 us
5.18.0-rc7-rt9  ca. 160 us

It looks like there's rather clear regression going forward with kernel 
versions.

Here's a 64 bit kernel:

5.18.0-rc7-rt9: ca. 230 us

So that's even worse. Before I went on to full 1000Hz with periodic 
timer, disabling all kernel debugging, etc, and pinning the gpu 
frequency I measured some more kernels:

32 bit:

4.19.71-rt24:   ca. 200us
5.10.90-rt61:   ca. 200 us
5.15.40-rt43:   ca. 190 us
5.18.0-rc7-rt9: ca. 170 us

64 bit:

5.15.40-rt43:   ca. 220 us
5.18.0-rc7-rt9: ca. 270 us

So the regression going forward over kernel versions isn't as clear cut 
anymore but one trend is overwhelmingly visible over all these tests:

64 bit kernels have a higher maximum latency when compared to 32 bit 
kernels.

Do you happen to have an idea why that may be? Is there some additional 
tweak required for the 64 bit kernels on that hardware?

Also an additional observation and question:

The high latencies are triggered by kernel compiles. Just running stress 
-c 8 or writing zeros to the SD Card do not trigger them. It seems to be 
specific to that combined work load.

I played with lowering the threaded IRQ priorities for the mmc drivers 
but that had no effect at all, as expected since they run at priority 50 
per default and cyclictest runs at 90. Do you have an idea what might be 
the problem triggered by that particular workload?

Also coming back to the point about the kernel not being really vanilla: 
If I rebuild the kernel with latency measurement intrumentation, etc, 
and get some function traces for high latency code paths would you 
people even consider looking at them? :)

Kind regards,
FPS


-- 
Biologische Kybernetik
Universität Bielefeld
Phone: ++49 521 106 5535
http://www.uni-bielefeld.de/biologie/Kybernetik/index.html
