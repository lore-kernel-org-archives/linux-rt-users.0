From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Fri, 13 Sep 2013 06:48:21 +0200
Message-ID: <1379047701.5455.101.camel@marge.simpson.net>
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
	 <20130912233339.4c57be5c@gandalf.local.home>
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
Received: from moutng.kundenserver.de ([212.227.126.186]:65517 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab3IMEse (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 00:48:34 -0400
In-Reply-To: <20130912233339.4c57be5c@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-09-12 at 23:33 -0400, Steven Rostedt wrote:

> Can you repost as a patch series please.

Sure, will do.

-Mike

