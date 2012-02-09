From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: PCIe GPIO card
Date: Thu, 09 Feb 2012 09:15:10 +0100
Message-ID: <jgvvag$dd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46611 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2BIIPX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Feb 2012 03:15:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1RvPA2-0005bW-PC
	for linux-rt-users@vger.kernel.org; Thu, 09 Feb 2012 09:15:22 +0100
Received: from x23.theoinf.tu-ilmenau.de ([141.24.211.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Feb 2012 09:15:22 +0100
Received: from andre.puschmann by x23.theoinf.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Feb 2012 09:15:22 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

this question seems a little bit off topic to me too but still I believe
there is no better place to ask.

I am looking for an interface card to connect a single pin of an
external device (output 3.3-5V) to a standard PC or notebook. There is
no parallel or serial port available on those modern PCs so I was
looking for some kind of PCI/PCIe/ExpressCard that would do the job. The
application would just poll the GPIO line.

Could anybody suggest anything that works reliably?

Thanks in advance.

-Andre

