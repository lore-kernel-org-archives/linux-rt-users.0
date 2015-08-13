From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-0.93
Date: Thu, 13 Aug 2015 17:20:26 +0100 (IST)
Message-ID: <alpine.LFD.2.20.1508131717490.12209@riemann>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811327-80488839-1439482983=:12209"
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Alexander Stein <alexander.stein@systec-electronic.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34012 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbHMQXI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Aug 2015 12:23:08 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811327-80488839-1439482983=:12209
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Clark Williams and I are pleased to announce a new rt-tests release.
Note we have a new git location, 
make sure you update your repo to one of the following

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

tag: v0.93

Alexander Stein (1):
  cyclictest: Fix long priority help text option

Clark Williams (4):
  makefile: fixed release target
  hwlatdetect: added --watch option to watch output in realtime
  doc: fix VERSION in release-checklist.txt
  Version bump to v0.93

John Kacur (6):
  Fix warning: unused variable ¡c¢
  Fix possible exit on error without releasing mutex
  Create a .gitattribute file to specify what files git-archive should
    ignore
  Add .tar files to .gitignore
  Change VERSION_STRING to VERSION
  Create an rt-tests.tar file using git-archive

Cheers!

John Kacur
---1463811327-80488839-1439482983=:12209--
