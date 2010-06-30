From: Armin Steinhoff <armin@steinhoff.de>
Subject: fast interprocess communication ?
Date: Wed, 30 Jun 2010 13:33:52 +0200
Message-ID: <4C2B2BA0.8080108@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de> <20100514114625.GA6055@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52539 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab0F3Lb0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jun 2010 07:31:26 -0400
In-Reply-To: <20100514114625.GA6055@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello,

what are you using if you need a "real fast"  interprocess communication ?

Is there a way to use the UIO approach for fast synchronous message 
passing ?

--Armin
 
PS:   real-fast means not socket based ...
