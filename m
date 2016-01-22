From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: deterministic usage of JIFFIES and how to relocate the clock
Date: Fri, 22 Jan 2016 10:37:08 +0100
Message-ID: <CA+Owze7GnFYrpVMWSuPd=qXj8auf3fL-mPsZNPVMeP=FQtZsPg@mail.gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36523 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcAVJhJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 04:37:09 -0500
Received: by mail-yk0-f173.google.com with SMTP id v14so80070173ykd.3
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2016 01:37:09 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all

Since I'm hardware newbie I just ask in my very own words, how to
relocate the clock. I want to play around with the clock modulator in
GNU/Linux. Is there any interface to relocate it?

What must do a user-space application do to change underlaying cipher?
I don't care about gdb or valgrind issues or trap-points. Might be in
further sense interrupts.

Is possible to have a VM in userspace? Once I have seen different VMs
available in the kernel. Does even have the VM control of
clock-modulator? Do I need some knowledge about ACPI to do so?

Are there some good books about that thematics I could start with?
Since I like math it would be fun to do so.

bests,
Jo=C3=ABl Kr=C3=A4hemann
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
