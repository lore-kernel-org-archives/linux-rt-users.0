From: John Sigler <linux.kernel@free.fr>
Subject: [CONFIG_PREEMPT_RT] High frequency periodic timer
Date: Tue, 03 Jul 2007 15:37:12 +0200
Message-ID: <468A5108.5010504@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from postfix2-g20.free.fr ([212.27.60.43]:56015 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841AbXGCOed (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jul 2007 10:34:33 -0400
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 8DF3A15C2ED3
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Jul 2007 14:40:05 +0200 (CEST)
Received: from [10.10.10.208] (ims92-1-88-163-235-69.fbx.proxad.net [88.163.235.69])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 82F846F14E
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Jul 2007 15:37:24 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello everyone,

[ Please include my address in the CC list ]

I have been experimenting with the CONFIG_PREEMPT_RT patch for a few
months. Specifically kernel 2.6.20.7-rt8.

http://rt.wiki.kernel.org/index.php/Main_Page

I've been running into some unexpected problems, so I wanted to ask
those who have some experience with this patch what they thought.

Here's a brief description of my application:

System A periodically sends timestamped packets. These packets travel
over a network, or through a network emulator, and get randomly dropped
or delayed by a random amount of time. These packets reach system B at
some point. System B uses the timestamp to re-send the packets smoothly=
,
as if they had been produced on B, with only a constant time-shift.
Basically, B acts as a "dejittering" router.

I have implemented this with high-resolution timers. Every time the
timer fires, I send one packet. In "parallel", I buffer incoming packet=
s
that arrive from system A.

Consider 1316-byte packets and a 80 Mbit/s stream bit rate.

This means the timer period is 1316*8 / 80 =3D 131.6 =B5s

I've been wondering whether having such a small period (high frequency)
might be a problem / challenge for the real-time kernel (scheduler, IRQ
handler, other component).

The CPUs used are mid-range (i.e. 1.3 GHz P3 and 1.5 GHz Celeron M)=20
single core, and they easily copes with just the receiving part.

But I have seen some odd behavior (random crashes in my program) that
must mean I have made some incorrect assumptions.

What do you all think?

Regards.
