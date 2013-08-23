From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Fri, 23 Aug 2013 10:18:08 -0700
Message-ID: <52179950.6010601@localhost>
References: <20130822182127.GA7606@linutronix.de> <5216F81A.4050203@localhost> <52170A6F.6040009@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52170A6F.6040009@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/23/2013 12:08 AM, Sebastian Andrzej Siewior wrote:
> On 08/23/2013 07:50 AM, Fernando Lopez-Lezcano wrote:
>> On 08/22/2013 11:21 AM, Sebastian Andrzej Siewior wrote:
>>> - hwlat improvements by Steven
>>>
>>> Known issues:
>> ...
>> Trying to build I get (in make modules):
>>
>> ERROR: "__udivdi3" [drivers/misc/hwlat_detector.ko] undefined!
>> make[1]: *** [__modpost] Error 1
>> make: *** [modules] Error 2
>
> looks like someone forgot to do do_div() instead / which fails on 32bit
> if used on a 64bit dividend.
>
> Will fix later.

Please post a patch when/if you have it so I can retry the build...
Thanks for taking a look at this!
-- Fernando
