From: Michael Haberler <mail17@mah.priv.at>
Subject: RT thread status display?
Date: Mon, 15 Jul 2013 15:58:48 +0200
Message-ID: <3220ECFD-B7E4-4D2F-82F4-B4BE2C36EE4E@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mah2.mah.priv.at ([86.59.12.251]:33685 "EHLO mah.priv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800Ab3GOOGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jul 2013 10:06:45 -0400
Received: from macbook.stiwoll.mah.priv.at (macbook.stiwoll.mah.priv.at [193.228.47.195])
	by mah.priv.at (Postfix) with ESMTPSA id B17F52C00A4
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2013 15:58:48 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

we have an application with several RT threads within a single process - those show up nicely in say 'top -H'

how can a correlate a Posix thread id to the PID column in top? If nothing else, we can do it via a log entry

Is there a way to pass a string which reappears in top/ps output (like a modifed argv or the like)? (threads are named in our application)


what I'm looking for is roughly the equivalent of this http://www.xenomai.org/index.php//proc/xenomai/stat for rt-preempt

(in Xenomai the thread names are shown, so no need to correlate thread id's)

any better suggestions than ps/top?


thanks in advance

- Michael




