From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC -rt] Allow rcutorture to handle synchronize_sched()
Date: Fri, 03 Aug 2007 15:38:32 -0700
Message-ID: <1186180712.2677.16.camel@josh-work.beaverton.ibm.com>
References: <20070803184449.GA2196@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, dipankar@in.ibm.com, ego@in.ibm.com,
	vatsa@in.ibm.com
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:34273 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbXHCWiC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Aug 2007 18:38:02 -0400
In-Reply-To: <20070803184449.GA2196@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-03 at 11:44 -0700, Paul E. McKenney wrote:
> The rcutorture module uses a random-number generator that periodically
> calls get_random_bytes() to add entropy.  This random-number generator
> is invoked from within the RCU read-side critical section, which, in the
> case of the synchronize_sched() variant of RCU, has preeemption disabled.
> Unfortunately, get_random_bytes() ends up acquiring normal spinlocks,
> which can block in -rt, resulting in very large numbers of "scheduling
> while atomic" messages.
> 
> This patch takes a very crude approach, simply substituting the time
> of day for get_random_bytes().
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Acked-by: Josh Triplett <josh@kernel.org>
