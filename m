From: Daniel Walker <dwalker@mvista.com>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 09:20:01 -0700
Message-ID: <1181233202.11539.36.camel@imap.mvista.com>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
	 <1181231910.3841.55.camel@bender>
	 <1181232783.10408.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Altenberg <jan.altenberg@linutronix.de>,
	Oleg Kechin <okechin@gmail.com>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:13718 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbXFGQXI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 12:23:08 -0400
In-Reply-To: <1181232783.10408.8.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 12:13 -0400, Steven Rostedt wrote:

> 
> What arch is innovator1510 (OMAP5910 cpu) anyway?

It's an ARM .

> /me has been away from embedded systems for some time.
> 

The "fix" went into -rt6 , then was dropped in -rt7 .. I guess a better
fix is being working on, not sure..

Daniel
