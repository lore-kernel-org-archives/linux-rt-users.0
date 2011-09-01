From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: does nohz still need to be disabled?
Date: Thu, 1 Sep 2011 21:35:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109012134320.2723@ionos>
References: <4E5E1FFD.4070604@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55149 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764Ab1IATfq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 15:35:46 -0400
In-Reply-To: <4E5E1FFD.4070604@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 31 Aug 2011, Maarten Lankhorst wrote:

> Hey all,
> 
> I've been running 3.0.4-rt12 forsome time now without issues and nohz enabled,
> with RCU_BOOST is set to 80 (same level as my emergency serial console),
> is there still a reason why nohz needs to be disabled?

I'm going to reenable it and see whether the various fixes in that
area plugged all the problems. I mainly disabled it to narrow down the
failure combinations.

Thanks,

	tglx
