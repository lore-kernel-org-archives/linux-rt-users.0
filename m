From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU splat on boot from an idle CPU
Date: Thu, 3 Sep 2015 14:39:40 -0700
Message-ID: <20150903213940.GN4029@linux.vnet.ibm.com>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
 <alpine.DEB.2.11.1509011721510.15006@nanos>
 <20150902153823.749a9f73@gandalf.local.home>
 <CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
 <20150902230729.GZ4029@linux.vnet.ibm.com>
 <20150903125345.6343e76b@gandalf.local.home>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philipp Schrader <philipp@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:42432 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbbICVjp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2015 17:39:45 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 3 Sep 2015 15:39:44 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D17753E4003B
	for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2015 15:39:42 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t83LdgYo40697942
	for <linux-rt-users@vger.kernel.org>; Thu, 3 Sep 2015 14:39:42 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t83Ldfxg028583
	for <linux-rt-users@vger.kernel.org>; Thu, 3 Sep 2015 15:39:42 -0600
Content-Disposition: inline
In-Reply-To: <20150903125345.6343e76b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Sep 03, 2015 at 12:53:45PM -0400, Steven Rostedt wrote:
> On Wed, 2 Sep 2015 16:07:29 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> 
> > > Does that look reasonable?
> > > Or could this cause a problem down the road?
> > 
> > Looks good to me!
> 
> If it looks good to Paul, it looks good to me :-)
> 
> > 
> > > Still reading up on RCUs and how they work.
> > 
> > Me too.  ;-)
> 
> Who are you reading up on RCUs from?

Splats, oopses, and hangs when I try modifying it.  And bug reports
from people using it.  ;-)

							Thanx, Paul

