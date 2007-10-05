From: Andi Kleen <ak@suse.de>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Fri, 5 Oct 2007 18:03:31 +0200
Message-ID: <200710051803.32016.ak@suse.de>
References: <47060B680200006C00019B7B@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, arjan@infradead.org, tglx@linutronix.de,
	akpm@linux-foundation.org, "Gregory Haskins" <GHaskins@novell.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "David Bahi" <dbahi@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763440AbXJEQFk@vger.kernel.org>
In-Reply-To: <47060B680200006C00019B7B@sinclair.provo.novell.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> If it's agreed that this is the fix - can you submit a proper [PATCH] so
> all users of watchdog_use_timer_and_hpet_on_x86_64.patch can be removed,
> and replaced with yours.

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/watchdog-fix

-Andi
