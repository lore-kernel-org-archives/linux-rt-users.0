From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Sun, 28 Oct 2007 14:00:10 +0100 (CET)
Message-ID: <8925926.1439951193576410781.JavaMail.www@wwinf6003>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:11660 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbXJ1NAQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Oct 2007 09:00:16 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6006.orange.nl (SMTP Server) with ESMTP id D28667000090
	for <linux-rt-users@vger.kernel.org>; Sun, 28 Oct 2007 14:00:10 +0100 (CET)
Received: from wwinf6003 (wwinf6003 [172.22.155.30])
	by mwinf6006.orange.nl (SMTP Server) with ESMTP id C594F700008D
	for <linux-rt-users@vger.kernel.org>; Sun, 28 Oct 2007 14:00:10 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

Can someone send me a .config file that shows the options needed to get the interrupt off 
timing values in preempt_max_latency, please. I only see a value of 0 in this file
I am using kernel 2.6.22.1 with the corresponding rt patch.

Thanks in advance,

Gerrit Binnenmars 
