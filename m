From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Tue, 19 Apr 2016 09:07:05 +0200
Message-ID: <5715D919.2030500@linutronix.de>
References: <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <57068F28.8010409@linutronix.de>
 <1460123044.16946.11.camel@gmail.com> <5707B911.6090404@linutronix.de>
 <1460125010.16946.27.camel@gmail.com> <5707C563.2050801@linutronix.de>
 <1460134168.3860.6.camel@gmail.com> <20160418171550.GA21734@linutronix.de>
 <1461002132.3895.59.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37329 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbcDSHHN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Apr 2016 03:07:13 -0400
In-Reply-To: <1461002132.3895.59.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/18/2016 07:55 PM, Mike Galbraith wrote:
> 
> I'll have to feed it to DL980, hotplug and jitter test it.  It seemed
> to think that pinning post acquisition was a bad idea jitter wise, but
> I was bending things up while juggling multiple boxen, so..

pinning pre acquisition could get you in a situation where you get the
lock and you are stuck on CPU A where is also a task running right now
with a higher priority while CPU B and CPU C are idle.

> 
> 	-Mike
> 
Sebastian
