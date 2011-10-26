From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Load-balancing at migrate-enable time?
Date: Wed, 26 Oct 2011 11:30:36 -0700
Message-ID: <20111026183036.GA3608@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org, peterz@infradead.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:53394 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab1J0HqB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Oct 2011 03:46:01 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 27 Oct 2011 03:45:50 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9R7jkNK457768
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 03:45:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9R7jjRC020112
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2011 03:45:45 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello!

So I am getting the second round of the model beaten into shape, but
have a question...

Assume the following state:

1.	Task 0 preempted in a migrate-disable region on CPU 0.

2.	Task 1 preempted, but not in a migrate-disable region,
	also on CPU 0.

3.	Task 2 running in a migrate-disable region also on CPU 0

Suppose that Task 2 enables migration.  Will it actually migrate
in order to allow Task 1 to run?  (My guess is "no", but...)

						Thanx, Paul

------------------------------------------------------------------------

PS.  We get to the above state by starting as follows:

1.	Task 0 blocked in a migrate-disable region on CPU 0.

2.	Task 1 running on CPU 0 without migration disabled.

3.	Task 2 blocked in a migrate-disable region also on CPU 0

Then Task 2 awakens, preempting Task 1.  (In the more-aggressive
model, this would trigger migration of Task 1, but I am trying to
match what the load balancer actually does.)

