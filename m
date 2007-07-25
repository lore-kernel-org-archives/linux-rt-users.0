From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 17:00:20 +0200
Message-ID: <1185375620.29693.1.camel@godzilla.tecnorama.it>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
	 <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu>
	 <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr>
	 <20070725130536.GA12334@elte.hu> <46A74E05.50504@free.fr>
	 <20070725133835.GA17616@elte.hu>  <46A758B5.9070602@free.fr>
	 <1185372808.23485.2.camel@godzilla.tecnorama.it> <46A75F97.8000103@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:42930 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760555AbXGYPAY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 11:00:24 -0400
In-Reply-To: <46A75F97.8000103@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi John,

On Wed, 2007-07-25 at 16:35 +0200, John Sigler wrote:
> >> # cat /proc/interrupts
> >>             CPU0
> >>    0:         37    XT-PIC-XT        timer
> > 
> > Just curious: Can you post the output of the "cat /proc/timer_list" ?
> 
> Kernel command line: [...] lpj=12667000 lapic nmi_watchdog=0 idle=halt
> 
> Kernel configuration:
> http://linux.kernel.free.fr/latency/config-2.6.20.7-rt8-adlink-latency

Do you have a regular distro or custom system on this machine?

Ciao,
Alessio
