From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.7-rt2 #2] BUG: scheduling while atomic: nfsd and
 irq/30-eth0
Date: Fri, 6 Mar 2015 19:18:12 +0100
Message-ID: <20150306181812.GE10155@linutronix.de>
References: <54F778CF.1090201@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56260 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbbCFSSO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 13:18:14 -0500
Content-Disposition: inline
In-Reply-To: <54F778CF.1090201@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2015-03-04 22:27:43 [+0100]:

>An NFS server occasionally runs into "BUG: scheduling while atomic".
>The message appears about once every 2 to 4 minutes at heavy NFS
>traffic.

https://lkml.org/lkml/2015/2/18/267
This should fix it.

>Thanks,
>Carsten.

Sebastian
