From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Fri, 13 Sep 2013 14:56:37 +0200
Message-ID: <1379076997.5455.159.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
	 <1377873580.5422.25.camel@marge.simpson.net>
	 <1377926850.6234.22.camel@marge.simpson.net>
	 <1378451338.5434.91.camel@marge.simpson.net>
	 <1378794614.6046.37.camel@marge.simpson.net>
	 <52307814.4020104@colorfullife.com>
	 <1378971628.10696.88.camel@marge.simpson.net>
	 <20130912151547.389673d2@gandalf.local.home>
	 <1379042421.5455.47.camel@marge.simpson.net>
	 <1379047001.5455.100.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3IMM4y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 08:56:54 -0400
In-Reply-To: <1379047001.5455.100.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-09-13 at 06:36 +0200, Mike Galbraith wrote:

> 3.10.10-rt7 scales horridly, is erratic as all hell whether configured
> PREEMPT_FULL/1000 or NOPREEMPT/250.  Ditto pure 3.10.10 NOPREEMPT/250.

Bah.  Forget 3.10 horrid behavior, Manfred's patches went into 3.11, not
3.10.. so 3.10-longterm has stable horrid behavior.

Sometimes stability doesn't sound all that wonderful.

-Mike

