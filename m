From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Mon, 15 Oct 2007 22:33:46 +0400
Message-ID: <4713B28A.2060004@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:11050 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933840AbXJOSde (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 14:33:34 -0400
In-Reply-To: <4713A616.3090103@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello, I wrote:

>>@@ -797,6 +796,53 @@ void __init clocksource_init(void)
>> 	       clock->name, clock->mult, clock->shift);
>> }

>>+static int decrementer_set_next_event(unsigned long evt,
>>+				      struct clock_event_device *dev)
>>+{
>>+	set_dec(evt);

>     I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
> not 0 (on classic CPUs).  With you removing of the code that compensated for 
> the errors, they will accumulate.  And no, this wouldn't be enough anyway, 
> since on 40x and Book E you'll need to set it for evt anyway, since the 
> interrupt happens at 0 count...

    What that means is that the off-by-one-clock drift is introduced for 
classic CPUs (not 40x or Book E which interrupt at 0).  And this has dealt 
with months ago in the clockevent driver in the -rt patch.  So much for my 
efforts...

>     NAK the patch.

    It's too late for NAKs -- I should've given these patches more attention 
(yet I was in hospital for 1.5 months).

WBR, Sergei
