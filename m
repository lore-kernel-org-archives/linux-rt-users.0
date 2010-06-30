From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: fast interprocess communication ?
Date: Wed, 30 Jun 2010 13:39:14 +0200
Message-ID: <AANLkTikM-AhROT6GJULLhzNZUVfdFEGt6VoZHC-86wEf@mail.gmail.com>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>
	<1273680443.27703.33.camel@gandalf.stny.rr.com>
	<4BEBB1C8.90606@steinhoff.de>
	<20100513175842.GN6055@pengutronix.de>
	<4BED1937.6080907@steinhoff.de>
	<20100514114625.GA6055@pengutronix.de>
	<4C2B2BA0.8080108@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63115 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab0F3LjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Jun 2010 07:39:18 -0400
Received: by bwz1 with SMTP id 1so315954bwz.19
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jun 2010 04:39:16 -0700 (PDT)
In-Reply-To: <4C2B2BA0.8080108@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Armin,

On Wed, Jun 30, 2010 at 1:33 PM, Armin Steinhoff <armin@steinhoff.de> w=
rote:

> what are you using if you need a "real fast" =A0interprocess communic=
ation ?

Does the posix mqueue's not fit your need ? Have you tried them ? Do
have some kind of numbers about your definition of fast ?

=46or me, the POSIX mqueues seemed to work, though with some initial
trouble which was fixed with a patch to the kernel follow this thread
( http://lkml.org/lkml/2010/4/2/293 ) , this patch is now queued for
mainline inclusion for 2.6.35.

There is also a new test suite to measure message queue perf in the
rt-tests. Its called pmqtest.

regards
/prady

--=20
http://www.prady.in
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
