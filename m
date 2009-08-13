From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH RT 8/6] [ARM, WATCHDOG] davinci: include mach/timex.h in davinci_wdt.c
Date: Thu, 13 Aug 2009 08:06:09 -0700
Message-ID: <87zla3hhy6.fsf@deeprootsystems.com>
References: <20090807203939.GA19374@pengutronix.de>
	<1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1249810600-21946-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20090809094306.GA26591@n2100.arm.linux.org.uk>
	<87iqgvk43c.fsf@deeprootsystems.com>
	<20090810172637.GC27147@n2100.arm.linux.org.uk>
	<87zla7fkio.fsf@deeprootsystems.com>
	<20090810220234.GD27147@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754746AbZHMPGN@vger.kernel.org>
In-Reply-To: <20090810220234.GD27147@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 10 Aug 2009 23\:02\:34 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Aug 10, 2009 at 02:04:31PM -0700, Kevin Hilman wrote:
>> @@ -86,6 +88,9 @@ static void wdt_enable(void)
>>  {
>>  	u32 tgcr;
>>  	u32 timer_margin;
>> +	u32 wdt_freq;
>> +
>> +	wdt_freq = clk_get_rate(wdt_clk);
>
> Much better - and only a minor nit which doesn't deserve a repost -
> wdt_freq should probably match the return type of clk_get_rate.  IOW
> unsigned long.

Wim,

If you're OK with this, can you queue this one for 2.6.32?

Thanks,

Kevin
