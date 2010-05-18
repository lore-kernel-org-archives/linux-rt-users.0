From: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 18 May 2010 08:17:31 -0700
Message-ID: <1274195851.9142.9.camel@localhost.localdomain>
References: <20100505130845.GA9118@rivendell>  <4BE1BADA.3040902@us.ibm.com>
	 <1273168487.22438.44.camel@gandalf.stny.rr.com>
	 <1274192889.17960.14.camel@localhost.localdomain>
	 <4BF2AC9A.3060301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from isa.tranzeo.com ([64.114.87.10]:2572 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab0ERPRd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 11:17:33 -0400
In-Reply-To: <4BF2AC9A.3060301@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 2010-05-18 at 08:04 -0700, Nivedita Singhvi wrote:
> Darcy L. Watkins wrote:
> 
> >>> Have you tried using the rtctl utility and the /etc/rtgroups file?
> >
> > Where are the source tarball projects for these located so I can try
> > porting/using them [at least some of it] on my embedded linux?  ...
> or
> > is this a proprietary Redhat utility only in RPM binaries?  Google
> > search seems to mainly land me at IBM and Redhat user docs and FAQs.
> 
> rtctl is GPL, not proprietary. A quick google search brought
> up the following:

Excellent!  and thanks!  I see SRPMs for rt-setup, tuna, etc there as
well.  Is this FTP site the usual place to pick up SRPMs for these
utilities as they are updated / released?


Darcy

> 
> http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/
> 
> http://ftp.riken.go.jp/pub/Linux/cern/mrg/slc5X/SRPMS/rtctl-1.7-1.el5rt.src.rpm
> 
> > Perhaps my issue earlier with serial buffer overruns is just a tune
> up
> > issue.
> >
> > I want to tune up RT on PowerPC 405 and ARM11 MX.31 based embedded
> > systems where the rootfs is built (cross compiled) using
> > buildroot/uclibc, etc and not x86 binaries from a full feature
> distro
> > such as Fedora, Debian, etc.
> 
> Setting thread priorities for your environment will certainly
> be a good thing in general.
> 
> thanks,
> Nivedita


