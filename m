From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/7] rt-tests devel/v0.96
Date: Wed, 14 Oct 2015 15:32:11 +0200
Message-ID: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35003 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbJNNct (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:32:49 -0400
Received: by wicge5 with SMTP id ge5so237205591wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:32:47 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nothing too exciting here, mostly small clean-up fixes, and build chang=
es
However, not everything was properly posted to the list, so doing so no=
w.

Please continue to send in any changes for the devel/v0.96

Thanks

John

Clark Williams (3):
  Makefile: add target to create OBJDIR before use
  specfile: add signaltest manpage to files section and remove trailing
    whitespace in changelog
  Makefile: have distclean remove .asc file for tarball

John Kacur (3):
  cyclictest: Clean-ups in timerthread before working on it
  Makefile: OBJDIR should be an order-only-prerequisite
  Makefile: Move TARGETS back to a more logical place in the Makefile

Uwe Kleine-K=C3=B6nig (1):
  Fix some trivial typos found by codespell(1)

 Makefile                     | 16 +++++++-------
 rt-tests.spec-in             |  3 ++-
 src/cyclictest/cyclictest.c  | 50 +++++++++++++++++++++++++-----------=
--------
 src/pi_tests/classic_pi.c    |  2 +-
 src/pi_tests/pi_stress.c     |  4 ++--
 src/pi_tests/pip_stress.c    |  2 +-
 src/pi_tests/tst-mutexpi10.c |  2 +-
 7 files changed, 45 insertions(+), 34 deletions(-)

--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
