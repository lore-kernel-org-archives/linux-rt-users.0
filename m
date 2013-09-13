From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Fri, 13 Sep 2013 06:36:41 +0200
Message-ID: <1379047001.5455.100.camel@marge.simpson.net>
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
Received: from moutng.kundenserver.de ([212.227.17.9]:57435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3IMEgz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 00:36:55 -0400
In-Reply-To: <1379042421.5455.47.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

P.S.

While I have your attention, let me provide some related info.

for i in 1 2 3 4 5; do ipcscale/sem-waitzero -t 30 -c 1,8,16,24,32,40,48,56,64 -i 1 -m 0 -d 2 -f 2>&1|tee -a log-blah; done

3.0-rt (SLE11-SP3-RT with sem backports) scales perfectly to 64 cores on
my 8 node (alas, 1 memory node) DL980 rt test box, whether configured
PREEMPT_RT/1000 or NOPREEMPT/250.  (livelock bug is irrelevant)

3.10.10-rt7 scales horridly, is erratic as all hell whether configured
PREEMPT_FULL/1000 or NOPREEMPT/250.  Ditto pure 3.10.10 NOPREEMPT/250.

(3.10-rt kernel is where I started, Manfred asked me to try something, I
happened to have this kernel on box to take a peek at future workhorse) 

Master NOPREEMPT/250 as of yesterday with same config taken from tests
above scales perfectly.

So, that _alleges_ that 3.10.10, a.k.a next longterm stable kernel, is
sick, missing something.  It appears something went wonky post 3.0, but
that's only possibly interesting for finding the origin for -stable iff
the thing turns out to be _really_ stable/bisectable in the first place,
which I'm going to find out, hopefully today.  It _looks_ stable.

Would be nice if someone would confirm/deny bad big box behavior, but...

-Mike

