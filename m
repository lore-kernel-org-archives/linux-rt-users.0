From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Sat, 19 Mar 2016 09:33:34 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603190933150.3978@nanos>
References: <20160314210058.GE29798@uudg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39303 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbcCSIfE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Mar 2016 04:35:04 -0400
In-Reply-To: <20160314210058.GE29798@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 14 Mar 2016, Luis Claudio R. Goncalves wrote:

> Hello,
> 
> I just started using 4.4.4-rt11 this afternoon and saw the lockdep splat below.
> Is this something new or did I miss a patch floating on the list?

That's new. Looking into it.

