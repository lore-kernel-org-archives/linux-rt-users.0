From: Andi Kleen <ak@suse.de>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Tue, 2 Oct 2007 00:07:09 +0200
Message-ID: <200710020007.09864.ak@suse.de>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com> <200710012341.53169.ak@suse.de> <alpine.LFD.0.9999.0710012349160.20478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Arjan van de Ven <arjan@infradead.org>,
	David Bahi <dbahi@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <GHaskins@novell.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41414 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbXJAWIx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 18:08:53 -0400
In-Reply-To: <alpine.LFD.0.9999.0710012349160.20478@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> OTOH, the accounting hook would allow us to remove the IRQ#0 -> CPU#0
> restriction. Not sure whether it's worth the trouble.

Some SIS chipsets hang the machine when you migrate irq 0 to another
CPU. It's better to keep that Also I wouldn't be surprised if there are some
other assumptions about this elsewhere.

Ok in theory it could be done only on SIS, but that probably would really
not be worth the trouble

-Andi
