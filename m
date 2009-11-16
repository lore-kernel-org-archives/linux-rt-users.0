From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] pi_stress: clean-ups
Date: Mon, 16 Nov 2009 21:17:40 +0100
Message-ID: <1258402663-13621-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63163 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZKPURk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 15:17:40 -0500
Received: by fxm21 with SMTP id 21so3120684fxm.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 12:17:45 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

pi_stress: clean-ups

These are some style linux kernel style clean-ups for pi_stress.c in advance
of some bug-fixes

You can also pull
c6a804f6c38d5b7f6150123febe0b305ded6f21a
a41df95177ff19bd3185a5673aa598c353a5774d
f517718bb680aa1e93f72c29910bc65c13c82a05
from git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
(branch rt-tests-dev)

John Kacur (3):
  pi_stress: Fix indentation problems with Lindent from the kernel
  pi_stress: Fix trailing-whitespace warnings.
  pi_stress: Convert c-plus style comments to c-style comments

 src/pi_tests/pi_stress.c |  526 ++++++++++++++++++++++++----------------------
 1 files changed, 270 insertions(+), 256 deletions(-)

