From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] blk-mq: revert raw locks, post pone notifier to POST_DEAD
Date: Wed, 07 May 2014 10:19:42 +0200
Message-ID: <5369EC9E.1010904@linutronix.de>
References: <1399135344-5349-1-git-send-email-bigeasy@linutronix.de> <1399136587.5158.29.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44459 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbaEGITo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 May 2014 04:19:44 -0400
In-Reply-To: <1399136587.5158.29.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/03/2014 07:03 PM, Mike Galbraith wrote:
>> Mike, I see that lockdep splat (sleeping while atomic) during cpu-hotplug.
>> Don't you see this, too?
> 
> Nope, didn't.

Hmm. blk_mq_hctx_notify(). It does
	spin_lock(&ctx->lock);

Isn't this a sleeping spinlock for you or don't get here at all?

Sebastian
