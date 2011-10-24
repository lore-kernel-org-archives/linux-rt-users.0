From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -rt 4/5] workqueue: hotplug fix
Date: Mon, 24 Oct 2011 11:25:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110241124590.2642@ionos>
References: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com> <1318762607-2261-5-git-send-email-yong.zhang0@gmail.com> <alpine.LFD.2.02.1110190913320.3240@ionos> <20111024022648.GA24581@zhy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56493 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab1JXJZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Oct 2011 05:25:50 -0400
In-Reply-To: <20111024022648.GA24581@zhy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 24 Oct 2011, Yong Zhang wrote:
> On Wed, Oct 19, 2011 at 09:14:28AM +0200, Thomas Gleixner wrote:
> > > -	spin_unlock_irqrestore(&gcwq->lock, flags);
> > 
> > This part of the patch is pretty pointless.
> 
> But CPU_STARTING is called with irq disabled, and it will take
> the lock unconditionally. Thus below warning is triggered:

Aarg, yes.

Thanks,

	tglx
