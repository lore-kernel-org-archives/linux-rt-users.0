From: Tim Sander <tim@krieglstein.org>
Subject: Re: cyclictest better values with system load than without (OMAP3530 target)
Date: Tue, 26 Nov 2013 21:14:57 +0100
Message-ID: <8887146.tJjGCfdtav@hydra>
References: <5294681E.10406@gmail.com> <CAMjaK3Ay7yeDN_kbJ+oQFnD0GCwy-67zP9SrvazofCqbwUCWtw@mail.gmail.com> <5294F31E.7090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:38868
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754304Ab3KZUNz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Nov 2013 15:13:55 -0500
In-Reply-To: <5294F31E.7090000@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Stefan
> On 26.11.2013 15:21, Dmitry Lysenko wrote:
> > On Marvell Kirkwood at 1.2Ghz and 3.2.51-rt72 kernel I have slightly
> > better results:
> > 
> > --- with hackbench:
> > 
> > root@debian:~/rt-tests# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> > T: 0 (10268) P:80 I:1000 C:  10000 Min:     16 Act:   29 Avg:   29 Max:   
> >   46
> > 
> > --- w/o hackbench:
> > 
> > root@debian:~/rt-tests# ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> > T: 0 (12686) P:80 I:1000 C:  10000 Min:      5 Act:    6 Avg:    6 Max:   
> >   22
> > 
> > -- .config:
> > CONFIG_TICK_ONESHOT=y
> > # CONFIG_NO_HZ is not set
> > CONFIG_HIGH_RES_TIMERS=y
> > 
> > # CONFIG_CPU_IDLE is not set
> > 
> > Try to play with:
> > 
> > # CONFIG_PM_RUNTIME is not set
> > # CONFIG_ARM_CPU_SUSPEND is not set
> 
> Thanks, this was helpful. After some tweaks I was able to disable
> CONFIG_PM_RUNTIME and ARM_CPU_SUSPEND. And after disabling NO_HZ and
> less CONFIG_DEBUG_xxx options I now have the following results:
> 
> Idle:
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1382) P:80 I:1000 C:  10000 Min:     12 Act:  141 Avg:  127 Max:    
> 202
> 
> Load:
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2777) P:80 I:1000 C:  10000 Min:     26 Act:  167 Avg:  152 Max:    
> 229
> 
> So the test now finally has better results on a idle system than on
> one with heavy system load. The numbers are still far away from your
> latency values on the 1.2GHz Kirkwood. Does anybody have OMAP3
> values at hand to compare?
I have not used OMAP3 but Sitara a while ago. But as far as i know they are 
derived from the same die-mask. I think the numbers where a little better than 
yours but it was still in the 100 range which was to large for my use-case 
:-(. I haven't seen an cortex a8 with good realtime performance. The A9 seems 
much better in this regard from my experience. If you need better numbers ping 
me again. Probably i will find the results again on the other machine currently 
out of reach.

One thing that really bothers is that ARM repurposed the FIC with some 
security features which are not that useful for realtime and i think most of 
the time Digital Restrictions Management does more harm than good. But thats
a little offtopic for this mailing list.

Best regards
Tim
