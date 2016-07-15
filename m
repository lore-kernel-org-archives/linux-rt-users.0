From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.6.4-rt8
Date: Fri, 15 Jul 2016 17:31:22 +0200
Message-ID: <20160715153122.GC16938@linutronix.de>
References: <20160715114803.GA11606@linutronix.de>
 <20160715112244.4ff6ecab@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47401 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbcGOPba (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 11:31:30 -0400
Content-Disposition: inline
In-Reply-To: <20160715112244.4ff6ecab@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2016-07-15 11:22:44 [-0400]:

>> Changes since v4.6.4-rt8:
>> 
>>   - Import Thomas' timer rework known as "timer: Refactor the timer
>>     wheel" patch set which made its way into the -TIP tree. With this
>>     changes we get NOHZ_FULL working. Finally.
>
>Does this mean that there's no more 1 second tick?

>From tracing there a timer wakeup each second but before we had a wakeup
each jiffy because we could not lookup the next timer without taking the
base lock which we can do now.
However if there is room for improvement to have a wakeup every two or
five seconds I am all for it because from RT point of view we should be
able to do the same things as the non-RT version.

Sebastian
