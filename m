From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Using -rt and TuxOnIce at the same time
Date: Tue, 3 Nov 2009 14:40:38 +0000
Message-ID: <74fd948d0911030640m11993d57hd634210307a6c623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59488 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZKCOkf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2009 09:40:35 -0500
Received: by ewy3 with SMTP id 3so2026319ewy.37
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2009 06:40:39 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

I'm interested in using both the -rt patchset and the TuxOnIce for hibernation.
If you're not aware, TuxOnIce is a patch to enable "proper"
hibernation in Linux, IMO much superior to the one provided by the
base kernel.

Anyway, there is a collision in fork.c which is easily solvable, but
apart from that the patches don't collide. However, when I try to
hibernate the computer just hangs up. I brought this up on the
TuxOnIce mailing list and the main developer told me to contact you
first. He also told me that we would like to work with you to solve
this problem, since TOX is also  going to be slowly integrated in the
mainline kernel over time.

The problem is that the computer hangs and I have no way to capture
the output. The only thing I could do was to take some photos of the
screen. The first photo is what appears immediately after the
beggining of the hibernation process. After a few seconds, a rapid
succession of text appears and it captured partially on the second
(crappy) photo of the screen. On the 3rd photo shows how the system
stays indefinitely, and must be restarted by pressing the power button
for 3 secs.

I know the material I provided is a bit crap, but please let me know
how can I help you.

The zipped file containing the photos is here
http://www.2shared.com/file/8900964/61ee7898/rt-crashtar.html

Thanks in advance,
Pedro Ribeiro
