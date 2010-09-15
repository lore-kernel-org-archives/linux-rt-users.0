From: David Kastrup <dak@gnu.org>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 17:38:34 +0200
Message-ID: <87k4mnhv9h.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<20100914094411.GB10841@pengutronix.de>
	<4C8F8500.5070002@theptrgroup.com>
	<201009141830.03206@zigzag.lvk.cs.msu.su>
	<4C8F8B79.1010300@theptrgroup.com> <4C8FF52E.1030407@us.ibm.com>
	<4C907A51.1050305@steinhoff.de> <4C90D392.8040808@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43870 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab0IOPio (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 11:38:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Ovu4J-0000qw-RH
	for linux-rt-users@vger.kernel.org; Wed, 15 Sep 2010 17:38:43 +0200
Received: from p508edc0b.dip.t-dialin.net ([80.142.220.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 17:38:43 +0200
Received: from dak by p508edc0b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 17:38:43 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nivedita Singhvi <niv@us.ibm.com> writes:

> At some stage this might have been a pretty good response time.  But
> HW improves by leaps and bounds, and what was considered "fast" or
> "real-time" 25 years ago might be your average vanilla desktop box
> speed of today.

I think you are confused.  "fast" and "realtime" are quite unrelated.
The computers used aboard ancient space craft are abysmally slow
compared to today's desktop computers, but certainly operate in
realtime.

It does not matter whether one system can run circles around the other
one as long as any given circle can't be guaranteed to complete in a
specified amount of time.

Realtime recording systems, for example, can't actually be writing to
high performance file systems unless they can work with preallocation.

Hard realtime is not reasonably possible for a lot of tasks on a general
purpose computing device.  But there is often a lot you can do to help
it give a better shot at things.

-- 
David Kastrup

