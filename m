From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Wed, 9 Mar 2016 13:04:16 +0100
Message-ID: <56E01140.70407@linutronix.de>
References: <56CDCCE6.5020801@prevas.dk> <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de> <20160226114809.GD8318@linutronix.de>
 <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
 <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
 <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
 <20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
 <56DDAF2A.2000009@linutronix.de>
 <20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
 <20160308211845.57e9796a@laptop> <56DFCAAA.3090807@prevas.dk>
 <20160309111353.3530f35b@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jakub Kicinski <kubakici@wp.pl>,
	=?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56058 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbcCIMEU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 07:04:20 -0500
In-Reply-To: <20160309111353.3530f35b@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/09/2016 12:13 PM, Jakub Kicinski wrote:
>> I not entirely sure what i have to do...
>> - Reenable the ONE_SHOT
>> - Disable irq when running in the loop, and enable when returning?
>> - Implement threaded irq?
>>
>> /Sean
> 
> Do not reenable ONE_SHOT.  Disable interrupt (disable_irq_nosync())
> in sc16is7xx_irq() and reenable at the end of sc16is7xx_ist().
> I think reenabling at the end of sc16is7xx_ist() is fine since it's a
> level triggered IRQ.

Josh's patch [0] which drops the ONE_SHOT flag has not yet been taken
by Greg. It sits only in the -RT tree at the moment. It might have
something to do with Greg not being in TO: or CC:

*I* don't care how you fix this in the end but please do something
before the merge window opens.

An ack by the maintainer of the driver and re-send to Greg (the usual
way) would be one way.

[0] http://lkml.iu.edu/hypermail/linux/kernel/1602.2/02637.html

Sebastian
