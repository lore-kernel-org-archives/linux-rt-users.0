From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Mon, 7 Mar 2016 17:41:14 +0100
Message-ID: <56DDAF2A.2000009@linutronix.de>
References: <56CDCCE6.5020801@prevas.dk> <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de> <20160226114809.GD8318@linutronix.de>
 <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
 <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
 <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
 <20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <joshc@ni.com>, Kuba Kicinski <kubakici@wp.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45898 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbcCGQlS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 11:41:18 -0500
In-Reply-To: <20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/26/2016 08:00 PM, Josh Cartwright wrote:
> On Fri, Feb 26, 2016 at 01:26:27PM -0500, Kuba Kicinski wrote:
>> On 26 February 2016 11:52:28 GMT-05:00, Josh Cartwright <joshc@ni.com> wrote:
> [..]
>>> Instead, the driver needs to implement it's own oneshot-like
>>> handling at the device-level: in the registered irq handler, capture
>>> triggered interrupt state, squelch/mask, and enqueue the
>>> kthread_work.  In the tail-end of the kthread_work, re-enable
>>> interrupts at the device level.
>>
>> The problem there being IIRC that i2c doesn't provide async writes so
>> we can't mask from irq callback. The only option would be
>> disable_irq/enable_irq, right?
> 
> Ah, yes, that is a problem.  If by disable_irq(), you mean
> disable_irq_nosync(), then yes, I think that'd work.

I got lost here. Where do we stand here now?

> 
>   Josh
> 
Sebastian
