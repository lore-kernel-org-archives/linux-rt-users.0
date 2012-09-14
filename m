From: Carol Wong <carolw@netacquire.com>
Subject: RE: Pthread Condition Variables and Priority Inversion
Date: Fri, 14 Sep 2012 02:16:27 +0000
Message-ID: <740C4A5BFE01244180687FD9526EB33C0148257965@MBX19.EXCHPROD.USA.NET>
References: <5047DD91.3030402@linux.intel.com>
 <5047E749.3040507@am.sony.com> <5047E9FF.2070803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhart@linux.intel.com>,
	"frank.rowand@am.sony.com" <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateout02.mbox.net ([165.212.64.22]:50104 "EHLO
	gateout02.mbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508Ab2INCZn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Sep 2012 22:25:43 -0400
In-Reply-To: <5047E9FF.2070803@linux.intel.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

<snip>

> >
> > That reminds me...  someone at Plumbers (I'm pretty sure it was
> Thomas)
> > told me that the glibc maintainers have become much more responsive,
> > so maybe I should encourage you to try once again, when you find some
> > spare time :-), submitting to glibc.
> 
> I think Jan and I both intend to do this, but until such time as we can,
> I'd like the docs to reflect reality.
> 
> --
> Darren Hart
> Intel Open Source Technology Center
> Yocto Project - Technical Lead - Linux Kernel

We've run up against this condvar limitation on the system (glibc 2.15 on Linux with RT patch) we've been developing.

How can we help nudge the glibc maintainers? Is there some issue/fix voting system?

Cheers,
Carol
NetAcquire Corporation
