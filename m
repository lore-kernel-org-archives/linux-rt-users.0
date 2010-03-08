From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Fix scheduling policy problems for cyclictest
Date: Mon,  8 Mar 2010 02:18:20 +0100
Message-ID: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f225.google.com ([209.85.219.225]:62954 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0CHBSa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 20:18:30 -0500
Received: by ewy25 with SMTP id 25so1185630ewy.39
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 17:18:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These patches fix some problems with the scheduling policies in cyclictest.
In particular, the patches ensure that the expected defaults as specified
in the manpages are correct.

They also ensure that nonsense priorities such as -1 are not possible.

Finally there are some clean-ups, a spelling mistake in the manpage,
spacing in cyclictest.

You can pull these changes from
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
   6214410..1263ebd  rt-tests-dev -> rt-tests-dev

Thanks

John Kacur (4):
  Revert "simplify equal priority logic for cyclictest"
  cyclictest: Use symbolic names for scheduling policy
  cyclictest: Fix spelling mistake in the man page.
  cyclictest: Make the default scheduling policy SCHED_FIFO

 src/cyclictest/cyclictest.8 |    2 +-
 src/cyclictest/cyclictest.c |   23 +++++++----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

