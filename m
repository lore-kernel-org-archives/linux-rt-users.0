From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: appearance of /proc/interrupts ?
Date: Thu, 11 Jan 2007 10:51:28 +0100
Message-ID: <45A608A0.1050407@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2502 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965359AbXAKJvb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 04:51:31 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 606ED2F02B
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 11:45:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 6EAA610B6D
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 10:51:29 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 89701108D3
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 10:51:28 +0100 (CET)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

with Linux 2.6.17-rt3 /proc/interrupts looks as described on

	http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

           CPU0
  0:      11188  XT-PIC         [........N/  0]-level    pit
  1:          8  XT-PIC         [........./  0]-level    i8042
  2:          0  XT-PIC         [........N/  0]-level    cascade
  4:        131  XT-PIC         [........./ 10]-level    serial
 11:         10  XT-PIC         [........./  0]-level    eth0
 14:       4087  XT-PIC         [........./  0]-level    ide0

But when using a Linux 2.6.19.1-rt15 it looks like

           CPU0
  0:      15499   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  4:        161   IO-APIC-edge      serial
  9:          0   IO-APIC-fasteoi   acpi
 12:          3   IO-APIC-edge      i8042
 14:       4082   IO-APIC-edge      ide0
 16:         93   IO-APIC-fasteoi   eth0

which is pretty much the same as a vanilla 2.6.19.

What does it mean? Is RT PREEMPT not working correctly?

Thanks,

Steven
