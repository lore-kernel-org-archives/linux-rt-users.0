From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: CLOCK_REALTIME instead of CLOCK_MONOTONIC for PTP coupled
 RT_PREEMPT systems?
Date: Thu, 24 Jul 2014 07:36:06 +0000
Message-ID: <4c361c69cd0a4b2690542c1a5bc1c2a1@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:30318 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934061AbaGXHgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jul 2014 03:36:45 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 8AC2A8406F3
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Jul 2014 09:36:43 +0200 (CEST)
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 18D631580220
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Jul 2014 09:36:11 +0200 (CEST)
Received: from localhost (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id E65B1601030
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Jul 2014 09:36:10 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

as far as I know is the standard recommendation to use the clock CLOCK_MONOTONIC with e.g. clock_gettime and clock_nanosleep for real time usage.
I have now the requirement that a couple of (x86) PCs are coupled and synchronized using PTP (linuxptp Project).
The idea of this coupling is that all PCs have always the same (absolute) time stamp (with the PTP accuracy). For this I have to use the clock CLOCK_REALTIME
instead of CLOCK_MONOTONIC.
What speaks against using CLOCK_REALTIME for the real time application?
Are there any drawbacks? 
With our application I can ensure that no manually set of the time occurs.

Thanks for any feedback on this question.

Mathias

