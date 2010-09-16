From: David Kastrup <dak@gnu.org>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 07:06:29 +0200
Message-ID: <878w32ffai.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<201009141317.13439@zigzag.lvk.cs.msu.su>
	<AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
	<20100914094411.GB10841@pengutronix.de>
	<4C8F8500.5070002@theptrgroup.com>
	<AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
	<4C90C093.4070607@disco.unimib.it>
	<1284568063.1026.8.camel@sven.oceanvoyage.org>
	<1284598152.23787.15.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44977 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab0IPFGl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 01:06:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Ow6gA-000572-SP
	for linux-rt-users@vger.kernel.org; Thu, 16 Sep 2010 07:06:38 +0200
Received: from p508edda0.dip.t-dialin.net ([80.142.221.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 07:06:38 +0200
Received: from dak by p508edda0.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 07:06:38 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 2010-09-15 at 09:27 -0700, Sven-Thorsten Dietrich wrote:
>
>> Or you can qualify Linux. If Linux is good, then you are done,
>> otherwise, pay for an RTOS or send patches.
>
> I have one of the best RTOS systems around. Pay me big bucks and I might
> give it to you.
>
> I simply call it... DOS ;-)

The purpose of an operating system is to manage system resources.
Including CPU time.  Leaving that task to the user is cheating.

-- 
David Kastrup

