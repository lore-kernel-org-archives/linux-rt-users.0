From: Morten Mossige <morten.mossige@gmail.com>
Subject: Porting intLock()
Date: Thu, 4 Oct 2007 18:58:56 +0000 (UTC)
Message-ID: <loom.20071004T185733-342@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:53441 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759116AbXJDVBM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Oct 2007 17:01:12 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IdXio-0006Ug-66
	for linux-rt-users@vger.kernel.org; Thu, 04 Oct 2007 20:55:02 +0000
Received: from 36.81-167-157.customer.lyse.net ([81.167.157.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Oct 2007 20:55:02 +0000
Received: from morten.mossige by 36.81-167-157.customer.lyse.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Oct 2007 20:55:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi
I'm porting an application from another realtime-os to Linux. This
application makes use of intLock() from time to time. I still need the the
application to be compilable on both Linux and my old os, so I  need a
portabel intLock()
I have tried the following approach:
When a thread needs to do intLock, I boost the thread-pri to max, and when
the thread does intUnLock() I set the thread-pri back. This woorks quite ok,
but by using this approach, I will also lock other threads in other
applications running on Linux.
What I really need is a way of blocking all other threads in my application,
without affecting other applications.
I know I can use mutex'es and semaphores, but that will require a major
rewriting of the application, and that is somthing I dont want to do.
Can someone come up with an idea how this is done best?
Morten
