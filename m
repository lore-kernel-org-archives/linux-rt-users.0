From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: INFO: rcu_preempt detected stalls on CPUs/tasks
Date: Thu, 14 Jul 2016 17:27:03 +0200
Message-ID: <20160714152703.GA12152@linutronix.de>
References: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45109 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcGNP1G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 11:27:06 -0400
Content-Disposition: inline
In-Reply-To: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Roosen Henri | 2016-06-30 16:05:09 [+0000]:

>Hi,
Hi,

>I just got an info-backtrace while running cyclictest on an iMX28 with kernel 4.1.27-rt30.
>This resulted in a latency spike (i'm not sure whether caused by the trace dumping).
>Can anyone share some info on this and what to do to prevent the cause of this info-trace?

Did you do anything else besides starting cyclictest?
RCU was somehow blocked and did not make any progress. This might if a
task in an RCU-read section got preempted for long time _or_ is active
in that section over a very long time. More information can be found at
  https://www.kernel.org/doc/Documentation/RCU/stallwarn.txt

Sebastian
