From: Mark Hounschell <markh@compro.net>
Subject: external gpl kernel module build problem on 2.6.26.8-rt16
Date: Wed, 22 Apr 2009 16:55:37 -0400
Message-ID: <49EF8449.2030000@compro.net>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([216.54.166.4]:4826 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbZDVVJu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 17:09:50 -0400
Received: from [10.15.1.121] (unknown [10.15.1.121])
	by texas.compro.net (Postfix) with ESMTP id 2A67F67048E
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Apr 2009 16:55:38 -0400 (EDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I get the following while trying to build this driver. What does it mean.

 Building modules, stage 2.
 MODPOST 1 modules
WARNING: "__bad_func_type" [/local/work/markh/pci5565-linux/driver/rfm2g.ko]
undefined!

Then obviously the module doesn't load for the same reason.

When I grep the kernel for bad_func_type all I see is

include/linux/rt_lock.h:192:extern int __bad_func_type(void);
include/linux/pickop.h:8:extern int __bad_func_type(void);
include/linux/pickop.h:16:      else __bad_func_type();
                \
include/linux/pickop.h:27:      else __ret = __bad_func_type();

Any help or hints would be appreciated

Thanks in advance
Mark
