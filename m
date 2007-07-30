From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt] temporary WARN_ON removal
Date: Mon, 30 Jul 2007 11:01:30 -0700
Message-ID: <1185818490.2636.49.camel@imap.mvista.com>
References: <1185124961.2573.14.camel@imap.mvista.com>
	 <20070723195548.GA10445@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:32633 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966439AbXG3SML (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 14:12:11 -0400
In-Reply-To: <20070723195548.GA10445@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-23 at 21:55 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > These two WARN_ON calls send my system into a boot hang. They trigger 
> > over and over , some examples below.
> 
> hm, could you try to figure out why they trigger on your box and not on 
> anyone else's box? By disabling them we might be papering over a 
> potential problem.

This patch can be ignored .. I must have mistakenly though I had the
series fully applied .. Turned out to be a bisect issue .. The WARN_ONs
are added before the SYSTEM_BOOTING_SCHEDULER_OK changes.. So naturally
you get these warnings .. The change in my tree resolved this ..

Daniel
