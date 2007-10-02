From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Mon, 1 Oct 2007 22:00:22 -0700
Message-ID: <20071001220022.5c9b9bef@laptopd505.fenrus.org>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com>
	<200710012341.53169.ak@suse.de>
	<alpine.LFD.0.9999.0710012349160.20478@localhost.localdomain>
	<200710020007.09864.ak@suse.de>
	<alpine.LFD.0.9999.0710020043450.20478@localhost.localdomain>
	<4701CF78.5020802@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	David Bahi <dbahi@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <GHaskins@novell.com>
To: Mika =?UTF-8?B?UGVudHRpbMOk?= <mika.penttila@kolumbus.fi>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:53389 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbXJBFCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 01:02:19 -0400
In-Reply-To: <4701CF78.5020802@kolumbus.fi>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 02 Oct 2007 07:56:24 +0300
Mika Penttil=C3=A4 <mika.penttila@kolumbus.fi> wrote:


> Here I have with stock FC7 (2.6.22.9-91) kernel :
>  0:     107835  133459760   IO-APIC-edge      timer
>=20


fwiw this is entirely done by the hardware; no irq balancer has touched
this one (fc7 has the new irqbalancer which leaves irq0 alone)
