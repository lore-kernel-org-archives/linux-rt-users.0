From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Thu, 22 Aug 2013 20:24:23 +0200
Message-ID: <20130822182423.GA8685@linutronix.de>
References: <20130822182127.GA7606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130822182127.GA7606@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Sebastian Andrzej Siewior | 2013-08-22 20:21:27 [+0200]:

>Changes since v3.10.9-rt4
>- swait fixes from Steven. It fixed the issues with CONFIG_RCU_NOCB_CPU
>  where the system suddenly froze and RCU wasn't doing its job 

Also a big thanks to Carsten Emde and Paul E. McKenney for finding and
debugging the problem.

Sebastian
