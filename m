From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.10-rt6
Date: Tue, 30 Apr 2013 09:26:21 +0200
Message-ID: <517F721D.60907@linutronix.de>
References: <20130429201202.GB7979@linutronix.de> <23187402.mkEEi1N7Lp@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23187402.mkEEi1N7Lp@bs8>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/29/2013 10:46 PM, Bernhard Schiffner wrote:
>> Known issues:
>>
>>     - SLxB is broken on PowerPC.
>>     - suspend / resume seems to program program the timer wrong and wait
>>       ages until it continues.
> 
> Yes, it's a annoying problem here too.
> How can I help to solve it?

Are you referring to the PowerPC issue or suspend / resume?

> Bernhard

Sebastian
