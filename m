From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Fri, 06 Sep 2013 09:08:58 +0200
Message-ID: <1378451338.5434.91.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
	 <1377873580.5422.25.camel@marge.simpson.net>
	 <1377926850.6234.22.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51027 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3IFHJH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Sep 2013 03:09:07 -0400
In-Reply-To: <1377926850.6234.22.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2013-08-31 at 07:27 +0200, Mike Galbraith wrote: 
> The attached proggy (Manfred Spraul) is one reproducer. 

Just in case it's not obvious, the cause is spin_unlock_wait() usage.  

All it takes is one task to start the ball rolling while enough others
exist to react by then taking the lock themselves, and you instantly get
"Woohoo, let's all lock the lock we stare at to see if we need to lock
the lock that we stare at.....".

(loop doesn't look lovely for non-rt either, seems you could stimulate
it if you tried it hard enough)

