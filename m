From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Disable lapic timer
Date: Wed, 25 Jan 2017 18:12:33 +0100
Message-ID: <20170125171233.i6lc5ttshd2nftxj@linutronix.de>
References: <CACKey4zCv-B1EkcmzzAGpUMC5CyjyAfOEgfSmNS0Z=8cNe8R6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Federico Reghenzani <federico.reghenzani@polimi.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdAYRMg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 12:12:36 -0500
Content-Disposition: inline
In-Reply-To: <CACKey4zCv-B1EkcmzzAGpUMC5CyjyAfOEgfSmNS0Z=8cNe8R6A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-12-22 14:36:03 [+0100], Federico Reghenzani wrote:
> I found this very old topic
> 
> https://www.spinics.net/lists/linux-rt-users/msg05422.html
> 
> is there any update on this? I want to disable the APIC timer in order
> to increase the determinism of my system, but I'm not sure if this is
> possible without editing the kernel source code.
> 
> On my machine smp_apic_timer_interrupt takes 2-3 us, I know this is
> already low, but it's actually the only "frequent" latency that I have
> on the isolated cpu.

You need a timer for each active CPU that participates in the system.
The timer interrupt which comes each tick can't be disabled. You can
look at NO_HZ_FULL where you can have an isolated CPU and as long as you
don't go into kernel, you shouldn't see the timer interrupt very often.

> Thank you,
> Federico Reghenzani

Sebastian
