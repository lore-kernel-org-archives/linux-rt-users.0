From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.9-rt5
Date: Fri, 23 Aug 2013 09:08:31 +0200
Message-ID: <52170A6F.6040009@linutronix.de>
References: <20130822182127.GA7606@linutronix.de> <5216F81A.4050203@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5216F81A.4050203@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/23/2013 07:50 AM, Fernando Lopez-Lezcano wrote:
> On 08/22/2013 11:21 AM, Sebastian Andrzej Siewior wrote:
>> - hwlat improvements by Steven
>>
>> Known issues:
> ...
> Trying to build I get (in make modules):
> 
> ERROR: "__udivdi3" [drivers/misc/hwlat_detector.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

looks like someone forgot to do do_div() instead / which fails on 32bit
if used on a 64bit dividend.

Will fix later.

> (find attached the final configuration used for building)
> -- Fernando

Sebastian
