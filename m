From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: All 3.10.x rt patched kernels are unusable on my machine
Date: Sat, 26 Oct 2013 00:26:24 +0200
Message-ID: <526AF010.9080002@linutronix.de>
References: <1381746965.3978.27.camel@archlinux>  <20131025174537.GA21841@linutronix.de> <1382727082.656.24.camel@archlinux>  <20131025201428.GC21841@linutronix.de> <1382732735.656.56.camel@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42698 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3JYW01 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 18:26:27 -0400
In-Reply-To: <1382732735.656.56.camel@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/25/2013 10:25 PM, Ralf Mardorf wrote:
> Hi Sebastian,

Hi Ralf,

> On Fri, 2013-10-25 at 22:14 +0200, Sebastian Andrzej Siewior wrote:
>> Your hardware configuration does look that unusual.
> 
> What exactly is unusual? I suspect the amount of sound devices is

I'm sorry. There was an missing "not".

> unusual for non-audio production environments, but it shouldn't be
> unusual for an audio workstation. One sound card for audio, the RME. Two
> Envy24 PCI cards to get jitter free MIDI and two USB devices as MIDI
> remote controls. The onboard audio crap is disabled.
> 
> FWIW I've got a NVIDI graphics too, if needed I switch between the ATI
> and the NVIDI graphics, but I only do this as a last resort from time to
> time.

If it is really 3.10 RT does not work, taking the same .config and
switch from "PREEMPT RT" down to "SERVER" or so does work then I
suggest to start slowly. That means boot without X see how that goes,
try to get mplayer or whatever to make a little noise on each soundcard
to figure out when does the system explode.
Enabling debugging under kernel hacking might give you hint in the
kernel output (which goes either to syslog or can be read with dmesg)
but it will be hard to capture especially if your system becomes not
responsible.

> Regards,
> Ralf

Sebastian
