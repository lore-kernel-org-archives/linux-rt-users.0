From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Forward port of latest RT patch (2.6.21.5-rt20) to
 =?utf-8?q?2=2E6=2E22=09available?=
Date: Fri, 13 Jul 2007 04:43:08 -0400
Message-ID: <200707130443.11356.gene.heskett@gmail.com>
References: <4695E5BB0200005A0002763E@mcclure.wal.novell.com>
 <20070712130958.GB17494@elte.hu> <46971ADC.3030700@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Gregory Haskins <ghaskins@novell.com>,
	jim.houston@ccur.com, joe.korty@ccur.com, rostedt@goodmis.org,
	tglx@linutronix.de, dwalker@mvista.com,
	David Bahi <DBahi@novell.com>,
	Moiz Kohari <MKohari@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	williams@redhat.com, abogani@texware.it,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Peter Williams <pwil3058@bigpond.net.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vms040pub.verizon.net ([206.46.252.40]:53765 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077AbXGMInU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 04:43:20 -0400
In-reply-to: <46971ADC.3030700@bigpond.net.au>
Content-disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday 13 July 2007, Peter Williams wrote:
>Ingo Molnar wrote:
>> * Gregory Haskins <ghaskins@novell.com> wrote:
>>> On Thu, 2007-07-12 at 14:07 +0200, Ingo Molnar wrote:
>>>> * Gregory Haskins <ghaskins@novell.com> wrote:
>>>>> Hi Ingo, Thomas, and the greater linux-rt community,
>>>>>
>>>>> 	I just wanted to let you guys know that our team has a port of
>>>>> the 21.5-rt20 patch for the 2.6.22 kernel available. [...]
>>>>
>>>> great! We had the upstream -rt port to .22 in the works too, it was just
>>>> held up by the hpet breakage - which Thomas managed to fix earlier
>>>> today. I've released the 2.6.22.1-rt1 patch to the usual place:
>>>>
>>>>     http://redhat.com/~mingo/realtime-preempt/
>>>
>>> Thats awesome, Ingo!  Thanks!  Could you publish a broken out version
>>> as well?  We found it extremely valuable to be able to bisect this
>>> beast while working on the 21-22 port.
>>
>> we are working on something in this area :) Stay tuned ...
>
>I've just been reviewing these patches and have spotted an error in the
>file mm/slob.c at lines 500-501 whereby a non existent variable "c" is
>referenced.  The attached patch is a proposed fix to the problem.

Could this explain why 2.6.22.1-rt1 seems to use a lot of swap?  I've been as 
high as 570 megs into swap, currently at 286megs after doing a 
swapoff --a;swapon -a about 8 hours ago.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Humorists always sit at the children's table.
		-- Woody Allen
