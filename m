From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Setting priority for irq threads at runtime
Date: Fri, 28 May 2010 17:30:55 +0400
Message-ID: <201005281730.56248@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:56878 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0E1Na7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 May 2010 09:30:59 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I'm looking for a way to automatically set non-default priority for irq 
thread.

As far as I understand, irq thread is being created at request_irq() time, 
which in turn [in my case] happens when applications opens device. So 
solutions with crht are ugly if not impossible.

Is there an already implemented solution or this?

If not, what is better interface to implement:
- kernel parameter that matches irq name to priority,
- udev event at request_irq time,
- something else? 
