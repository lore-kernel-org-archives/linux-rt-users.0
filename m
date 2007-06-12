From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.4-rt11
Date: Tue, 12 Jun 2007 23:37:58 +0200
Message-ID: <20070612213758.GA6173@elte.hu>
References: <20070609210507.GA29194@elte.hu> <20070611011954.GG27982@linux.vnet.ibm.com> <20070611073634.GB32446@elte.hu> <20070611144401.GA9102@linux.vnet.ibm.com> <20070611153855.GA21136@elte.hu> <20070611155527.GD9102@linux.vnet.ibm.com> <20070611171806.GH9102@linux.vnet.ibm.com> <20070611204427.GK9102@linux.vnet.ibm.com> <20070611221803.GL9102@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51104 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbXFLVim (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jun 2007 17:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20070611221803.GL9102@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Not a biggie for me, since I can easily do the taskset commands to 
> force the processes to spread out, but I am worried that casual users 
> of rcutorture won't know to do this -- thus not really torturing RCU. 
> It would not be hard to modify rcutorture to affinity the tasks so as 
> to spread them, but this seems a bit ugly.

does it get any better if you renice them from +19 to 0? (and then back 
to +19?)

	Ingo
