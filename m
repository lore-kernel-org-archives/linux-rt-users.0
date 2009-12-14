From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] cleanup building the new tests
Date: Mon, 14 Dec 2009 22:38:59 +0100
Message-ID: <1260826742-15296-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50074 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZLNVjR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 16:39:17 -0500
Received: by fxm21 with SMTP id 21so3800658fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 13:39:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark - please pull the following patches from
git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
branch: rt-tests-dev

Note that the previous set is also merged in the rt-tests-dev branch, so you
can pull everything from there.

John Kacur (3):
  The PHONY target for install is incorrectly specified as "all"
  Remove making of backfire kernel module from the rt-tests makefile
    The kernel module can be made by cding to src/backfire and doing
    make modules sudo make modules_install
  Add a .gitignore file in the backfire directory for generated files.

 Makefile                |    6 ++----
 src/backfire/.gitignore |    5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)
 create mode 100644 src/backfire/.gitignore

