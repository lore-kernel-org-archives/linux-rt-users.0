From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Tue, 8 Mar 2016 21:18:45 +0000
Message-ID: <20160308211845.57e9796a@laptop>
References: <56CDCCE6.5020801@prevas.dk>
	<56CDEAE2.9050102@prevas.dk>
	<20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
	<20160226114340.GC8318@linutronix.de>
	<20160226114809.GD8318@linutronix.de>
	<C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
	<20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
	<835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
	<20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
	<56DDAF2A.2000009@linutronix.de>
	<20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.9]:56578 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbcCHVSv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2016 16:18:51 -0500
In-Reply-To: <20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Mar 2016 10:58:09 -0600, Josh Cartwright wrote:
> > I got lost here. Where do we stand here now?  
> 
> I understood the comment from Kuba to mean that he would be implementing
> the disable_irq()/enable_irq() idea above to fix all the problems with
> this driver.
> 
> Kuba- did I read that right?

I was hoping Sean or someone else would take up this task ;)

It should be a pretty simple patch.

Kuba
