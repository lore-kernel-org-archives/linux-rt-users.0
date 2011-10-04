From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Quick review of -rt RCU-related patches
Date: Wed, 05 Oct 2011 00:13:18 +0200
Message-ID: <1317766398.32543.39.camel@twins>
References: <20111004174755.GA4762@linux.vnet.ibm.com>
	 <alpine.LFD.2.02.1110042322450.18778@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1110042322450.18778@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2011-10-05 at 00:05 +0200, Thomas Gleixner wrote:
> I consider rcu_bh a bandaid for the nasty implict semantics of BH
> processing and I'm looking really forward to Peters analysis of the
> modern cpu local BKL constructs at RTLWS. 

You and me both! Oh wait.. :-)
