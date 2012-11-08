From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Fri, 9 Nov 2012 00:12:31 +0100
Message-ID: <201211090012.32207.tim01@vlsi.informatik.tu-darmstadt.de>
References: <509C3220.2050601@slac.stanford.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Till Straumann <strauman@slac.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:33568
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab2KHXTq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 18:19:46 -0500
In-Reply-To: <509C3220.2050601@slac.stanford.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Till
> What *is* the recommended mechanism to wake up a thread from
> a hard-isr?
I think its the waitqueue mechanism with the drawbacks you mentioned.

If you only want to wake up *one* usermode thread there is a hack
possible to save the context switch times to the bottom half interrupt thread?

Best regards
Tim
