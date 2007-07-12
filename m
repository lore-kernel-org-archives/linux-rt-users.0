From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [announce] split-up -rt patch-queue, v2.6.22.1-rt2
Date: Thu, 12 Jul 2007 09:33:18 -0700
Message-ID: <1184257998.7974.44.camel@dhcp193.mvista.com>
References: <20070712153717.GA7442@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:46302 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbXGLQme (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 12:42:34 -0400
In-Reply-To: <20070712153717.GA7442@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 17:37 +0200, Ingo Molnar wrote:
> We are pleased to announce something we've been working on for some 
> time: a finegrained, split-up patch queue of the -rt kernel patch. From 
> now on (as of 2.6.22.1-rt2) it will be part of every upstream -rt 
> release and it is available from the -rt download site:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> the -rt patch-queue consists of 374 patches at the moment, which do:
> 
>    698 files changed, 27920 insertions(+), 9603 deletions(-)

Is the number of patches relevant to you ? It seems like some patches
could be boken out more. For instance there could be a per-architecture
patch dedicated to converting spinlocks to raw spinlocks .. I was
looking at preempt-realtime-i386.patch ..

Daniel
