From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Thu, 08 Jul 2010 14:05:30 +0200
Message-ID: <1278590730.10399.3.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C348940.9070805@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754753Ab0GHMF0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Jul 2010 08:05:26 -0400
In-Reply-To: <4C348940.9070805@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-07-07 at 07:03 -0700, Darren Hart wrote:

> I see kernel version is: 2.6.33.6-rt23, have you reproduced this on 
> earlier kernel versions as well? Any 2.6.31 rt kernel would be a good 
> data point.

FUTEX_CMP/WAIT_REQUEUE_PI first appeared in 2.6.29-rt, as does the
explosion.

	-Mike



