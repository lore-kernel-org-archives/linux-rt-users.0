From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT support for LTS kernel 2.6.32 ?
Date: Fri, 23 Jul 2010 12:37:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007231232310.2616@localhost.localdomain>
References: <AANLkTin0pSTAkyytSokSQLXainZJBVdELOVxYn6OkViw@mail.gmail.com> <1279838130.19144.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andres Cimmarusti <acimmarusti@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Ng Oon-Ee <ngoonee@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38004 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab0GWKho (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Jul 2010 06:37:44 -0400
In-Reply-To: <1279838130.19144.4.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 23 Jul 2010, Ng Oon-Ee wrote:

> On Thu, 2010-07-22 at 15:51 -0400, Andres Cimmarusti wrote:
> > Hi,
> > 
> > I saw in the kernel archives that the only recent kernels supported by
> > the patch are 2.6.33.x. I was wondering if there will be any support
> > for the 2.6.32.x kernels which will be long term supported and
> > prominent distros like Ubuntu LTS 10.04 and Debian Squeeze 6.0 are
> > based on them.
> > 
> > Thanks
> > 
> > Andres
> 
> I think the decision was taken to only support odd-numbered kernels. For
> example the current 2.6.34 will not have a release either.

The decision to provide RT for a given mainline version is based on
bandwidth constraints of the developers, testing capacities and the
required stabilization period. There are other factors as well,
e.g. we skipped 32 simply because we were able to merge quite a chunk
of RT code into 33, which made life easier. So there is no rule which
mainline version we pick, but I can confirm that 34 will not have a RT
release.

Thanks,

	tglx
