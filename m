From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Wed, 20 Jul 2011 17:56:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107201753220.2702@ionos>
References: <alpine.LFD.2.02.1107200153070.2702@ionos> <4E26B721.9020103@steinhoff.de> <CCEC72C697934346AA1E7D01E8DA2EF5@e1705>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Madovsky <infos@madovsky.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55251 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1GTP4N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jul 2011 11:56:13 -0400
In-Reply-To: <CCEC72C697934346AA1E7D01E8DA2EF5@e1705>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Franck,

On Wed, 20 Jul 2011, Madovsky wrote:

> Hi Thomas,
> 
> I just compiled the kernel with the patch on my whole cluster
> of 6 fedora10 and the results are very stable and smooth.

Thanks for the report !

> the only little thing is the cluster software heartbeat / pacemaker
> takes 20% of cpu that 11% before on a dual xeon nocona with
> linux command "top".

That might be related to the new mechanism how we handle softirqs. If
the heartbeat/pacemaker app is using networking a lot then this might
explain it.

Thanks,

	tglx
