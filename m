From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: Achievable latency with USB I/O and RT_PREEMPT?
Date: Thu, 17 Jul 2014 09:48:25 +0200
Message-ID: <53C77FC9.6050508@tu-ilmenau.de>
References: <0dee5b224b444a7c803560f97ad92e8f@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46280 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbaGQHsj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jul 2014 03:48:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1X7gQf-0001zI-Ul
	for linux-rt-users@vger.kernel.org; Thu, 17 Jul 2014 09:48:37 +0200
Received: from vpn237.rz.tu-ilmenau.de ([141.24.172.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jul 2014 09:48:37 +0200
Received: from andre.puschmann by vpn237.rz.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jul 2014 09:48:37 +0200
In-Reply-To: <0dee5b224b444a7c803560f97ad92e8f@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 16.07.2014 08:11, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi all,
> 
> we are running RT_PREEMPT on a standard x86 PC which works really fine.
> Our I/O is so far mainly done via PCI/PCIe boards which works fine as well.
> Now there is an idea to do some special I/O using USB (2.0) microcontrollers (e.g. something like the Arduino Lenorado - AVR ATmega32U4) that are connected to the PC.
> The requirement is that we are able to transfer data (about 40 byte per direction) between the PC and the microcontroller once per millisecond.
> Might this be achievable?

Transferring 40B/s isn't much of a problem for USB. The question is how
sensitive is your application in terms of delay and jitter. You didn't
specify your RT requirements but from what you wrote, i.e. you've been
happy using PCIe boards, it seems that USB may be not the right
solution. I don't have any precise numbers but there have been a number
studies on this matter, e.g. [1]. The conclusion was more or less that
USB is fine for soft real-time application that can tolerate
delay/jitter in the ms order.

Cheers
Andre

[1] http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=4757930



> Is there anybody who has experience with this kind of setup?
> What are the typical latencies/jitter on the microcontroller side that are to be expected?
> What effect on the latency/jitter does it have if multiple microcontrollers are connected via an USB hub to the PC?
> 
> Thank you very much for all help on this questions.
> 
> Best regards
> 
> Mathias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


