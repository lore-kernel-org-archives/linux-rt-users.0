From: Pedro Ribeiro <pedrib@gmail.com>
Subject: future of -rt kernels for realtime audio
Date: Tue, 6 Jul 2010 12:19:31 +0100
Message-ID: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50959 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0GFLTc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 07:19:32 -0400
Received: by ewy23 with SMTP id 23so1821223ewy.19
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jul 2010 04:19:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've been using -rt kernels since 2.6.29 because I do realtime audio
on my laptop.

The audio stability has been steadily improving since, and now I find
that I can use 2.6.34 without the -rt patch and achieve the same
stability as 2.6.33-rt - well, my latency requirements aren't that
high, I just need to maintain 8.9ms completely stable, however before
.34 it would be impossible without the -rt patch.

So out of curiosity, what changed for .34? According to [1], on .33
Raw Spinlock Annotation was introduced in the mainline kernel.
However, as said above, I can't get the same performance than with
.34.

I remember that I read somewhere that the one the biggest problems
with latency requirements was the use of the BKL. Do you think there
will be a significant improvement of latency (in specific cases of
course) with the scheduled removal of BKL for 2.6.36?

Thanks for the help,
Pedro

[1] http://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.html
