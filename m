From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: maxcpus=1 fails to boot
Date: Sat, 19 May 2007 11:02:30 +0200
Message-ID: <1179565350.12981.107.camel@chaos>
References: <200705190015.53518.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"lkml," <linux-kernel@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:58091 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753643AbXESI4x (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 May 2007 04:56:53 -0400
In-Reply-To: <200705190015.53518.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-05-19 at 00:15 -0700, Darren Hart wrote:
> When trying to boot with the maxcpus=1 option, the -rt kernel seems to hang 
> somewhere in acpi_processor_init().
> 
> I tested mainline 2.6.21 and it does boot with maxcpus=1.  2.6.20-rt8, 
> 2.6.21-rt1, 2, and 4 all hang at:
> 
> Calling initcall 0xffffffff817a41df: acpi_processor_init+0x0/0xdf()
> 
> when booted with initcall_debug and maxcpus=1.  I traced this only as far as 
> the call to acpi_bus_register_driver.  So this seems to have been introduced 
> by the -rt patch.  I'm not sure if I should try and see when it was 
> introduced (as 2.6.16-rt22 does not fail) or if I should head "down the acpi 
> rabbit hole"...

Be careful, when sticking your head into this hole !

I try to nail it down. 

	tglx
