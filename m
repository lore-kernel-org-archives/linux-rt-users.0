From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 8 Apr 2016 16:51:15 +0200
Message-ID: <5707C563.2050801@linutronix.de>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
 <alpine.DEB.2.11.1603241140510.3978@nanos>
 <1459405903.14336.64.camel@gmail.com> <20160401211105.GE29603@linutronix.de>
 <1459566735.3779.36.camel@gmail.com> <57068F28.8010409@linutronix.de>
 <1460123044.16946.11.camel@gmail.com> <5707B911.6090404@linutronix.de>
 <1460125010.16946.27.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52053 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbcDHOvT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Apr 2016 10:51:19 -0400
In-Reply-To: <1460125010.16946.27.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/08/2016 04:16 PM, Mike Galbraith wrote:
>> okay. and how did you trigger this? Just Steven's script or was there
>> more to it?
> 
> I run stockfish, futextest, hackbench and tbench with it, terminating
> and restarting them at random intervals just to make sure nobody gets
> into a comfortable little rut.  Stockfish and tbench are sized as to
> not saturate the box, hackbench runs periodically (and with no args to
> turn it into a hog), futextest run.sh just does its normal thing.

Is there anything you can hand me over?

> Trying to grab an rtmutex while queued on an rtmutex... doesn't matter
> much if it's the lock that likes to deadlock us, or the one you added
> instead of making that blasted lock really really dead.

Yeah, doesn't look too good.

> 	-Mike
> 
Sebastian
