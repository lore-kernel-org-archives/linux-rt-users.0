From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.4-rt11
Date: Mon, 11 Jun 2007 09:36:34 +0200
Message-ID: <20070611073634.GB32446@elte.hu>
References: <20070609210507.GA29194@elte.hu> <20070611011954.GG27982@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:42686 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbXFKHhF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 03:37:05 -0400
Content-Disposition: inline
In-Reply-To: <20070611011954.GG27982@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> 2.6.21.4-rt12 boots on 4-CPU Opteron and passes several hours of 
> rcutorture.  However, if I simply do "modprobe rcutorture", the kernel 
> threads do not spread across the CPUs as I would expect them to, even 
> given CFS.  Instead, the readers all stack up on a single CPU, and I 
> have to use the "taskset" command to spread them out manually.  Is 
> there some config parameter I am missing out on?

hm, what affinity do they start out with? Could they all be pinned to 
CPU#0 by default?

	Ingo
