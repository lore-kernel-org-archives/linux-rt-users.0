From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests v0.92
Date: Tue, 9 Jun 2015 16:11:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1506091552470.10554@riemann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@glx-um.de>,
	Clark Williams <williams@redhat.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33285 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbFIOLa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2015 10:11:30 -0400
Received: by wgez8 with SMTP id z8so14593612wge.0
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Jun 2015 07:11:29 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I'm pleased to announce v0.92 of rt-tests, thanks everyone for the 
patches!

Anna-Maria Gleixner (2):
  cyclictest: Convert the offset of the alignment option to microseconds
  cyclictest: Align measurement threads to the next full second
  cyclictest: Ensure that next wakeup time is never in the past

Daniel Wagner (1):
  pi_stress: Clear affinity for DEADLINE tasks

John Kacur (4):
  Fix minor grammar mistake in the help output
  Allow building with -DHAVE_PARSE_CPUSTRING_ALL
  Add a MAINTAINERS file
  Version bump to v0.92

Michael Olbrich (2):
  Makefile: pi_stress need librttest.a so it should depend on it
  Makefile: cleanup linking to librttest.a

Sebastian Andrzej Siewior (1):
  cyclictest: consider the 4 as the major version

Repo: git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
Branch: master
Tag: v0.92
Tarball: https://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-tests-0.92.tar.xz

Comments, patches and all around snarkiness are generally welcome!
I've opened a v0.92-devel branch.

Cheers!

John
 
