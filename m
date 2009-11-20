From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: help needed, 2.6.31.6-rt19 hang with network user app
Date: Sat, 21 Nov 2009 00:44:09 +0300
Message-ID: <200911210044.09962@blacky.localdomain>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:52015 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbZKTVyb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Nov 2009 16:54:31 -0500
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hang details:
> 1 The UI freezes. No keyboard or mouse. Graphics OK but screen freeze.
> 2 Host B reports no data from Host A. When Host B is terminated and
> unplugged from network, the network card on Host A still blinks as if it
> is sending or receiving data. Unplugging Host A stops the blinking.
> Plugging A back in starts the blinking. I have waited up to 20 minutes
> or more and card still blinking.

This looks like something in kernel crashed.

Does host A have a serial port? If yes, connect that to another host using 
a null-modem cable, boot host A with serial console (boot arg 
console=ttyS0,15200), and use that to extract kernel crash message. Then 
post that to this list.
