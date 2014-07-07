From: Jan de Kruyf <jan.de.kruyf@gmail.com>
Subject: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Mon, 7 Jul 2014 10:48:30 +0200
Message-ID: <CAA85NCgJPczdQ0mhH3n6cwuZ0kTT-ZFayn3RAjpGAJOB3AM47g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:49009 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaGGIsb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Jul 2014 04:48:31 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so3396420qcz.37
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Jul 2014 01:48:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hope I do not kick in an open door, but

Linux JanDell 3.2.0-0.bpo.3-rt-686-pae #1 SMP PREEMPT RT Thu Aug 23
09:55:27 UTC 2012 i686 GNU/Linux
and
Linux jan 3.2.0-4-rt-amd64 #1 SMP PREEMPT RT Debian 3.2.57-3+deb7u2
x86_64 GNU/Linux

does not give the same problem that I experienced with XFS.
So there is a hickup between version 3.2-rt and 3.10-rt I would say.

cheers,

j.
