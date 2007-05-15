From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Tue, 15 May 2007 13:32:09 +0200
Message-ID: <1179228729.5139.6.camel@godzilla.tecnorama.it>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
	 <200705071907.53028.jbe@pengutronix.de>
	 <1179228394.5704.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Peter Feuerer <peter@piie.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:56625 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936AbXEOLcN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2007 07:32:13 -0400
In-Reply-To: <1179228394.5704.18.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

On Tue, 2007-05-15 at 13:26 +0200, Peter Feuerer wrote:
[...]
> > First of all, running a realtime OS on such a machine is no good idea, as it 
> > is full of system management software that steals you the CPU.
> 
> What do you mean by "system management software"? The only software
> running on my gx1 hardware is my linux system with kernel 2.6.18 using
> rt preempt patch and compiled for x86.

This type of software is implemented into BIOS.

[...]
> I tried this for rt-preempt patched kernels > 2.6.18 (where acpi is
> needed for the highres timer) but still no hard realtime capability.

I'm trying 2.6.21-rt1 and it _seems_ works (not tested yet).

Ciao,
Alessio
