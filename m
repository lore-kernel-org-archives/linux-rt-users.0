From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.4-rt11
Date: Mon, 11 Jun 2007 17:38:55 +0200
Message-ID: <20070611153855.GA21136@elte.hu>
References: <20070609210507.GA29194@elte.hu> <20070611011954.GG27982@linux.vnet.ibm.com> <20070611073634.GB32446@elte.hu> <20070611144401.GA9102@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:39322 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbXFKPjK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 11:39:10 -0400
Content-Disposition: inline
In-Reply-To: <20070611144401.GA9102@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > hm, what affinity do they start out with? Could they all be pinned 
> > to CPU#0 by default?
> 
> They start off with affinity masks of 0xf on a 4-CPU system.  I would 
> expect them to load-balance across the four CPUs, but they stay all on 
> the same CPU until long after I lose patience (many minutes).

ugh. Would be nice to figure out why this happens. I enabled rcutorture 
on a dual-core CPU and all the threads are spread evenly.

	Ingo
