From: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 18 May 2010 07:28:09 -0700
Message-ID: <1274192889.17960.14.camel@localhost.localdomain>
References: <20100505130845.GA9118@rivendell>  <4BE1BADA.3040902@us.ibm.com>
	 <1273168487.22438.44.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.tranzeo.com ([64.114.87.10]:2931 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab0EROnV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 10:43:21 -0400
In-Reply-To: <1273168487.22438.44.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 2010-05-06 at 10:54 -0700, Steven Rostedt wrote:
> On Wed, 2010-05-05 at 11:37 -0700, Nivedita Singhvi wrote:
> > Raphael Hertzog wrote:
> >
> > > In case it was not clear, I want to run the IRQ handler of the
> serial
> > > ports at a higher priority than the other ones (like network,
> disk,
> > > etc.) to avoid buffer overruns.
> >
> > Have you tried using the rtctl utility and the /etc/rtgroups file?

Where are the source tarball projects for these located so I can try
porting/using them [at least some of it] on my embedded linux?  ... or
is this a proprietary Redhat utility only in RPM binaries?  Google
search seems to mainly land me at IBM and Redhat user docs and FAQs.

Perhaps my issue earlier with serial buffer overruns is just a tune up
issue.

I want to tune up RT on PowerPC 405 and ARM11 MX.31 based embedded
systems where the rootfs is built (cross compiled) using
buildroot/uclibc, etc and not x86 binaries from a full feature distro
such as Fedora, Debian, etc.


Darcy

> 
> Also try out tuna. If you have fedora:
> 
>  yum install tuna
> 
> -- Steve


