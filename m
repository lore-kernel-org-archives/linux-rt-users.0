From: Mike Galbraith <efault@gmx.de>
Subject: Re: timerfd functions hang on both x86 and ARM with RT patch and
 RT scheduling policies
Date: Thu, 26 Jan 2012 03:01:55 +0100
Message-ID: <1327543315.6343.35.camel@marge.simson.net>
References: <CAFQPvXdTb-=oo8OC6MAa++X6u4ZoWM2XXmKog-WK6DPookJyvg@mail.gmail.com>
	 <CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com>
	 <1327478618.6973.2.camel@marge.simson.net>
	 <alpine.LFD.2.02.1201251110190.2716@ionos>
	 <CAFQPvXcGJ4oad3domH48NT3i=PhCwG7W4Zn=7NWmARhQoonRMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:44622 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751328Ab2AZCB7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 21:01:59 -0500
In-Reply-To: <CAFQPvXcGJ4oad3domH48NT3i=PhCwG7W4Zn=7NWmARhQoonRMA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-25 at 18:22 -0600, Sankara Muthukrishnan wrote:

> I wonder why my test worked for priority 1 alone before (without this
> fix) and I did not see any other threads using RT scheduler in the
> system with priority 1 or 2.

It worked at priority 1 because ksoftirqd was also at priority 1.  The
user task can't preempt ksoftirqd, ksoftirqd does it's thing and rides
off into the sunset before the user task arrives at the bad idea spot.

	-Mike

