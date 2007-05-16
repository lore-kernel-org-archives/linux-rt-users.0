From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Wed, 16 May 2007 12:02:41 +0200
Message-ID: <1179309761.7610.16.camel@godzilla.tecnorama.it>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
	 <1179228729.5139.6.camel@godzilla.tecnorama.it>
	 <1179229315.5704.25.camel@localhost.localdomain>
	 <200705152008.54949.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Feuerer <peter@piie.net>, linux-rt-users@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:60828 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbXEPKCt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 06:02:49 -0400
In-Reply-To: <200705152008.54949.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Tue, 2007-05-15 at 20:08 +0200, Juergen Beisert wrote:
[...] 
> > > I'm trying 2.6.21-rt1 and it _seems_ works (not tested yet).
> > 
> > The kernel itself was booting up, and running fine, but cyclictest and
> > my little square wave example
> > (http://rt.wiki.kernel.org/index.php/Squarewave-example) were not able
> > to achieve stable timings.
> 
> Once again. On this piece of hardware there is no other useful timer as the 
> PIT.

Cyclictest tell me this:

"WARNING: High resolution timers not available"

also if i add "clocksource=pit" in the kernel command line!  :-(

Ciao,
Alessio
