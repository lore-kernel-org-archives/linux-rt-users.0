From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 6/6] Preempt-RCU: Update RCU Documentation.
Date: Thu, 13 Dec 2007 21:42:53 +0100
Message-ID: <20071213204253.GG25130@elte.hu>
References: <20071213170348.GA25981@in.ibm.com> <20071213171814.GG25981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gautham R Shenoy <ego@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:55827 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803AbXLMUn0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 15:43:26 -0500
Content-Disposition: inline
In-Reply-To: <20071213171814.GG25981@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> Preempt-RCU: Update RCU Documentation.
> 
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> This patch updates the RCU documentation to reflect preemptible RCU as
> well as recent publications.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Gautham, this patch is missing your SoB line - could you please send it?

	Ingo
