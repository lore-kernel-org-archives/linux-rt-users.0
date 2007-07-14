From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to 2.6.22 available
Date: Sat, 14 Jul 2007 10:27:01 +1000
Message-ID: <46981855.8040904@bigpond.net.au>
References: <4695E5BB0200005A0002763E@mcclure.wal.novell.com> <20070712130958.GB17494@elte.hu> <46971ADC.3030700@bigpond.net.au> <200707130443.11356.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Gregory Haskins <ghaskins@novell.com>,
	jim.houston@ccur.com, joe.korty@ccur.com, rostedt@goodmis.org,
	tglx@linutronix.de, dwalker@mvista.com,
	David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qsrv03sl.mx.bigpond.com ([144.140.92.183]:45703 "EHLO
	qsrv03sl.mx.bigpond.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049AbXGNBw6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 21:52:58 -0400
In-Reply-To: <200707130443.11356.gene.heskett@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Gene Heskett wrote:
> On Friday 13 July 2007, Peter Williams wrote:
>> Ingo Molnar wrote:
>>> * Gregory Haskins <ghaskins@novell.com> wrote:
>>>> On Thu, 2007-07-12 at 14:07 +0200, Ingo Molnar wrote:
>>>>> * Gregory Haskins <ghaskins@novell.com> wrote:
>>>>>> Hi Ingo, Thomas, and the greater linux-rt community,
>>>>>>
>>>>>> 	I just wanted to let you guys know that our team has a port of
>>>>>> the 21.5-rt20 patch for the 2.6.22 kernel available. [...]
>>>>> great! We had the upstream -rt port to .22 in the works too, it was just
>>>>> held up by the hpet breakage - which Thomas managed to fix earlier
>>>>> today. I've released the 2.6.22.1-rt1 patch to the usual place:
>>>>>
>>>>>     http://redhat.com/~mingo/realtime-preempt/
>>>> Thats awesome, Ingo!  Thanks!  Could you publish a broken out version
>>>> as well?  We found it extremely valuable to be able to bisect this
>>>> beast while working on the 21-22 port.
>>> we are working on something in this area :) Stay tuned ...
>> I've just been reviewing these patches and have spotted an error in the
>> file mm/slob.c at lines 500-501 whereby a non existent variable "c" is
>> referenced.  The attached patch is a proposed fix to the problem.
> 
> Could this explain why 2.6.22.1-rt1 seems to use a lot of swap?  I've been as 
> high as 570 megs into swap, currently at 286megs after doing a 
> swapoff --a;swapon -a about 8 hours ago.

No.  This problem would have caused the build to fail if slob was
configured.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
