From: Peter Feuerer <peter@piie.net>
Subject: Geode GX1 + RT-Preempt + ACPI
Date: Wed, 11 Apr 2007 11:03:57 +0200
Message-ID: <1176282238.4593.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:60232 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXDKJLW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Apr 2007 05:11:22 -0400
Received: from unknown (HELO [192.168.0.16]) (650477@[89.53.103.182])
          (envelope-sender <peter@piie.net>)
          by smtprelay05.ispgateway.de (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 11 Apr 2007 09:04:00 -0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello everybody,

I'm currently trying to get linux kernel 2.6.21-rc6 with the RT-Preempt
patch running on an embedded board with an Geode GX1 processor.
The kernel itself boots up but cannot initialise ACPI. And seems like
that's why the high resolution timer cannot be started, so the RT-Preemt
functionality does not work correctly.
On a "normal" x86 desktop system (amd athlon) exactly this kernel with
the Preempt patch is running fine.
When I'm booting linux 2.6.18 with RT-Preempt (patch-2.6.18-rt5) without
using acpi it's working on the GX1 system.
Is there a way to run recent linux kernels and recent RT-Preempt patches
without using ACPI? Or should I stick to 2.6.18-rt5?

kind regards,
--peter
