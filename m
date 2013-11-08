From: Mike Galbraith <bitbucket@online.de>
Subject: Re: CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo
Date: Fri, 08 Nov 2013 14:26:28 +0100
Message-ID: <1383917188.4964.94.camel@marge.simpson.net>
References: <1383228427.5272.36.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1311061842160.23353@ionos.tec.linutronix.de>
	 <1383794799.5441.16.camel@marge.simpson.net>
	 <1383798668.5441.25.camel@marge.simpson.net>
	 <20131108032343.GA18245@linux.vnet.ibm.com>
	 <1383895880.4964.91.camel@marge.simpson.net>
	 <20131108123713.GC18245@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61449 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3KHN0e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 08:26:34 -0500
In-Reply-To: <20131108123713.GC18245@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-11-08 at 04:37 -0800, Paul E. McKenney wrote: 
> On Fri, Nov 08, 2013 at 08:31:20AM +0100, Mike Galbraith wrote:
> > On Thu, 2013-11-07 at 19:23 -0800, Paul E. McKenney wrote:
> > 
> > > An untested patch that gets rid of the RCU_SOFTIRQs in this case is below.
> > 
> > Yup, toasted.
> 
> You lost me on this one.  If my patch broke your system, any chance of
> any diagnostic information?

No no, the RCU_SOFTIRQs are toast, history, gone.

-Mike

