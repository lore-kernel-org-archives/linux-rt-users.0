From: Louis Gorenfeld <louis.gorenfeld@gmail.com>
Subject: USB audio in 3.4.x rt-kernel vs. 2.6.33
Date: Wed, 28 Nov 2012 12:30:25 -0800
Message-ID: <CAOKANFRQu2PvjBsFqA-W40ys2htWaLf8VYrHXXjucd2KZVE-hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53628 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab2K1Ua1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2012 15:30:27 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so7954968lbb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Nov 2012 12:30:25 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
  I wrote to the Linux Audio User list and didn't get any bites, so I
thought I'd see if anyone here has any advice on this problem I've
been having.

  I've been seeing noticeably worse performance with USB audio devices
using 3.4.5 and 3.4.11 PlanetCCRMA fc17 kernels over my old 2.6.33
PlanetCCRMA kernel, and I was wondering if anyone else has experienced
this. Running seven instances of OP-X under WINE, for example,
consumed about 10% more CPU. I didn't see a similar increase using PCI
audio.

I also whipped out LatencyTOP to take some readings, and I see that
poll_schedule_timeout and pipe_wait seem to be culprits. What is
interesting is that the maximum milliseconds reading is staying
roughly the same for poll_schedule_timeout, yet the percentage
increases as much as 4x or more. I take this to mean that although the
worst-case is about the same between the new kernel and the old, that
on average it's waiting on this function longer. I'm also seeing
consistently more page faults using perf stat.

The realtime priorities, in general, look sane, though there may be
something I'm missing.

What else could I check? I know going from 2.6.33 to 3.4.x is a leap--
have there been any major scheduler changes that might be impacting
performance?

-Louis
