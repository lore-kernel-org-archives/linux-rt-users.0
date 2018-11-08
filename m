From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: rcu: Merge RCU-bh into RCU-preempt
Date: Thu, 8 Nov 2018 17:02:57 +0100
Message-ID: <20181108160256.xpawe65h5lm65soi@linutronix.de>
References: <20181101231804.GA11280@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101231804.GA11280@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-01 16:18:04 [-0700], Paul E. McKenney wrote:
> The need for this goes away as of the current merge window because
> RCU-bh has gone away.  (Aside from still being able to do things
> like rcu_read_lock_bh() as a documentation device.)

So in -RT rcu_read_lock_bh() does
 { local_bh_disable() ;  rcu_read_lock() }

So you are saying that this is also the case in v4.20?

> 							Thanx, Paul
> 

Sebastian
