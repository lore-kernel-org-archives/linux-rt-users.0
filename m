From: David Miller <davem@davemloft.net>
Subject: Re: BUG in 2.6.20-rt8
Date: Sun, 25 Feb 2007 18:09:27 -0800 (PST)
Message-ID: <20070225.180927.112620704.davem@davemloft.net>
References: <20070225062747.GA13432@elte.hu>
	<20070224.223744.59470086.davem@davemloft.net>
	<20070226015230.GN5049@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50022
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751050AbXBZCJ2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Feb 2007 21:09:28 -0500
In-Reply-To: <20070226015230.GN5049@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Sun, 25 Feb 2007 17:52:30 -0800

> Why doesn't the traditional hash table of locks work here?  Use the
> cache-line address as input to the hash function, take the corresponding
> lock, do the compare-and-exchange by hand, and then release the lock.
> What am I missing here?  Address aliasing do to memory being mapped into
> multiple locations or something?  (In that case, use only the portion
> of the address within the page, right?)

It doesn't protect against pure stores.

Even ignoring that you'll also need to disable interrupts, always,
which therefore will always perform very poorly compared to an
open-coded spinlock variant.

There are zero gains to cmpxchg(), in my opinion, you dirty and
grab exclusive access to a cacheline with cmpxchg() just the
same as a spinlock, so the real cost is the same.

There is zero justification for using this primitive in generic
code.
