From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Wed, 07 Jul 2010 19:45:29 +0200
Message-ID: <1278524729.7501.12.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <4C348B1D.5060008@linux.vnet.ibm.com>
	 <1278513073.10564.12.camel@marge.simson.net>  <4C3497A0.8030807@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753534Ab0GGRp2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 13:45:28 -0400
In-Reply-To: <4C3497A0.8030807@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-07-07 at 08:05 -0700, Darren Hart wrote:
> On 07/07/2010 07:31 AM, Mike Galbraith wrote:

> > Yup, all better.
> 
> So with this, the "volatile struct" patch isn't necessary?

Definitely no longer necessary.. on my box ;-)

	-Mike

