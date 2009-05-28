From: Tim Shepard <shep@alum.mit.edu>
Subject: normal processes stuck on particular cores?  ( in 2.6.29.4-rt16 )
Date: Thu, 28 May 2009 13:13:33 -0400
Message-ID: <E1M9jAb-0003Tg-00@alva.home>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dsl092-066-146.bos1.dsl.speakeasy.net ([66.92.66.146]:54614
	"EHLO alva.home" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752254AbZE1RiA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2009 13:38:00 -0400
Received: from shep (helo=alva.home)
	by alva.home with local-esmtp (Exim 3.36 #1 (Debian))
	id 1M9jAb-0003Tg-00
	for <linux-rt-users@vger.kernel.org>; Thu, 28 May 2009 13:13:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



I'm running 2.6.29.4-rt16 with CONFIG_PREEMPT_RT=y on an Intel
Core 2 Quad Q9650 and I have recently noticed something odd.
(I've also seen this on 2.6.29.2-rt11, and I have not tried any
other -rt versions so I don't know how new this is in the series
of -rt kernel versions.)


On an idle machine, I open four new xterms, and then in each xterm
I type:

	while : ; do : ; done


I'm watching what happens in another window that is running htop.

Sometimes (though not often) I'll see all four CPUs go to 100%, and
four shell processes listed as running at 100%.

More often, one or more CPUs remain essentially idle, and from the
CPU% displayed in htop I'll see that some of my looping bash
processes appear to be sharing a CPU, each getting around half or a
third of the CPU%.

In a few tests I've never seen all four on the same core with three
idle CPUs, but I usually see one or two idle CPUs with the CPU% of
my looping bashes revealing which have a CPU to themselves and
which are sharing.

It is as if the processes somehow get arbitrarily assigned to a
core and never get moved even though there's contention for the
core they are stuck on and one or two other idle cores.

If I ^C the loops and restart them, the pattern seems to be the
same.  But if I exit the xterms and start up four new xterms, I'll
get some new pattern, which is repeatable as many times as I like
with those particular xterm/bash combinations.


(I do disable CPU speed switching by running 

  for i in 0 1 2 3 ; do sudo cpufreq-set -f 3g -c $i ; done

 shortly after booting, but I have no reason to think that is relevant.)


Does anyone else see this same weirdness?

Is this an actual bug in -rt or am I wrong to expect the -rt
kernel to migrate processes if some processors are busy and
others idle?

(I know I could try distributing processes on cores manually
 using taskset, but it surprises me I should have to do this to
 get all CPUs working.)


(I don't see this on kernels without the -rt patch.)

			-Tim Shepard
			 shep@alum.mit.edu
