From: Brian Hutchinson <b.hutchman@gmail.com>
Subject: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8 rt patch. Is that normal?
Date: Tue, 10 Mar 2009 14:06:15 +0000 (UTC)
Message-ID: <loom.20090310T140426-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbZCJOPH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 10:15:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Lh2jX-0005Ss-4y
	for linux-rt-users@vger.kernel.org; Tue, 10 Mar 2009 14:15:03 +0000
Received: from us194px01-pat.tycoelectronics.net ([us194px01-pat.tycoelectronics.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 14:15:03 +0000
Received: from b.hutchman by us194px01-pat.tycoelectronics.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 14:15:03 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We don't have our target hardware yet so I'm trying to get a jump on some of the
newer 2.6 kernel features using a PC.

Compiled a 2.6.26.8 with the 2.6.26.8-rt16 patch applied for a Dell Core Duo
laptop and when I run cyclictest the max latency is up around 800us with the
avg. around 65us.

I'm running the CFS scheduler in real time mode.

Is this the best I'm going to see on a PC?  I've been reading everything I can
get my hands on and it looks like SMI and BIOS may hinder me from getting much
below what I'm seeing.

TIA!

Regards,

Brian 

