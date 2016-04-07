From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch 2/2] rt/locking/hotplug: Fix rt_spin_lock_slowlock()
 migrate_disable() bug
Date: Thu, 7 Apr 2016 18:48:56 +0200
Message-ID: <57068F78.2070607@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <1459837988.26938.16.camel@gmail.com>
 <1459860597.7776.2.camel@gmail.com> <1459944021.3990.14.camel@gmail.com>
 <1460003831.3882.106.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460003831.3882.106.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/07/2016 06:37 AM, Mike Galbraith wrote:
> On Wed, 2016-04-06 at 14:00 +0200, Mike Galbraith wrote:
>> It'll take a hotplug beating seemingly as well as any non-rt kernel,
>> but big box NAKed it due to jitter, which can mean 1.0 things.. duh.
> 
> FWIW, the below turned big box NAK into ACK.  Stressing hotplug over
> night, iteration completion time went from about 2 1/2 hours with
> bandaids on the two identified rt sore spots, to an hour and 10 minutes
> as well for some reason, but whatever..

Just to be clear. I need #1, #2 from this thread and this below to make
it work?

> 	-Mike
> 

Sebastian
