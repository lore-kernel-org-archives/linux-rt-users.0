From: Mikhail Lodigin <mishal@softerra.com>
Subject: Guidelines to make RT patch for driver
Date: Fri, 30 Mar 2012 19:22:23 +0300
Message-ID: <4F75DDBF.7050204@softerra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns.softerra.com ([194.187.154.186]:46232 "EHLO
	mail.softerra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753335Ab2C3QW0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Mar 2012 12:22:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.softerra.com (Postfix) with ESMTP id 9A87F2B000D
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Mar 2012 19:22:25 +0300 (EEST)
Received: from mail.softerra.com ([127.0.0.1])
	by localhost (mail.softerra.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKzw62s7sU5j for <linux-rt-users@vger.kernel.org>;
	Fri, 30 Mar 2012 19:22:23 +0300 (EEST)
Received: from [127.0.0.1] (stasadaxesxpsp3.aurora.softerra.llc [192.168.102.20])
	by mail.softerra.com (Postfix) with ESMTPS id C2C1B2B0008
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Mar 2012 19:22:23 +0300 (EEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
on my AT91SAM9263 based board RT patched kernel works great! Thanks to 
all involved. But when ethernet is in use - latency, measured by 
cyclictest, reach 7000000 and beyond.
The ethernet driver for this processor is macb.c. (in 3.2 it is in 
drivers/net/ethernet/cadence, in 3.0 it is in drivers/net/).
I'm ready to find out how to RT-patch it and of course share the 
resulted patch, but I need some starting point for patching drivers 
besides general RT-stuff.  I've noticed that some network drivers 
patched in one way and others a in another. Maybe some discussion 
existed which I didn't found. So any help would be greatly appreciated.
Thanks in advance,
Mikhail

