From: David Kastrup <dak@gnu.org>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 18:20:40 +0200
Message-ID: <877hinhtbb.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<20100914094411.GB10841@pengutronix.de>
	<4C8F8500.5070002@theptrgroup.com>
	<201009141830.03206@zigzag.lvk.cs.msu.su>
	<4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>
	<4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>
	<87k4mnhv9h.fsf@lola.goethe.zz> <4C90EE26.8060003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60481 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402Ab0IOQUz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 12:20:55 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Ovuj5-00011Y-2A
	for linux-rt-users@vger.kernel.org; Wed, 15 Sep 2010 18:20:51 +0200
Received: from p508edc0b.dip.t-dialin.net ([80.142.220.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 18:20:51 +0200
Received: from dak by p508edc0b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 18:20:51 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nivedita Singhvi <niv@us.ibm.com> writes:

> David Kastrup wrote:
>>
>> It does not matter whether one system can run circles around the
>> other one as long as any given circle can't be guaranteed to complete
>> in a specified amount of time.
>
> Right -- but the point was, any HW system can fail, too (very, very
> low statistically speaking, but still not 0%). So no system is
> impervious to all sources of breakage.

A hardware failure means that the system is in violation of the system
design.  A soft realtime failure means that reality is in violation of
the system design.

You can't shift the blame to another department by claiming that a
mistake could have happened there as well.

-- 
David Kastrup

