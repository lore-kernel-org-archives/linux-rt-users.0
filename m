From: DM <dm.n9107@gmail.com>
Subject: AVR32
Date: Thu, 29 Nov 2007 14:59:30 +0000 (UTC)
Message-ID: <loom.20071129T144956-84@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45523 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbXK2PFV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Nov 2007 10:05:21 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ixkwp-0002KF-6G
	for linux-rt-users@vger.kernel.org; Thu, 29 Nov 2007 15:05:05 +0000
Received: from StaticHost.Syntronic.se ([62.168.138.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Nov 2007 15:05:03 +0000
Received: from dm.n9107 by StaticHost.Syntronic.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Nov 2007 15:05:03 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Are there any plans to include the AVR32 architecture in the RT patch-set?

The AVR32 chips seem to have better performance than ARMv5 and does not impose 
the huge context-switch penalty that ARMv5 has under Linux (due to the need to 
flush all caches when switching mm). And the power requirements are not higher 
than ARM. To me the AVR32 chips look really attractive for low-power embedded 
realtime applications.

Any opinions on this?

/DM
