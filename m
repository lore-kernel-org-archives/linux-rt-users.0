From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: 3.0.23-rt39 BUG: scheduling while atomic, _cpu_down()
Date: Fri, 9 Mar 2012 18:12:43 -0800
Message-ID: <4F5AB89B.9080001@am.sony.com>
References: <4F5AB3B6.2040705@am.sony.com> <1331344992.25686.612.camel@gandalf.stny.rr.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:25353
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab2CJCNL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Mar 2012 21:13:11 -0500
In-Reply-To: <1331344992.25686.612.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/09/12 18:03, Steven Rostedt wrote:
> On Fri, 2012-03-09 at 17:51 -0800, Frank Rowand wrote:
>> Hi Thomas,
>> (and Steve, since you've been mucking about in the hotplug code,)
>>
>> Yet another bit of fallout related to hotplug.
>>
>> This appears to affect 3.0-rt1, 3.0.23-rt29, and 3.2.9-rt17.
>> (Thus probably all 3.x versions, but I haven't been masochistic
>> enough to check.)
>>
>> If not defined CONFIG_PREEMPT_RT_FULL then
> 
> So you're saying that there's a bug with PREEMPT_RT off?

Yes, that is the problem.  But it is due to the RT patches,
not present in mainline.


>>   - hotplug_lock() is a mutex_lock()
>>   - cpu_hotplug_begin() calls hotplug_lock()
>>   - _cpu_down() calls cpu_hotplug_begin() with preemption
>>     disabled (disabled by the migrate_disable())
>>
>> The call to cpu_hotplug_begin() is not in a preempt disabled
>> region until hotplug-use-migrate-disable.patch.  This patch
>> moves the preempt_enable() (aka migrate_enable()) from just
>> before calling cpu_hotplug_begin() to after "out_cancel:".
>>
>> The BUG can be triggered by:
>>
>>    echo 0 > /sys/devices/system/cpu/cpu1/online 
> 
> Note, there's a lot more wrong with hotplug in rt than this. The hotplug
> code really needs a total rewrite for RT to work with it. It probably
> should have a total rewrite in mainline anyway.

Yep, I've been watching all the hotplug related conversations with interest...

-Frank

