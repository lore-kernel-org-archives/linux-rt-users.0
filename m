Return-Path: <SRS0=nOM3=2G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA5C43603
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D25206B7
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 15:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLPPey convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:34:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfLPPex (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 10:34:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1igsOX-0003T1-Fw; Mon, 16 Dec 2019 16:34:49 +0100
Date:   Mon, 16 Dec 2019 16:34:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     John Kacur <jkacur@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
Message-ID: <20191216153449.sfxptmlyfthoianp@linutronix.de>
References: <20191208210625.5999-1-ukleinek@debian.org>
 <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
 <alpine.LFD.2.21.1912131550270.7507@planxty>
 <20191213230256.GA20494@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191213230256.GA20494@amt.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-13 21:02:56 [-0200], Marcelo Tosatti wrote:
> > > That freq. script reports here:
> > > |1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1599.096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 1870.318 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 1599.439 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792.809
> > > 
> > > I guess I pick one…
> > > 
> > > Could someone please figure out the actual difference of clock_gettime()
> > > vs rdtsc() so we know how important it is. Based on its current
> > > implementation, if memmove() takes >1sec then it ends up undetected
> > > because only the ns of the timestamp are considered for.
> 
> /* Program parameters:
>  * max_queue_len: maximum latency allowed, in nanoseconds (int).
>  * cycles_per_packet: number of cycles to process one packet (int).
>  * mpps(million-packet-per-sec): million packets per second (float).
>  * tsc_freq_mhz: TSC frequency in MHz, as measured by TSC PIT
>  * calibration 
>  * (search for "Detected XXX MHz processor" in dmesg, and use the
>  * integer part).
>  */
> 
> So you have to pass it "processor frequency" (you can change the names, 
> its TSC but thats x86 specific). The script grabs the processor
> frequency (so you have to adjust that the script to ARM).
> 
> And thats it. Please replace tsc_mhz -> processor_freq.

So the script reports the freq. from 1555.184 Mhz to 2574.546 Mhz.
And I doubt the numbers remain steady on today's x86 even with
gov=performance.
However, I asked for the frequency to be used on !x86 given the code we
have. It was fixed in hurry and you would have to use 1000 so that the
math keeps working.
Then I asked how much benefit of this complicated TSC calculation vs
clock_gettime() has.
I tried to use it myself but after 30secs I saw no output, it just ate
100% and it seemed to do nothing. So I gave up.

Sebastian
