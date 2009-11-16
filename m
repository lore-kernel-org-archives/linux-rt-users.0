From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] rt-tests: Makefile changes
Date: Mon, 16 Nov 2009 19:40:11 +0100
Message-ID: <1258396814-12929-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:34201 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbZKPSkK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 13:40:10 -0500
Received: by fxm21 with SMTP id 21so3019099fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 10:40:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Here are a few simple Makefile changes to the rt-tests suite.
The DEBUG option is especially useful for debugging problems.
For example, it allows you to do:

make DEBUG=0 pi_stress

That will compile a version of pi_stress with -O0 -g

You can also pull
e2a22de97709513b3d541f65280db51e44431a3e
14806d13a0b84220fa17d38bdb32559610434794
7ea849f942f7e5b02d2be9ee50e2584635cd7be4
from git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
(branch rt-tests-dev)

John Kacur (3):
  rt-tests: Makefile - Change FLAGS to CFLAGS
  rt-tests: Makefile - Specify when a target is a PHONY target.
  rt-tests: Makefile - Add a DEBUG option to the Makefile

 Makefile |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

