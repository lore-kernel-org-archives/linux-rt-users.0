From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Tue, 26 Jul 2011 16:52:36 -0700
Message-ID: <4E2F5344.3030103@localhost>
References: <alpine.LFD.2.02.1107241223560.2702@ionos> <4E2DF459.3030509@localhost> <20110726091310.GP16561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.219.83]:43298 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064Ab1GZXwk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2011 19:52:40 -0400
In-Reply-To: <20110726091310.GP16561@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/26/2011 02:13 AM, Uwe Kleine-K=F6nig wrote:
> On Mon, Jul 25, 2011 at 03:55:21PM -0700, Fernando Lopez-Lezcano wrot=
e:
>> On 07/24/2011 03:33 AM, Thomas Gleixner wrote:
>>> Dear RT Folks,
>>>
>>> I'm pleased to announce the 3.0-rt3 release.
>>
>> Thanks!!... testing on a dual core laptop, fedora 15, 32 bit:
>>
>> [   32.169727] BUG: MAX_LOCKDEP_ENTRIES too low!
>> [   32.169730] turning off the locking correctness validator.
>>
>> (where do I change this?)
> I'd guess you need to increase MAX_LOCKDEP_ENTRIES which is defined i=
n
> kernel/lockdep_internals.h.
>
> BTW, I hit that, too.

Thanks, I upped that to 32768 (16384) but on boot I got another=20
complaint about MAX_LOCKDEP_CHAINS so I changed MAX_LOCKDEP_CHAIN_BITS=20
from 15 to 31 and, well, the kernel build complains about "size of arra=
y=20
'local_chains' is too large" (chain_hlocks as well) and does not build.=
=2E.

Oh well...
-- Fernando
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
