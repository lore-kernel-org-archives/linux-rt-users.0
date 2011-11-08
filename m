From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: HRTimer on PXA processor (Arm v5E)
Date: Tue, 8 Nov 2011 09:44:16 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1111080941260.2694@ionos>
References: <1320402473.22340.YahooMailNeo@web190002.mail.sg3.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Michael A. Purwoadi" <purwoadi@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43620 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1KHIoS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Nov 2011 03:44:18 -0500
In-Reply-To: <1320402473.22340.YahooMailNeo@web190002.mail.sg3.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 4 Nov 2011, Michael A. Purwoadi wrote:
> I would like to know if HR Timer patch is available 

There is no HR timer patch anymore, it's integrated in mainline and
PXA has been converted over to use the generic clockevents
infrastructure in 2007 already.
 
Thanks,

	tglx
