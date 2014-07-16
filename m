From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Achievable latency with USB I/O and RT_PREEMPT?
Date: Wed, 16 Jul 2014 06:11:07 +0000
Message-ID: <0dee5b224b444a7c803560f97ad92e8f@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:30221 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbaGPGWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jul 2014 02:22:02 -0400
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id CD208C0388
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Jul 2014 08:12:10 +0200 (CEST)
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta24.fe.bosch.de (Postfix) with ESMTP id D2A11D80204
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Jul 2014 08:11:36 +0200 (CEST)
Received: from localhost (vsgw21.fe.internet.bosch.com [10.4.98.19])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id B576B600AED
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Jul 2014 08:11:36 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

we are running RT_PREEMPT on a standard x86 PC which works really fine.
Our I/O is so far mainly done via PCI/PCIe boards which works fine as well.
Now there is an idea to do some special I/O using USB (2.0) microcontrollers (e.g. something like the Arduino Lenorado - AVR ATmega32U4) that are connected to the PC.
The requirement is that we are able to transfer data (about 40 byte per direction) between the PC and the microcontroller once per millisecond.
Might this be achievable?
Is there anybody who has experience with this kind of setup?
What are the typical latencies/jitter on the microcontroller side that are to be expected?
What effect on the latency/jitter does it have if multiple microcontrollers are connected via an USB hub to the PC?

Thank you very much for all help on this questions.

Best regards

Mathias
