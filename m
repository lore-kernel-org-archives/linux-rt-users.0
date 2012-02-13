From: Tim Blechmann <tim@klingt.org>
Subject: possible problem with sem_post
Date: Mon, 13 Feb 2012 14:42:16 +0100
Message-ID: <201202131342.q1DDgG7p001794@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:60090 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab2BMNuF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Feb 2012 08:50:05 -0500
Received: from moka.localnet (85-127-90-215.dynamic.xdsl-line.inode.at [85.127.90.215])
	(authenticated bits=0)
	by klingt.org (8.14.4/8.14.4/Debian-2) with ESMTP id q1DDgG7p001794
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 14:42:16 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi all,

i am experiencing a strange issue with lockups of my application. have multiple 
high-priority real-time threads (as many threads as there are physical cpus) and 
one of the threads seems to lock inside sem_post(). these lookups only occur 
very rarely, after stressing the application (and the semaphore) for a rather 
long time. 

sem_post seems to call sys_futex with FUTEX_WAKE. this issue only occurred 
recently after installing the 3.0 rt kernel (currently 3.0.20-rt35). but haven't 
seen this behavior on any non-rt kernel (currently running another stress-test). 
the machine is a thinkpad t410, x86_64.

if this is a problem of the rt-kernel, is there any way to debug it? or is it in 
general unsafe to call sem_post from real-time threads?

thanks, tim
