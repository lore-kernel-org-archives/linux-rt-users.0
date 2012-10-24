From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 20:38:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210242037440.2756@ionos>
References: <alpine.LFD.2.02.1210202133470.2719@ionos> <op.wmk8f6m96426ze@localhost.localdomain> <alpine.LFD.2.02.1210222029480.2756@ionos> <op.wmnlvqm76426ze@localhost.localdomain> <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain> <alpine.LFD.2.02.1210241156380.2756@ionos> <op.wmoiyqew6426ze@localhost.localdomain> <alpine.LFD.2.02.1210241621060.2756@ionos> <op.wmo0g1qc6426ze@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52669 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933394Ab2JXSij (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 14:38:39 -0400
In-Reply-To: <op.wmo0g1qc6426ze@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
> On Wed, 24 Oct 2012 16:27:54 +0200, Thomas Gleixner <tglx@linutronix.de>
> wrote:
> I can ofcourse always compile with net in, but what I needed was dmseg right?
> Actually I have an old pic of this error.
> http://www.paradoxuncreated.com/tmp/rterror.jpg

So the ata controller fails. Which driver is in use?

Thanks,

	tglx
