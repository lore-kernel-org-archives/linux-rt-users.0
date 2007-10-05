From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Fri, 05 Oct 2007 11:38:12 -0600
Message-ID: <1191605892.31605.198.camel@hermosa.morrealenet>
References: <47060B680200006C00019B7B@sinclair.provo.novell.com>
	 <200710051803.32016.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Bahi <dbahi@novell.com>, mingo@elte.hu, arjan@infradead.org,
	tglx@linutronix.de, akpm@linux-foundation.org,
	Gregory Haskins <GHaskins@novell.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:37100 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbXJERkz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Oct 2007 13:40:55 -0400
In-Reply-To: <200710051803.32016.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-10-05 at 18:03 +0200, Andi Kleen wrote:
> > If it's agreed that this is the fix - can you submit a proper [PATCH] so
> > all users of watchdog_use_timer_and_hpet_on_x86_64.patch can be removed,
> > and replaced with yours.
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/watchdog-fix
> 
> -Andi
> 

Hummm, a directory appears to be protected, or DNE.  I get  "failed to
change directory". 

Thx,
-PWM
