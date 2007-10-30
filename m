From: Gerrit Binnenmars <gerritbinnenmars@orange.nl>
Subject: SMP latency
Date: Tue, 30 Oct 2007 22:02:57 +0100 (CET)
Message-ID: <1886057.1612141193778177393.JavaMail.www@wwinf6102>
Reply-To: gerritbinnenmars@orange.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:41681 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbXJ3VC6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:02:58 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6107.orange.nl (SMTP Server) with ESMTP id 6DE82700010E
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 22:02:57 +0100 (CET)
Received: from wwinf6102 (wwinf6102 [172.22.153.29])
	by mwinf6107.orange.nl (SMTP Server) with ESMTP id 62DD27000083
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 22:02:57 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,
I use cyclictest -t1 -p80 -n -i1000 and have 100% CPU load with a while(1) application. 
Further I use the disknoise script from the rt-tests on an NFS mounted root filesystem.
This gives approx 13000 ethernet interrupts per second.

On a 1.8G Pentm cyclictest shows a max. of 74us
On a 1.5G Core2 SMP kernel cyclictest shows a max. of 222us

Is this normal?
Can it be related to the CONFIG_SCHED_MC that I selected?

Note: I still use 2.6.22.1 and I noticed SMP issues with later version, but upgrading to the
latest kernel would require a lot of testing to be repeated. 

Greetings Gerrit
