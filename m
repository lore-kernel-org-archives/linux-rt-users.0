From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Setting the priority of an IRQ thread
Date: Mon, 15 Jun 2009 22:44:39 +0000 (UTC)
Message-ID: <loom.20090615T222836-377@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:54077 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbZFOWuH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2009 18:50:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MGL07-0000Vu-2M
	for linux-rt-users@vger.kernel.org; Mon, 15 Jun 2009 22:50:03 +0000
Received: from adsl-69-105-99-200.dsl.irvnca.pacbell.net ([69.105.99.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jun 2009 22:50:03 +0000
Received: from mcs by adsl-69-105-99-200.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Jun 2009 22:50:03 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Is there a way for a device driver to set the priority of the IRQ thread that
services interrupts from its hardware? I am writing a device driver for a
digital I/O board with general purpose interrupt capability, and I would like
the application to be able to tell the driver what priority it needs those
interrupts to be given.

Currently it appears that preemp_rt spawns all IRQ threads with priority 50, and
that the only way to change the priority of an IRQ is for an application program
to execute the chrt program, after the IRQ thread has been created. However this
requires that the driver pass back information to the calling program about
which IRQ it is using, so that the program can then call popen to first search
for the PID of the corresponding thread, and then execute chrt to change its
priority. This is possible but messy, and relies on the name of IRQ threads not
changing in the future.

So is there a way for driver code in the kernel to identify the thread of a
given IRQ, and then change its priority?

Thanks,

Martin


