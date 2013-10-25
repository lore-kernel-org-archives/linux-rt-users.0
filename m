From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: All 3.10.x rt patched kernels are unusable on my machine
Date: Fri, 25 Oct 2013 22:25:35 +0200
Message-ID: <1382732735.656.56.camel@archlinux>
References: <1381746965.3978.27.camel@archlinux>
	 <20131025174537.GA21841@linutronix.de> <1382727082.656.24.camel@archlinux>
	 <20131025201428.GC21841@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail223c50.megamailservers.eu ([91.136.10.233]:60346 "EHLO
	mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754807Ab3JYUZr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 16:25:47 -0400
In-Reply-To: <20131025201428.GC21841@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On Fri, 2013-10-25 at 22:14 +0200, Sebastian Andrzej Siewior wrote:
> Your hardware configuration does look that unusual.

What exactly is unusual? I suspect the amount of sound devices is
unusual for non-audio production environments, but it shouldn't be
unusual for an audio workstation. One sound card for audio, the RME. Two
Envy24 PCI cards to get jitter free MIDI and two USB devices as MIDI
remote controls. The onboard audio crap is disabled.

FWIW I've got a NVIDI graphics too, if needed I switch between the ATI
and the NVIDI graphics, but I only do this as a last resort from time to
time.

Regards,
Ralf


