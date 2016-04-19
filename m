From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Tue, 19 Apr 2016 11:02:51 +0200
Message-ID: <5715F43B.8030309@linutronix.de>
References: <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <57068F28.8010409@linutronix.de>
 <1460123044.16946.11.camel@gmail.com> <5707B911.6090404@linutronix.de>
 <1460125010.16946.27.camel@gmail.com> <5707C563.2050801@linutronix.de>
 <1460134168.3860.6.camel@gmail.com> <20160418171550.GA21734@linutronix.de>
 <1461002132.3895.59.camel@gmail.com> <5715D919.2030500@linutronix.de>
 <1461056100.3921.40.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461056100.3921.40.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/19/2016 10:55 AM, Mike Galbraith wrote:
> I can't get to my DL980 to do jitter testing atm (network outage), but
> wrt hotplug banging, my local boxen say patch is toxic.  i4790 desktop
> box silently bricked once too.  The boom begins with...
> 
>    BUG: scheduling while atomic: futex_wait/11303/0x00000000
> 
> ...very noisy funeral procession follows.

thanks for the feedback. My box survived overnight. Let me dig further
maybe I find something.

> 
> 	-Mike
> 
Sebastian
