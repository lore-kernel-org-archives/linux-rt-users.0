From: Andrzej Walczak <awalczak@pit.edu.pl>
Subject: Question: RT patch and CFS patch ?
Date: Wed, 02 Jan 2008 11:52:44 +0100
Message-ID: <1199271164.7684.0.camel@aquarius.pit.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pi.pit.edu.pl ([195.136.249.67]:31975 "HELO pi.pit.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752051AbYABLSD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jan 2008 06:18:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by merlin (Postfix) with ESMTP id B3D80507D
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Jan 2008 11:52:44 +0100 (CET)
Received: from merlin ([127.0.0.1])
	by localhost (merlin.pit.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1BuJzbtpYwk for <linux-rt-users@vger.kernel.org>;
	Wed,  2 Jan 2008 11:52:44 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear All,

I have question:

Will RT kernel have any benefits from improved CFS scheduler ?

or maybe this question in other words

Does it make sense to patch kernel with CFS patch
(http://people.redhat.com/mingo/cfs-scheduler/sched-cfs-v2.6.23.12-v24.1.patch)
or other relevant  before/after patching with RT patch ?

Best regards, Andrzej Walczak
