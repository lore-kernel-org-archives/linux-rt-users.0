From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: Re: Page faults with 3.6.11-rt30 but not with 3.6.11-rt25
Date: Mon, 25 Mar 2013 09:24:06 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBE9940@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:62026 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab3CYJed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Mar 2013 05:34:33 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 1AC928400E0
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Mar 2013 10:24:58 +0100 (CET)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas, 

> > Doing a diff between the two kernels, it looks like there was a bit of
> > work on highmem (the stuff that lets you use more than 1 Gig of memory
> > on a 32 bit system). I haven't looked too deep at the bug, but if you
> > apply the following patch, do you get a stable system again?
> >
> > (this is a revert of "highmem: Store ptes right away in the task
> > struct")
> 
> I'm about to release an 3.6 update which fixes that.
The patch 3.6.11-rt31 has fixed it. No issue anymore.

Thanks a lot

Mathias
