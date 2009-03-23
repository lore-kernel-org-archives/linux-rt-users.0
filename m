From: David Miller <davem@davemloft.net>
Subject: Re: High contention on the sk_buff_head.lock
Date: Mon, 23 Mar 2009 01:37:49 -0700 (PDT)
Message-ID: <20090323.013749.122944803.davem@davemloft.net>
References: <20090320232943.GA3024@ami.dom.local>
	<49C74927.7020008@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jarkao2@gmail.com, vernux@us.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: dada1@cosmosbay.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48407
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752245AbZCWIiC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Mar 2009 04:38:02 -0400
In-Reply-To: <49C74927.7020008@cosmosbay.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Mon, 23 Mar 2009 09:32:39 +0100

> I dont understand, doesnt it defeat the ticket spinlock thing and fairness ?
> 
> Thread doing __qdisc_run() already owns the __QDISC_STATE_RUNNING bit.

Right.

Remember, the way this is designed is that if there is a busy
cpu taking packets out of the queue and putting them into the
device then other cpus will simply add to the queue and immediately
return.  This effectively keeps the queue running there processing
all the new work that other cpus are adding to the qdisc.

Those other cpus make these decisions by looking at that
__QDISC_STATE_RUNNING bit, which the queue runner grabs before
it does any work.
