From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.0-rt6 : BUG at kernel/trmutex.c:724!
Date: Thu, 04 Aug 2011 18:37:09 +0200
Message-ID: <1312475829.16729.45.camel@twins>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
	 <201108041834.20575.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43105 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1HDQht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2011 12:37:49 -0400
In-Reply-To: <201108041834.20575.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-08-04 at 18:34 +0200, Tim Sander wrote:
> I was really happy to find 6 preempt rt releases for the 3.0 kernel after holliday :-).
> 
> So i went for a testdrive and found an error: The error occurs in a non released non 
> mainline kernel and is available from me upon request. It has been working on 
> (2.6.39,3.0) but is not working on 3.0-rt6. It fails in an interrupt which calls: 
> 
> wake_up_interruptible(&hbm_device.wait);
> 
> The waitque has been initialized with:
> init_waitqueue_head(&hbm_device.wait);
> before interrupts where enabled. So i don't think its a race. 

looks like it tries to use waitqueues from hardirq context, that's a
no-no for -rt. That interrupt should be a threaded interrupt.
