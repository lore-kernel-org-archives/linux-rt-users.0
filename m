From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Achievable latency with USB I/O and RT_PREEMPT?
Date: Fri, 18 Jul 2014 06:30:14 +0000
Message-ID: <6987d9cbc86342bcb3478d79c3aaa4c9@FE-MBX1012.de.bosch.com>
References: <0dee5b224b444a7c803560f97ad92e8f@FE-MBX1012.de.bosch.com>
 <53C77FC9.6050508@tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:36315 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbaGRGbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jul 2014 02:31:06 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id A592E84037A
	for <linux-rt-users@vger.kernel.org>; Fri, 18 Jul 2014 08:31:04 +0200 (CEST)
In-Reply-To: <53C77FC9.6050508@tu-ilmenau.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Transferring 40B/s isn't much of a problem for USB. The question is how
> sensitive is your application in terms of delay and jitter. You didn't
> specify your RT requirements but from what you wrote, i.e. you've been
> happy using PCIe boards, it seems that USB may be not the right
> solution. I don't have any precise numbers but there have been a number
> studies on this matter, e.g. [1]. The conclusion was more or less that
> USB is fine for soft real-time application that can tolerate
> delay/jitter in the ms order.
Thanks for the information. It seems as if the 1ms cycle requirement that has to be fulfilled is not really realistic...
It seems to be better to stay with something non-USB.

Regards

Mathias
