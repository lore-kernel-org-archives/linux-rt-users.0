From: Peter Feuerer <peter@piie.net>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Tue, 15 May 2007 13:26:34 +0200
Message-ID: <1179228394.5704.18.camel@localhost.localdomain>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
	 <200705071907.53028.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alessio Igor Bogani <abogani@texware.it>,
	linux-rt-users@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay07.ispgateway.de ([80.67.29.7]:48533 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbXEOL0i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2007 07:26:38 -0400
In-Reply-To: <200705071907.53028.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Juergen,

On Mon, 2007-05-07 at 19:07 +0200, Juergen Beisert wrote:
> On Monday 07 May 2007 17:20, Alessio Igor Bogani wrote:
> > I have this same problem
> > (http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00333.html).
> >
> > Someone can give me some suggestions?
> 
> First of all, running a realtime OS on such a machine is no good idea, as it 
> is full of system management software that steals you the CPU.

What do you mean by "system management software"? The only software
running on my gx1 hardware is my linux system with kernel 2.6.18 using
rt preempt patch and compiled for x86.

> Try to run your kernel with "clocksource=pit" as this hardware has no usefull 
> other timer with interrupt capability.

I tried this for rt-preempt patched kernels > 2.6.18 (where acpi is
needed for the highres timer) but still no hard realtime capability.

--peter
