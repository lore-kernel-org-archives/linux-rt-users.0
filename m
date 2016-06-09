From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Lockdep chain_key key collision warning on 4.6.1-rt3
Date: Thu, 9 Jun 2016 15:08:11 +0200
Message-ID: <20160609130811.GE6305@linutronix.de>
References: <20160603163711.GC27058@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52560 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbcFINI2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jun 2016 09:08:28 -0400
Content-Disposition: inline
In-Reply-To: <20160603163711.GC27058@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2016-06-03 13:37:11 [-0300]:

>Hello,
Hello,

>Right after boot, on both 4.6.1-rt2 and 4.6.1-rt3, I saw the lockdep warning
>listed below. What caught my attention are those two lines:
>
>   DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))
>
>   modprobe/1050: Hash chain already cached but the contents don't match!
>
>Anybody else saw something similar?

Nope. I can't even tell what it tries to say.

Sebastian
