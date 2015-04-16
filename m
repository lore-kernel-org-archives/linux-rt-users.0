From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: MAX_LOCKDEP_ENTRIES too low!
Date: Thu, 16 Apr 2015 09:16:29 +0200
Message-ID: <20150416071629.GA26573@linutronix.de>
References: <2490203.uLrt7BxRl5@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt <linux-rt-users@vger.kernel.org>
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42768 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930AbbDPHQc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 03:16:32 -0400
Content-Disposition: inline
In-Reply-To: <2490203.uLrt7BxRl5@bs8>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Bernhard Schiffner | 2013-04-04 12:24:15 [+0200]:

>booting a 3.8.5 patched with 3.8.4-rt2 I get something like this dmesg'ed: 
>[  105.901078] BUG: MAX_LOCKDEP_ENTRIES too low!
>
Can you re-check with someting more recent? Until now all
"MAX_LOCKDEP_ENTRIES" bugs were caused by something else and I haven't
seen this bug.

>Bernhard

Sebastian
