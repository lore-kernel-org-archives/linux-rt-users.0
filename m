From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Scheduler model, revisited
Date: Tue, 13 Dec 2011 11:17:07 -0800
Message-ID: <20111213191707.GA10771@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: pjt@google.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53977 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1LMTTK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Dec 2011 14:19:10 -0500
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 13 Dec 2011 14:19:09 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBDJIj4u208472
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2011 14:18:45 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBDJH8ct024424
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2011 12:17:09 -0700
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello, Paul,

Back in Prague, you mentioned that a number of your scheduler-parameter
measurements were poor fits for the exponential distribution.  Are they
a reasonable fit for a series of exponentially distributed Markov states?

For example, would they fit something of the following form?

	a^2*t*e^(-a*t)

Or would a three-step series fit better?

	(a^3*t^2*e^(-a*t))/2

And there is always the four-step series:

	(a^4*t^3*e^(-a*t))/6

Or, in general:

	(a^n*t^(n-1)*e^(-a*t))/(n-1)!

But please keep in mind that higher orders multiply my state space by
the number of steps in the series.  ;-)

							Thanx, Paul

