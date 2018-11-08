From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: rcu: Frob softirq test
Date: Thu, 8 Nov 2018 17:41:56 +0100
Message-ID: <20181108164156.n4zkpvzbuins5ggf@linutronix.de>
References: <20181101232134.GA11875@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: a.p.zijlstra@chello.nl, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101232134.GA11875@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-01 16:21:34 [-0700], Paul E. McKenney wrote:
> > With RT_FULL we get the below wreckage:
> 
> The code that this applies to has itself been fully frobbed as of the
> current merge window.  I believe that it should now work in -rt as is,
> but who knows?  ;-)

I will drop that patch in the 4.21-RT release (since it won't apply at
all) and then we will see :)

> 							Thanx, Paul

Sebastian
