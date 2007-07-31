From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: BIOS implementors disabling the LAPIC
Date: Tue, 31 Jul 2007 13:55:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0707311343410.16158@blysk.ds.pg.gda.pl>
References: <46AEED9E.1050904@free.fr> <Pine.LNX.4.64N.0707311119350.16158@blysk.ds.pg.gda.pl>
 <46AF2BF8.3000601@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4864 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbXGaMzw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 08:55:52 -0400
In-Reply-To: <46AF2BF8.3000601@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 31 Jul 2007, John Sigler wrote:

> The motherboard manufacturer (well, their level 1 support, anyway) told me I
> could "safely enable the LAPIC". If it is safe to enable the LAPIC, then why
> are they disabling it in the BIOS? (They weren't able to tell me whether
> their BIOS triggers SMIs or not...)

 Ask them.

> Is this a "either works or doesn't" situation where hell should break loose if
> I try to enable the LAPIC and it's not supported by the motherboard, or is
> this a "you will silently lose data at the worst possible time" situation?

 It could be either.  For example some IBM hardware used to be known to 
have problems, like the 8254 timer freezing occasionally, when the APIC 
was used and the NMI watchdog enabled.  On some laptops you would get an 
instant hard lockup if you enabled the APIC and used one of the special 
key combinations (whether on purpose or by chance) used to adjust display 
brightness, etc..

> If that were the case, then I could not enable the LAPIC and have NMIs work,
> right?

 It depends on what you want to use NMIs for.  For their PC/AT compatible 
purpose, that is reporting of memory parity/ECC and bus errors, it works 
in either mode.  For any other purpose you need an APIC.

  Maciej
