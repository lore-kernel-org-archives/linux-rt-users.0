From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rt & hotplug work....
Date: Fri, 20 Jul 2012 17:24:09 -0700
Message-ID: <20120721002404.GA2435@linux.vnet.ibm.com>
References: <CAF-VNaoh=t50=6A-OXitYPJxz67Es_jFQeqsXcdJThexb8uHSg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:46990 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2GUAbl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2012 20:31:41 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 20 Jul 2012 18:31:40 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7C5633E40026
	for <linux-rt-users@vger.kernel.org>; Sat, 21 Jul 2012 00:31:37 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6L0VbYY273024
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2012 18:31:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6L0Vbfo017653
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2012 18:31:37 -0600
Content-Disposition: inline
In-Reply-To: <CAF-VNaoh=t50=6A-OXitYPJxz67Es_jFQeqsXcdJThexb8uHSg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jul 20, 2012 at 10:07:38PM +0200, Lars Segerlund wrote:
>  There was some cpu hotplug work recently, and I can't get my head
> around what happens with a dual cpu system if one core is shut down,
> specificly with spinlocks.
>  Won't it just hang or spin a lot ? I was thinking the locking was
> different in the build for uni of multi processors, to eliminate the
> deadlock risk on a uni processor.
> 
>  I do realise this might not be rt specific, but I'll ask anyhow.

When a CPU-hotplug operation takes a CPU offline, that CPU must release
any true spinlocks before actually going away.  Therefore, when the
surviving CPU attempts to acquire a spinlock, it is guaranteed to
acquire it immediately.  (Some architectures go even farther and
optimize away spinlock acquisitions when the system transitions to
single-CPU operation.)

							Thanx, Paul

