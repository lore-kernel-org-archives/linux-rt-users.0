From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: looking for something like raw_rwlock_t or some optimization in
 rwlock_t in Linux 3.0
Date: Tue, 08 May 2012 11:17:24 -0400
Message-ID: <1336490244.14207.185.camel@gandalf.stny.rr.com>
References: <CACpc7petSnyR4qwE+F_b-OcdXc9+c5RRrX_u0TiLZnzy2eDWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5396 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab2EHPRZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 May 2012 11:17:25 -0400
In-Reply-To: <CACpc7petSnyR4qwE+F_b-OcdXc9+c5RRrX_u0TiLZnzy2eDWOg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-05-07 at 10:19 +0530, Priyanka Gupta Jain wrote:
> hi,
> 
> I would really appreciate if someone can help in finding an
> alternative to rwlock_t.
> I want one particular rw_lock to behave as in native linux not as
> mutex of if there is any other optimization that I can do in that
> rwlock or in general to all rwlocks as well.
> This is required to boost the performance in case of multicore systems
> 

Understood. We use to have a rwlock multi prio-inheritance logic. But it
ended up being too complex and prone to bugs. Prio-inheritance is
complex and adding multi users to this just makes it exponentially more.

If there's ways to get rid of rwlocks with rcu locks (which is not
always possible) then that would be the best solution.

Unfortunately, we don't have a current solution for this problem :-(

-- Steve


