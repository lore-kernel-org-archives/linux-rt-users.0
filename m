From: David Kastrup <dak@gnu.org>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 15:17:19 +0200
Message-ID: <87d3sglb1c.fsf@lola.goethe.zz>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	<201009141317.13439@zigzag.lvk.cs.msu.su>
	<AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
	<20100914094411.GB10841@pengutronix.de>
	<4C8F67A6.1030409@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51202 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab0INNRd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 09:17:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1OvVO5-0003R1-AI
	for linux-rt-users@vger.kernel.org; Tue, 14 Sep 2010 15:17:29 +0200
Received: from p508edcbc.dip.t-dialin.net ([80.142.220.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 15:17:29 +0200
Received: from dak by p508edcbc.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 15:17:29 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin Steinhoff <armin@steinhoff.de> writes:

>  Robert Schwebel wrote:
>> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>>> anyone can say preempt rt is hard real time?
>> Hard realtime has something to do with how you define "missing the
>> deadline". If somebody cuts the cable of your roboter controller in =
the
>> factory hall, the system misses the deadline. So it is all about
>> probabilities: hard realtime systems have a very, very low probabili=
ty
>> of missing the deadline. However, in real life systems, it is>  0%.
>>
>> So yes, if you talk about real world, it is hard realtime.
>>
> Hm, and what do think about that statement from FSMLabs:
>
> "Linux =E2=80=9CPREEMPT=E2=80=9D real-time is a continuing experiment=
 aimed at audio
> and video playing with unreliable results and a detrimental affect on
> =E2=80=9Centerprise=E2=80=9D performance"

Kernel preemption is a complex thing.  Letting the kernel be a
low-priority realtime task (which is what most "enterprise" solutions d=
o
instead) still preempts the kernel, though only with realtime tasks, no=
t
competing tasks.  Treating the kernel as a black box does not give you
finer-grained control over device drivers etc unless you move the devic=
e
drivers into the realtime realm.

When a failure to service a device in a given time frame will result in
hardware damage, you don't want a system as complex as the whole kernel
involved.  A realtime control system around that is more secure, but a
dedicated, physically separate controller for meeting the hard
constraints might be the safer choice.

--=20
David Kastrup

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
