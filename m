From: John Sigler <linux.kernel@free.fr>
Subject: BIOS implementors disabling the LAPIC
Date: Tue, 31 Jul 2007 10:06:54 +0200
Message-ID: <46AEED9E.1050904@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:37345 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbXGaIHv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 04:07:51 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I have several systems here where Linux tells me:
Local APIC disabled by BIOS -- you can enable it with "lapic"

As far as I understand, the Local APIC was integrated directly to the 
CPU 12-15 years ago. Why would a BIOS implementor choose to disable it?

(And what does it mean to "disable" the LAPIC?)

Note: the motherboard does not provide an IO-APIC.

I've ask the kernel to re-enable the LAPIC, and was able to use OProfile 
in hardware counter mode, i.e. it seems to work fine.

Regards.
