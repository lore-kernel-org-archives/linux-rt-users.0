From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Sun, 25 Jan 2009 10:34:38 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0901251032060.3424@localhost.localdomain>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org>  <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>  <alpine.LFD.2.00.0901241716540.3424@localhost.localdomain> <1232845026.3990.71.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lee Revell <rlrevell@joe-job.com>, linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jon Masters <jcm@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:36980 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbZAYJfE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2009 04:35:04 -0500
In-Reply-To: <1232845026.3990.71.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 24 Jan 2009, Jon Masters wrote:
> > The only reasonable thing you can do on a SMI plagued system is to
> > identify the device which makes use of SMIs. Legacy ISA devices and
> > USB are usually good candidates. If that does not help, don't use it
> > for real-time :)
> 
> Indeed. This is why I wrote an smi_detector that sits in kernel space
> and can be reasonably sure measured discrepancies are attributable to
> SMI behavior. We want to log and detect such things before RT systems
> are deployed, not have users actively trying to work around SMI overhead
> after the fact.

Agreed. A tool to detect SMI disturbance is a good thing. It just
needs to be documented that users should take the results and talk to
their board vendor. I know that off the shelf hardware will not be
fixed, but industrial grade hardware vendors usually have an interest
to get such problems resolved.

Thanks,

	tglx
