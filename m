From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: opprofile support
Date: Fri, 13 Apr 2012 10:23:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204131022420.2542@ionos>
References: <CAPB=Z-pcKwSFNk1R6X6Yip_ARod0MRnmFXQM=fz8MAkz9Ls_iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40083 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab2DMIXo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 04:23:44 -0400
In-Reply-To: <CAPB=Z-pcKwSFNk1R6X6Yip_ARod0MRnmFXQM=fz8MAkz9Ls_iw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 10 Apr 2012, Raz wrote:

> Can anyone explain why oprofile is disabled in preempt rt ?

Some locking issue IIRC

> What is need to be done to get profiling support ?

Enable it and enable the usual debug options and then watch what
explodes and fix it :)
