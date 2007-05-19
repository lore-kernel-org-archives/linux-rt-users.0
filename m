From: Darren Hart <dvhltc@us.ibm.com>
Subject: maxcpus=1 fails to boot
Date: Sat, 19 May 2007 00:15:52 -0700
Message-ID: <200705190015.53518.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "lkml, " <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40345 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbXESHP5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 May 2007 03:15:57 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When trying to boot with the maxcpus=1 option, the -rt kernel seems to hang 
somewhere in acpi_processor_init().

I tested mainline 2.6.21 and it does boot with maxcpus=1.  2.6.20-rt8, 
2.6.21-rt1, 2, and 4 all hang at:

Calling initcall 0xffffffff817a41df: acpi_processor_init+0x0/0xdf()

when booted with initcall_debug and maxcpus=1.  I traced this only as far as 
the call to acpi_bus_register_driver.  So this seems to have been introduced 
by the -rt patch.  I'm not sure if I should try and see when it was 
introduced (as 2.6.16-rt22 does not fail) or if I should head "down the acpi 
rabbit hole"...

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
