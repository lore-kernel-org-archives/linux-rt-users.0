From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RCU stalls on heavy socket traffic
Date: Mon, 09 Mar 2015 21:24:23 +0100
Message-ID: <54FE0177.7010407@linutronix.de>
References: <20150309152651.GD13768@linutronix.de> <20150309155947.GW5236@linux.vnet.ibm.com> <20150309163915.GF13768@linutronix.de> <20150309180212.GX5236@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37606 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbCIUY1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Mar 2015 16:24:27 -0400
In-Reply-To: <20150309180212.GX5236@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/09/2015 07:02 PM, Paul E. McKenney wrote:
> abaf3f9d275b (rcu: Revert "Allow post-unlock reference for rt_mutex" to avoid priority-inversion)
> 
> This patch fixed a priority-inversion problem, so might well fix your
> RCU CPU stall-warning problem.

Yes, it fixes the problem. Thank you.

> 							Thanx, Paul
> 

Sebastian
