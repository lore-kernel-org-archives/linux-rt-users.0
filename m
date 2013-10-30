From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: workqueue realtime priority
Date: Wed, 30 Oct 2013 10:08:46 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1310301002450.19212@ionos.tec.linutronix.de>
References: <9B7F15AA4177464A8FAB5BE79B14288B889580FE@vistrex4.vi.vector.int>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Frederich, Jens" <Jens.Frederich@vector.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59656 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3J3JIu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Oct 2013 05:08:50 -0400
In-Reply-To: <9B7F15AA4177464A8FAB5BE79B14288B889580FE@vistrex4.vi.vector.int>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 15 Oct 2013, Frederich, Jens wrote:

> Hi all,
> 
> is there any way to set the global workqueue priority to real
> time or setup a workqueue with real time priority on Linux RT

The global workqueue is used by the world and some more. So you better
not try to fiddle with that.

> 3.x? I want to setup a kernel worker thread with real time
> priority. What's the best way? Should I better use tasklets?

Tasklets are evil, hey should be renamed to craplets. You'll have the
same problem as with the global workqueue, as tasklets run from
softirq context.

Could you describe what you are trying to do?

Thanks,

	tglx
