From: Free Ekanayaka <free@64studio.com>
Subject: Should I apply the forcedeth-rt-tweak?
Date: Wed, 20 Jun 2007 13:24:47 +0200
Message-ID: <87vedivpfk.fsf@64studio.com>
References: <1182284627.15228.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from serverina.hacknight.org ([80.68.90.101]:32801 "EHLO
	serverina.hacknight.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbXFTLYv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jun 2007 07:24:51 -0400
Received: from localhost.localdomain (unknown [89.196.9.185])
	by serverina.hacknight.org (Postfix) with ESMTP id 9791B14078
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Jun 2007 12:24:49 +0100 (BST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

I've noticed that since patch-2.6.21.4-rt13 (included) the
forcedeth-rt-tweak patch

http://people.redhat.com/mingo/realtime-preempt/testing/forcedeth-rt-tweak.patch

has been drop from the main rt patch. Does this mean that it should be
no longer necessary?

This little patch is supposed to prevent nVidia ethernet cards to
permanently suck about 3% of the CPU, even though it didn't work for
me. So far I've tried with

2.6.21 + 2.6.21.3 patch + rt9 patch (which includes the nforce patch)

2.6.21 + 2.6.21.4 patch + rt13 patch + nforce patch

Thanks,

Free
