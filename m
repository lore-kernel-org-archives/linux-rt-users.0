From: =?iso-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Random 3 to 4.5 second blocks of RT thread
Date: Mon, 11 Feb 2013 16:54:28 +0100
Message-ID: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Weisser <thomas@bj-ig.de>
To: Realtime Mailinglist <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpgate.bj-ig.de ([194.127.182.6]:48417 "EHLO smtp.bj-ig.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757615Ab3BKQEv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Feb 2013 11:04:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.bj-ig.de (Postfix) with ESMTP id 1C37F4C42F
	for <linux-rt-users@vger.kernel.org>; Mon, 11 Feb 2013 16:54:44 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi.

I've got a problem with a box at a customer, where about once a day (ov=
erall 20 events in 16 days) a realtime thread blocks for 3 to 4.5 secon=
ds. This threads only job is to define a kind of time normal for other =
subsystems. It basically is a loop that wakes up every milli second, in=
crements a generation counter, does some statistics and goes to sleep f=
or another millisecond. It does this quite well - except for these rand=
om multi second sleeps.

My problem: this only happens on a customer machine (actually two diffe=
rent machines at different places, both with very limited access). I tr=
ied to reproduce the bug on two test systems here, which are configured=
 as close to the customer system as possible for me (bios settings, ker=
nel configuration, ... about the same load situation) but I was not abl=
e to get such a block for more then 3 month (I get jitters of less then=
 30 micro seconds what is quite ok for the use case).

The thread is configured to run with SCHED_RR priority 99 via pthread_s=
etschedparam(). There are no other user threads in the system with such=
 a high priority. There is no swap file, memory is locked via mlockall.=
 There are two 24/7 disks configured to never got to suspend, running a=
 md-RAID 1. The thread itself does not do anything time consuming, it d=
oes not do anything that can block. All these systems run on an old Ope=
nSUSE 11.2 with kernel 2.6.33.2-jen97-rt. A maybe relevant kernel optio=
n set, is "processor.max_cstate=3D0". I know it's not just a time warp =
on the system, it actually blocks that long because a connected system =
reports a communication error.

My next try would be to change the board of a customer system by one of=
 the boards of the test systems and hope the error moves to me. As this=
 is a bit expensive and I'm not sure it will really help I would like t=
o ask if someone here can give any hint how to debug such a problem or =
has any idea what in a system blocks for 3 to 4.5 seconds and how I can=
 avoid such blocks.

I know the problem is related to old software and the description is at=
 least a bit vague. My real hope is that someone says: "yes, exactly th=
e same problem I had the day before and I solved it by setting this or =
that option". Hope dies last.

Best regards and thanks in advance
Ralf M=FCller--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
