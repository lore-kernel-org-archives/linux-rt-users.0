From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fedora 20 RT hangs during suspend
Date: Thu, 13 Feb 2014 23:54:10 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402132352020.21991@ionos.tec.linutronix.de>
References: <CABB1KXppwfeZ6ARsRB4qqi--63RpMjQW-fBoWrTbpXyPuEOi4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Don Estabrook <don.estabrook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37304 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaBMWyF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Feb 2014 17:54:05 -0500
In-Reply-To: <CABB1KXppwfeZ6ARsRB4qqi--63RpMjQW-fBoWrTbpXyPuEOi4g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 23 Jan 2014, Don Estabrook wrote:
> > kernel: WARNING: CPU: 2 PID: 858 at kernel/sched/core.c:2428 migrate_disable+0xed/0x100()
> 
> > kernel: WARNING: CPU: 2 PID: 858 at kernel/sched/core.c:2462 migrate_enable+0x17b/0x200()
> 
> > kernel: WARNING: CPU: 3 PID: 865 at kernel/sched/core.c:2428 migrate_disable+0xed/0x100()
> 

These are definitely interesting. Please provide the plain
non-lennartized output from

# dmesg

Thanks,

	tglx
