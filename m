From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Wed, 30 Mar 2016 10:16:26 +0200
Message-ID: <56FB8B5A.8@linutronix.de>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
 <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
 <20160329150444.GD13334@linutronix.de>
 <20160329182002.GN28102@jcartwri.amer.corp.natinst.com>
 <20160329231434.GO28102@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37441 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbcC3IQ3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 04:16:29 -0400
In-Reply-To: <20160329231434.GO28102@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/30/2016 01:14 AM, Josh Cartwright wrote:
> On Tue, Mar 29, 2016 at 01:20:02PM -0500, Josh Cartwright wrote:
>> On Tue, Mar 29, 2016 at 05:04:44PM +0200, Sebastian Andrzej Siewior wrote:
> 
> The problem isn't that _all_ instances of the hlist_bl_head will share a
> lockdep class...it's that instances which are INIT_HLIST_BL_HEAD()'d _within
> the same compilation unit_ will share a lockdep class.

no, that is okay. No, that is actually all good. I must have mixed up
the lock inits. Sorry for the confusion. After looking at it again it
is all good.

Please send a proper patch and I add it to the queue.

> 
> 
>   Josh
> 
Sebastian
