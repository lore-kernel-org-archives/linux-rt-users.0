From: Juri Lelli <juri.lelli@gmail.com>
Subject: SCHED_DEADLINE hands-on workshop
Date: Wed, 28 May 2014 18:20:51 +0200
Message-ID: <20140528182051.1a21bab86c4d053131e2b4f4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:32835 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaE1QUt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 May 2014 12:20:49 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so11695382wev.17
        for <linux-rt-users@vger.kernel.org>; Wed, 28 May 2014 09:20:48 -0700 (PDT)
Received: from neville (nat-cataldo.sssup.it. [193.205.81.5])
        by mx.google.com with ESMTPSA id s9sm18032486wix.13.2014.05.28.09.20.45
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 May 2014 09:20:46 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Our sincere apologies if you receive multiple copies of this announce]

Dear RT users,

Since March 30th, 2014, the mainline Linux kernel (from version 3.14)
includes the new scheduling class SCHED_DEADLINE, implementing Earliest
Deadline First (EDF).

http://www.juniper-project.org/forum/topics/sched-deadline-in-mainline

Such a scheduling class has been developed within the ReTiS Lab of the
Scuola Superiore Sant'Anna in Pisa and its spin-off company Evidence
Srl.

http://retis.sssup.it/
http://www.evidence.eu.com/

To promote the use and the development of such a new scheduling class,
the ReTiS Lab is organizing a two-days hands-on workshop open to
anybody who is interested in this topic. With the support of the kernel
developers, the tentative program is as follows:

Day 1
  09:00 -- 10:00  Real-time scheduling: basics
  10:00 -- 12:00  SCHED_DEADLINE: presentation, how to use it
  12:00 -- 13:30  lunch break
  13:30 -- 18:00  hands-on session: play with SCHED_DEADLINE and your
                  preferred applications

Day 2
  09:00 -- 10:30  SCHED_DEADLINE: internals
  10:30 -- 12:00  Open problems in Linux kernel scheduling
  12:00 -- 13:30  lunch break
  13:00 -- 18:00  hands-on session: modify, compile, and debug your own
                  kernel

The participation is free of charge. Such an event will take place
shortly, in the end of June.

To select the best dates, which can maximise the participation, the
interested participants are invited to notify their interest to Enrico
Bini (e.bini@sssup.it), not later than May 31st, 2014. Then a doodle
will be launched to find the best suitable dates.

Kind regards,

Juri Lelli
