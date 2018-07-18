Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:59022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeGRR2q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Jul 2018 13:28:46 -0400
Date: Wed, 18 Jul 2018 18:49:58 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: tty latency and RT
Message-ID: <20180718164958.l3f4ajloobdkp5tz@linutronix.de>
References: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
 <87muv4zpu8.fsf@linutronix.de>
 <87pnzwag3n.fsf@gmail.com>
 <20180711080957.f6txdmzrrrrdm7ig@linutronix.de>
 <87muuvzg99.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muuvzg99.fsf@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-07-13 10:33:54 [+0200], Esben Haabendal wrote:
> But is the lock ordering in tty_buffer_flush() really needed?
> Could we move the
> 
> 	if (ld && ld->ops->flush_buffer)
> 		ld->ops->flush_buffer(tty);
> 
> lines out of the &buf->lock section?  I don't think that any code
> outside of tty_buffer.c should touch the port->buf code, and thus should
> not need to hold the &buf->lock.

You could try this out and see what happens. If you attempt to change
the locking then I suggest you involve upstream. I haven't looked too
closely into it. I remember Peter wasn't too happy about the locking
while the "low latency" shortcut was in and then he removed it.

> /Esben

Sebastian
