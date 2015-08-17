From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Mon, 17 Aug 2015 10:40:51 -0400
Message-ID: <20150817104051.6b194df0@grimm.local.home>
References: <548F7E4C.90805@hp.com>
	<1421269898-30591-1-git-send-email-brad.mouring@ni.com>
	<1421269898-30591-2-git-send-email-brad.mouring@ni.com>
	<20150121151352.7e4ef150@gandalf.local.home>
	<12C1B74BDFD05D40B2356A9B12DFA3396C2A5F752B@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:9125 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750975AbbHQOlD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Aug 2015 10:41:03 -0400
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA3396C2A5F752B@KEBMXSPMB01.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 17 Aug 2015 12:41:47 +0200
eg Engleder Gerhard <eg@keba.com> wrote:

> Hello Steven,
> 
> I had the following problem with 3.2.68-rt99:
> <1>[ 1615.388250] BUG: unable to handle kernel NULL pointer dereference at 0000002d
> <1>[ 1615.388261] IP: [<c106d006>] task_blocks_on_rt_mutex+0x126/0x240
> 
> We could reproduce it rather good, 2 times BUG out of 4 tries. Sebastian pointed
> me to the patch below. 8 times no BUG out of 8 tries with the patch now. As Sebastian
> is not available currently, I thought I should let you know. Could you add this patch
> to 3.2.69-rt102?
> 

Yes, I'm the one to apply it to 3.2-rt, as Sebastian is responsible for
the development branch and I'm responsible for the stable tree.

I'm currently at LinuxCon, but I'll see if I can get this done sometime
while I watch the key notes. That's usually when I get the most work
done during a conference ;-)

-- Steve
