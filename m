From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: 2.6.24-rc8-rt1: Strange latencies on mpc5200 powerpc - RCU issue?
Date: Tue, 29 Jan 2008 14:38:04 +0100
Message-ID: <479F2C3C.1020203@grandegger.com>
References: <1200544050.318.18.camel@localhost.localdomain> <478F2A46.5070506@grandegger.com> <20080123145340.GE6200@pengutronix.de> <47976D06.1010900@grandegger.com> <479DF0A1.3000906@pengutronix.de> <479DF711.5090406@grandegger.com> <479F186A.4020004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932561AbYA2NiJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2008 08:38:09 -0500
In-Reply-To: <479F186A.4020004@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Luotao Fu wrote:
> Hi,
> 
> Wolfgang Grandegger wrote:
> ..........
>> Do you still get high latencies with:
>>
>>   CONFIG_PREEMPT_RCU_BOOST=y
>>   CONFIG_RCU_TRACE=y
>>   CONFIG_NO_HZ is not set
>>
>> With this setting I have not yet realized latencies > 150us. Could you
>> please give it a try? If I change one of the parameters above, latency
>> increases in short time.
> 
> I played through some combination of the RCU options and can back your
> observation this time: With the rcu Tracer or the priority boost turned
> off I also could measure reliably extraordinory high latencies. If they
> are both turned on, no high latencies could be measured. Turning on the
> dynamic ticker however doesn't seem to cause high latencies during my
> test runs. Seemed like an rcu issue here.

I'm just making a long test run on my TQM5200 module with my good
settings. After more than 4.5 hours under load, cyclictest shows a
maximum latency of 177 us. I'm going to re-check the effect of CONFIG_NO_HZ.

> Further such results only appear if the target board is booted with
> nfsrootfs. (As I already have mentioned several times before), which
> leads my suspection to rcu usage in nfs implementation. In this case
> this problem might even be platformindependent. I'd have to do some
> tests on one of our arm boards later to test this. Since there're no
> reports like this for other architecture as powerpc till now, I doubt
> quite if this is verifiable.

It's also my suspicion that the high latencies are related to the RCU
usage in the network layer, where it's heavily used. What is really
wired is that switching off CONFIG_RCU_TRACE has a negative impact on
the latency. As I see it, it just adds some trace points, but I might
have missed something.

Wolfgang.
