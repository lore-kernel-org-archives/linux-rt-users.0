From: Matthias Luescher <m.luescher@vtxmail.ch>
Subject: Re: Re: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8 rt patch. Is that normal?
Date: Tue, 10 Mar 2009 17:39:21 +0100
Message-ID: <14400.1236703161@vtxmail.ch>
Reply-To: m.luescher@vtxmail.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>,
	"Brian Hutchinson" <b.hutchman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-02.datacomm.ch ([212.40.2.27]:48761 "EHLO
	smtp-02.datacomm.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbZCJQjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 12:39:24 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Specifically, my laptop is a Dell Latitude D620.

We have tried very hard to achieve real time performance with the 
Dell Latitude D620 (we have tested different kernels, different configurations,
different bios versions, modified the bios settings, called the Dell customer service, ...). 
After all it looks like there is no way to achieve hard real time performance with this
type of device.

We had more luck (sub 100us latency) with the following notebooks:
- Lenovo T61, with dual core processor T8300, 2 GB RAM
- Asus V1SSeries with dual core processor T7500

On both devices we had to disable some power management features.
Please note that pressing some function keys can still result in huge latencies if 
the bios implementation is bad enough.

Desktop PCs usually work without big latencies.

Best regards
Matthias


