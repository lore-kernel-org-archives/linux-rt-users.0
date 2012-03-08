From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.2.9-rt17
Date: Thu, 08 Mar 2012 15:01:40 -0500
Message-ID: <1331236900.25686.462.camel@gandalf.stny.rr.com>
References: <alpine.LFD.2.02.1203072225020.2742@ionos>
	 <1331230991.25686.452.camel@gandalf.stny.rr.com>
	 <1331231287.11248.396.camel@twins>
	 <1331232159.25686.456.camel@gandalf.stny.rr.com>
	 <1331236139.11248.407.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9267 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758367Ab2CHUBm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Mar 2012 15:01:42 -0500
In-Reply-To: <1331236139.11248.407.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-03-08 at 20:48 +0100, Peter Zijlstra wrote:
> On Thu, 2012-03-08 at 13:42 -0500, Steven Rostedt wrote:
> > cpu_chill_on_lock().
> 
> I think what you were hinting at is:
> 
>   spin_lock(&lock);
>   spin_unlock(&lock);

Exactly.

> 
> which is the rt_mutex implementation of spin_unlock_wait(). No new
> function needed for that.

Yes but...
> 
> Trouble is that you cannot use inode->i_lock as explained..

Right!


What I was hinting at was that the spin_lock() can boost, but it could
also fail if there was a deadlock detected, and it wouldn't cause the
system to hang.

-- Steve


