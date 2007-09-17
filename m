From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 12:07:27 -0700
Message-ID: <1190056047.3253.104.camel@imap.mvista.com>
References: <200709172012.21102.ak@suse.de> <200709172046.50850.ak@suse.de>
	 <1190055244.3253.95.camel@imap.mvista.com>  <200709172100.03279.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:50285 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbXIQTJl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 15:09:41 -0400
In-Reply-To: <200709172100.03279.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 21:00 +0200, Andi Kleen wrote:
> > Since it's all got "__" in the front, not good to use this method all
> > over .. If you just need a real spinlock best to use
> > DEFINE_RAW_SPINLOCK() unless your a special situation ..
> 
> Oopsing is a special situation. Nobody knows if all the fancy infrastructure
> lurking inside the other macros still works.

In the case of spinlocks, real time just differs from the mainline
kernel by make a spinlock_t into a mutex .. We know that's not going to
work in this situation. The rest of the debugging added to spinlocks is
mostly un-changed from mainline (like lockdep is still there)..

So you should be able to use a regular mainline style spinlock_t for the
die_lock, even with all the debugging ..

The real time spinlock macros are pretty complex , but it's mostly
compile related complexity that disappears when you run the kernel.

Daniel
