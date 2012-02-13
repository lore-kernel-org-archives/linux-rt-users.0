From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: PCIe GPIO card
Date: Mon, 13 Feb 2012 09:51:05 +0100
Message-ID: <4F38CEF9.70308@tu-ilmenau.de>
References: <jgvvag$dd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34458 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab2BMIvT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Feb 2012 03:51:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Rwrcx-0001OV-OP
	for linux-rt-users@vger.kernel.org; Mon, 13 Feb 2012 09:51:15 +0100
Received: from x23.theoinf.tu-ilmenau.de ([141.24.211.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 09:51:15 +0100
Received: from andre.puschmann by x23.theoinf.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2012 09:51:15 +0100
In-Reply-To: <jgvvag$dd$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/09/2012 09:15 AM, Andre Puschmann wrote:
> I am looking for an interface card to connect a single pin of an
> external device (output 3.3-5V) to a standard PC or notebook. There is
> no parallel or serial port available on those modern PCs so I was
> looking for some kind of PCI/PCIe/ExpressCard that would do the job. The
> application would just poll the GPIO line.

I can't believe nobody's got something like this working :-) If that's
really the case I would just get myself a ExpressCard to parallel port
adapter and run some (latency) tests.

-Andre

