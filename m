From: Henri Roosen <henri.roosen@ginzinger.com>
Subject: Re: INFO: rcu_preempt detected stalls on CPUs/tasks
Date: Fri, 15 Jul 2016 12:54:25 +0200
Message-ID: <150d1d1f-b427-50be-524d-dbe80dd5523e@ginzinger.com>
References: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
 <20160714152703.GA12152@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:34734 "EHLO
	mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbcGOKya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 06:54:30 -0400
In-Reply-To: <20160714152703.GA12152@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/14/2016 05:27 PM, Sebastian Andrzej Siewior wrote:
> * Roosen Henri | 2016-06-30 16:05:09 [+0000]:
>
>> Hi,
> Hi,
>
>> I just got an info-backtrace while running cyclictest on an iMX28 with kernel 4.1.27-rt30.
>> This resulted in a latency spike (i'm not sure whether caused by the trace dumping).
>> Can anyone share some info on this and what to do to prevent the cause of this info-trace?
>
> Did you do anything else besides starting cyclictest?

To put the system under load we're running a "dohell" script, which
boils down to parallel running hackbench and dd, ls, ps, cat, .. commands.

The problem is easily triggered, but only after starting a flood-ping to
the PREEMPT_RT-system under test. This also results in huge latency,
much bigger than on a 'normal' PREEMPT-system, which seems to be
resistant against the flood-ping.

Any suggestions how to best trace this down?

Thanks,
Henri

> RCU was somehow blocked and did not make any progress. This might if a
> task in an RCU-read section got preempted for long time _or_ is active
> in that section over a very long time. More information can be found at
>   https://www.kernel.org/doc/Documentation/RCU/stallwarn.txt
>
> Sebastian
>

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

