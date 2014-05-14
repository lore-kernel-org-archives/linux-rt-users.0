From: Daniel Wagner <daniel.wagner@oss.bmw-carit.de>
Subject: Re: [RFC v0] thermal: Protect schedule flag by raw spin
Date: Wed, 14 May 2014 15:36:45 +0200
Message-ID: <5373716D.6030901@oss.bmw-carit.de>
References: <1397485347-2235-1-git-send-email-daniel.wagner@oss.bmw-carit.de> <20140509120902.GB29014@linutronix.de> <53707BA0.60701@oss.bmw-carit.de> <20140514102342.GH15049@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52241 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755383AbaENNgr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 09:36:47 -0400
In-Reply-To: <20140514102342.GH15049@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 05/14/2014 12:23 PM, Sebastian Andrzej Siewior wrote:
>> I overlooked that one. I tried to avoid using thread for this but it
>> looks like there isn't a simpler way. I'll do 'x86/mce' version then.
> 
> as an exercise you could come up with a generic infrastructure which
> fires up one task and can be re-used by mce and the old other users
> which attempt schedule a workqueue in hard irq context. I think a simple
> swait based workqueue like thingy should work.

That is what I am trying to right now. I spend some time to figure out
how all this MCE stuff is supposed to work. I think the current code is
slightly over engineered and could be a lot simpler. Also for mainline.

cheers,
daniel
