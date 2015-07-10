From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Fri, 10 Jul 2015 15:23:18 +0200
Message-ID: <20150710132318.GA27402@linutronix.de>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
 <alpine.DEB.2.11.1507091605410.5134@nanos>
 <c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46742 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbGJNXT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 09:23:19 -0400
Content-Disposition: inline
In-Reply-To: <c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Koehrer Mathias (ETAS/ESW5) | 2015-07-10 12:49:46 [+0000]:

>Hi Thomas,
Hi Mathias,

>I have been able to catch this BUG again on a different PC during a reboot. Unfortunately, it happened before I had enabled ftrace_dump_on_oops.

if you managed to trigger it that reliably, could you revert
slub_delay_ctor_on_rt.patch in the queue and try again?

Sebastian
