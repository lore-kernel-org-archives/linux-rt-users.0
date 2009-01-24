From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] [RFC] simple SMI detector
Date: Sat, 24 Jan 2009 17:30:30 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0901241716540.3424@localhost.localdomain>
References: <1232751312.3990.59.camel@perihelion.bos.jonmasters.org> <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Masters <jcm@redhat.com>, linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:57127 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbZAXQan (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Jan 2009 11:30:43 -0500
In-Reply-To: <75b66ecd0901231833j2fda4554sb0f47457ab838566@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 23 Jan 2009, Lee Revell wrote:
> 
> FYI the RTAI project has a patch to allow disabling of SMI:
> 
> https://listas.upv.es/pipermail/rtlinuxgpl/2007-April/000609.html

FYI, this patch should be removed from the internet archives and the
author should be made liable for the damage which can happen when
innocent users try to use it for fixing things which simply can not be
fixed.

>> .... disabled SMIs with RTAI code the latencies of cyclictest were
>> good, but after about 20 minutes my system stopped working and now
>> it does not even boot anymore. :( Any hint?
>
> Yeah. Buy a new CPU. You deep-fried your P4 because you disabled the
> thermal protection.

Aside of this worst case scenario, disabling SMIs is problematic as
SMI is used to emulate devices, to fix chip bugs and necessary for
enhanced features.

The only reasonable thing you can do on a SMI plagued system is to
identify the device which makes use of SMIs. Legacy ISA devices and
USB are usually good candidates. If that does not help, don't use it
for real-time :)

Thanks,

	tglx
