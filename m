From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 8 Apr 2016 15:58:41 +0200
Message-ID: <5707B911.6090404@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <57068F28.8010409@linutronix.de>
 <1460123044.16946.11.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460123044.16946.11.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/08/2016 03:44 PM, Mike Galbraith wrote:
> On Thu, 2016-04-07 at 18:47 +0200, Sebastian Andrzej Siewior wrote:
> 
>> just to be clear: The patch I attached did _not_ work for you.
> 
> Did you perchance mean with "Reenable migration across schedule"
> reverted?  Figured it would still explode in seconds.. it did.

I meant 4.4.6-rt13 + my patch and nothing else.

> [  172.996232] kernel BUG at kernel/locking/rtmutex.c:1360!

okay. and how did you trigger this? Just Steven's script or was there
more to it?

Sebastian
