From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Mon, 7 Mar 2016 18:22:01 +0100
Message-ID: <56DDB8B9.7050606@prevas.dk>
References: <56CDCCE6.5020801@prevas.dk> <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de> <20160226114809.GD8318@linutronix.de>
 <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
 <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
 <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
 <20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
 <56DDAF2A.2000009@linutronix.de>
 <20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Cartwright <joshc@ni.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuba Kicinski <kubakici@wp.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:49680 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbcCGRWH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 12:22:07 -0500
In-Reply-To: <20160307165809.GC28102@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 2016-03-07 17:58, Josh Cartwright wrote:
> On Mon, Mar 07, 2016 at 05:41:14PM +0100, Sebastian Andrzej Siewior wrote:
>> On 02/26/2016 08:00 PM, Josh Cartwright wrote:
>>> On Fri, Feb 26, 2016 at 01:26:27PM -0500, Kuba Kicinski wrote:
>>>> On 26 February 2016 11:52:28 GMT-05:00, Josh Cartwright <joshc@ni.com> wrote:
>>> [..]
>>>>> Instead, the driver needs to implement it's own oneshot-like
>>>>> handling at the device-level: in the registered irq handler, capture
>>>>> triggered interrupt state, squelch/mask, and enqueue the
>>>>> kthread_work.  In the tail-end of the kthread_work, re-enable
>>>>> interrupts at the device level.
>>>> The problem there being IIRC that i2c doesn't provide async writes so
>>>> we can't mask from irq callback. The only option would be
>>>> disable_irq/enable_irq, right?
>>> Ah, yes, that is a problem.  If by disable_irq(), you mean
>>> disable_irq_nosync(), then yes, I think that'd work.
>> I got lost here. Where do we stand here now?
> I understood the comment from Kuba to mean that he would be implementing
> the disable_irq()/enable_irq() idea above to fix all the problems with
> this driver.
>
> Kuba- did I read that right?
>
> Sean- are you still stuck without this?
The oneshot fix, fixed it for me :-)

We have encountered another problem regarding flow control in this driver.
Flowcontrol simply gets deactivated right after it's activated :-(
My college will submit a patch, hopefully in a couple of days...

And the "sc16is7xx_get_mctrl() is invoked under the uart port spinlock" 
problem is still there but with RT patches it's hidden.

/Sean
>
> Thanks for the ping,
>    Josh

