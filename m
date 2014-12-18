From: Camera.Geomatics@leica-geosystems.com
Subject: Latency measurement with oscilloscope, randomly high latency times
Date: Thu, 18 Dec 2014 16:12:34 +0100
Message-ID: <OFDF470C3A.9CBABFAA-ONC1257DB2.005370FE-C1257DB2.00538C5D@leica-geosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu-smtp-delivery-94.mimecast.com ([146.101.78.94]:65121 "EHLO
	eu-smtp-delivery-94.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062AbaLRP2L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 10:28:11 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

We try to achieve hard real time requirements with a 
FPGA->IRQ->ISR->User-Space->Kernel-Module->FPGA loop.

Kernel IRQ handler which toggles IO pins is executed by a Hardware 
interrupt every 200us (FPGA). Priority is set to 99 via chrt ?f ?p99 
pid-module.

Problem:
The test is working (Pins are toggled in time, <50us), but for some reason 

we have randomly (every 2-3sec) big latency times of several ms.

We sometimes get already interrupted in our IRQ handler (which we 
registered with request_irq) before we wakeup our user space task. 

Kernel Version: linux-socfpga 3.10.37-ltsi-rt37
Development board: Altera Cyclone V SoC Development Kit

Do we have to somehow set the priority 99 for the IRQ handler seperately? 
Is there any kind of priority inheritance from user space task to kernel 
module?

Best Regards
Hannes

