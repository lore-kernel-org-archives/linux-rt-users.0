From: John Sigler <linux.kernel@free.fr>
Subject: Re: [PATCH 3/4 RFC] RCU: preemptible RCU
Date: Wed, 08 Aug 2007 11:10:32 +0200
Message-ID: <46B98888.6030600@free.fr>
References: <20070807183946.GA32110@linux.vnet.ibm.com> <20070807184812.GC10068@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:43638 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbXHHJLG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 05:11:06 -0400
In-Reply-To: <20070807184812.GC10068@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ Recipients list trimmed ]

Paul E. McKenney wrote:

> This patch was developed as a part of the -rt kernel development and
> meant to provide better latencies when read-side critical sections of
> RCU don't disable preemption.  As a consequence of keeping track of RCU
> readers, the readers have a slight overhead (optimizations in the paper).
> This implementation co-exists with the "classic" RCU implementations
> and can be switched to at compiler.

I cannot parse the last sentence :-)

Did you mean that this new implementation can be chosen (over the 
classic implementation) at compile-time?

Regards.
