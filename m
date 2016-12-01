From: Trevor Woerner <twoerner@gmail.com>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Wed, 30 Nov 2016 21:11:10 -0500
Message-ID: <20161201021110.GA32547@openSUSE-i7.site>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
 <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oussama Ghorbel <ghorbel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35014 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756084AbcLACLO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Nov 2016 21:11:14 -0500
Received: by mail-io0-f194.google.com with SMTP id h133so6984996ioe.2
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Nov 2016 18:11:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri 2016-11-18 @ 11:25:26 AM, Oussama Ghorbel wrote:
> I have written recently a patch that solve the FIQ issue with RT
> Preempt on the 4-core Raspberry Pi board.
> Please see this article for full description on the solution.
> https://www.osadl.org/Single-View.111+M5c03315dc57.0.html

This is excellent, thank you very much!

Previously my raspi2/3 systems were barely able to survive 15 minutes of
either "stress" or "cyclictest", but by simply adding the two kernel cmdline
options I've now been running:

	$ stress --cpu 5 --io 4 --vm 2 --vm-bytes 128M&
	$ cyclictest -p 80 -t5 -n

on a raspi3 for over 10 hours. The latest cyclictest numbers are:

	policy: fifo: loadavg: 11.72 11.87 11.85 9/180 3097           

	T: 0 (  525) P:80 I:1000 C:37527692 Min:     12 Act:   21 Avg:   25 Max:     725
	T: 1 (  526) P:80 I:1500 C:25018460 Min:     13 Act:   20 Avg:   23 Max:     540
	T: 2 (  527) P:80 I:2000 C:18763840 Min:     13 Act:   23 Avg:   24 Max:     914
	T: 3 (  528) P:80 I:2500 C:15011069 Min:     14 Act:   19 Avg:   26 Max:     514
	T: 4 (  529) P:80 I:3000 C:12509225 Min:     14 Act:   19 Avg:   24 Max:     568

This is running the 4.4.35 linux-raspberrypi kernel from
git://github.com/raspberrypi/linux.git with patch-4.4.32-rt43.patch.xz applied
(only one small hunk had to be removed from the Makefile patch in order for it
to apply cleanly).

$ uname -a
Linux raspberrypi3 4.4.35-rt43-yocto-standard #1 SMP PREEMPT RT Tue Nov 29 15:16:27 EST 2016 armv7l armv7l armv7l GNU/Linux

Best regards,
	Trevor
