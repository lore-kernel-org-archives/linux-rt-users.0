From: Peter Feuerer <peter@piie.net>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Tue, 15 May 2007 13:41:55 +0200
Message-ID: <1179229315.5704.25.camel@localhost.localdomain>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
	 <200705071907.53028.jbe@pengutronix.de>
	 <1179228394.5704.18.camel@localhost.localdomain>
	 <1179228729.5139.6.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:52797 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396AbXEOLl7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2007 07:41:59 -0400
In-Reply-To: <1179228729.5139.6.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Alessio,

On Tue, 2007-05-15 at 13:32 +0200, Alessio Igor Bogani wrote:
> Hi Peter,
> 
> On Tue, 2007-05-15 at 13:26 +0200, Peter Feuerer wrote:
> [...]
> > > First of all, running a realtime OS on such a machine is no good idea, as it 
> > > is full of system management software that steals you the CPU.
> > 
> > What do you mean by "system management software"? The only software
> > running on my gx1 hardware is my linux system with kernel 2.6.18 using
> > rt preempt patch and compiled for x86.
> 
> This type of software is implemented into BIOS.

I see. Thanks for this information, that's realy annoying!

> [...]
> > I tried this for rt-preempt patched kernels > 2.6.18 (where acpi is
> > needed for the highres timer) but still no hard realtime capability.
> 
> I'm trying 2.6.21-rt1 and it _seems_ works (not tested yet).

The kernel itself was booting up, and running fine, but cyclictest and
my little square wave example
(http://rt.wiki.kernel.org/index.php/Squarewave-example) were not able
to achieve stable timings.

--peter
