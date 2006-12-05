From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Looking for "Hello world"
Date: Tue, 05 Dec 2006 17:36:07 +0100
Message-ID: <1165336567.24604.165.camel@localhost.localdomain>
References: <45743DAF.6020205@evosoft.com>
	 <200612040813.19018.dvhltc@us.ibm.com> <45758FFD.3030401@evosoft.com>
	 <200612050816.39252.dvhltc@us.ibm.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Vucsics Krisztian <krisztian.vucsics@evosoft.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:43682 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968446AbWLEQdC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 11:33:02 -0500
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <200612050816.39252.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2006-12-05 at 08:16 -0800, Darren Hart wrote:
> On Tuesday 05 December 2006 07:27, Vucsics Krisztian wrote:
> > Hi Darren,
> >
> > > http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/
> >
> > I've downloaded your testcases but some of them cannot be compiled, e.g.
> >  func/prio-preempt:
> > ../../include/librt.h:597: error: `PTHREAD_PRIO_INHERIT' undeclared
> > (first use in this function)
> 
> You will need an updated glibc to get this.  I am not sure what most folks are 
> doing to get this now a days.  Can s omeone chip in here and share with 
> Vucsics how to go about getting the glibc?  If this isn't on the wiki 
> somewhere I can add it once I know what the common practice is.

Install glibc2.5. All major distros have a package for it.

	tglx
