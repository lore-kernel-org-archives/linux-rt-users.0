From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Wed, 07 Jul 2010 14:50:50 +0200
Message-ID: <1278507050.7496.0.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <1278489784.7493.2.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071357360.2604@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754680Ab0GGMvA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 08:51:00 -0400
In-Reply-To: <alpine.LFD.2.00.1007071357360.2604@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(switches back to primary address.. dang evolution)

On Wed, 2010-07-07 at 13:57 +0200, Thomas Gleixner wrote:
> On Wed, 7 Jul 2010, Mike Galbraith wrote:
> 
> > 
> > FWIW, 2.6.31.14-rt21 explodes too (darn).
> 
> What about .29-rt ?

Goes boom too.

	-Mike

