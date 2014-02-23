From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question on clock drift with NO_HZ_FULL vs NO_HZ_IDLE
Date: Sun, 23 Feb 2014 08:38:49 -0800
Message-ID: <20140223163849.GV4250@linux.vnet.ibm.com>
References: <CAD=GYpaGnS=1A7z6AhtJ9KGH68NY4C5rGRXgfePm33he6s6YOw@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, fweisbec@gmail.com
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:44044 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaBWQi4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 23 Feb 2014 11:38:56 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 23 Feb 2014 09:38:55 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2E81619D8042
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Feb 2014 09:38:51 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1NGcKoO6029808
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Feb 2014 17:38:20 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id s1NGgI7v012328
	for <linux-rt-users@vger.kernel.org>; Sun, 23 Feb 2014 09:42:19 -0700
Content-Disposition: inline
In-Reply-To: <CAD=GYpaGnS=1A7z6AhtJ9KGH68NY4C5rGRXgfePm33he6s6YOw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Feb 23, 2014 at 01:20:53AM -0600, Joel Fernandes wrote:
> Hi,
> After reading documentation, I follow that NO_HZ_FULL turns off the
> scheduling-clock interrupt on all except the boot CPU, where as
> NO_HZ_IDLE turns it off on all idle CPUs.
> 
> I understand the period scheduling-clock interrupt is required to
> compensate for hardware oscillator drift. I believe that's why
> NO_HZ_FULL keeps it ON on atleast one CPU. That way the drift is
> compensated for.
> 
> But, with NO_HZ_IDLE, all CPUs turn off interrupt during idle. Then
> how is the drift accounted for?
> 
> CC'ing Paul as well for any guidance, thanks :)

The clock code fixes things up as needed when the first CPU returns
from idle.

							Thanx, Paul

