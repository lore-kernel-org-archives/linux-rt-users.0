From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Mon, 1 Oct 2007 12:56:26 -0700
Message-ID: <20071001125626.32eb6d0b@laptopd505.fenrus.org>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com>
	<200710011936.01528.ak@suse.de>
	<alpine.LFD.0.9999.0710012052310.20478@localhost.localdomain>
	<200710012116.59356.ak@suse.de>
	<alpine.LFD.0.9999.0710012124420.20478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <ak@suse.de>, David Bahi <dbahi@novell.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Gregory Haskins <GHaskins@novell.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:51879 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbXJAT6S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 15:58:18 -0400
In-Reply-To: <alpine.LFD.0.9999.0710012124420.20478@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 1 Oct 2007 21:27:39 +0200 (CEST)

> > I already did this here by checking for cpu != 0. But it also needs
> > either tracking or forbidding migrations of irq 0. I can take care
> > of the patch.
> 
> I was thinking about the same fix. On i386 we already have the irq 
> migration / balancing of irq 0 disabled. That's why we setup IRQ0 with
> IRQ_NOBALANCING.

btw doing this is a problem if the user decides to hot(un)plug cpu 0...
he then can't move the irqs away to do that
