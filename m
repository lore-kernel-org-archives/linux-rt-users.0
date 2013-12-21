From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Sat, 21 Dec 2013 22:23:01 +0100
Message-ID: <52B606B5.70205@osadl.org>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de> <529A6AFD.9020308@osadl.org> <20131215145325.GH31090@linutronix.de> <52AE402A.90105@osadl.org> <52AEB525.4060907@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:54074 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab3LUVfU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 Dec 2013 16:35:20 -0500
In-Reply-To: <52AEB525.4060907@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/16/2013 09:09 AM, Sebastian Andrzej Siewior wrote:
> On 12/16/2013 12:50 AM, Carsten Emde wrote:
>> On 12/15/2013 03:53 PM, Sebastian Andrzej Siewior wrote:
>>> * Carsten Emde | 2013-11-30 23:47:25 [+0100]:
>>>> Will apply the fix and the warning - let's see.
>>> I do not want to urge anyone but just gentle ping to satisfy my
>>> curiosity about the patch.
>> I have applied the patch to a number of systems including the one that
>> regularly crashed after less than a week. No system crashed so far, and
>> uptime of the one that I initially monitored for the crashes is now 15
>> days. Please allow for another week of monitoring. If by next weekend
>> all patched systems still are up and running, I will submit the patch
>> along with a description and a short history when and how the race made
>> it into the code.
> Sounds great. Thanks.
Uptime is now 20 days, no problems any more.

Just wanted to write down the whole story and send the patch to LKML 
when I saw that the patch already made it into vanilla 3.12.5 and, thus, 
to RT. It is marked 3.8+ stable, so all is good now.

The mainline patch is:
ACPI / EC: Ensure lock is acquired before accessing ec struct members, 
commit 36b15875a7819a2ec4cb5748ff7096ad7bd86cbb.

	-Carsten.
