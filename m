From: Boris Egorov <egorov@linux.com>
Subject: [PATCH v2 0/2] rt-migrate-test: few sanity fixes
Date: Tue, 17 Feb 2015 23:43:57 +0600
Message-ID: <cover.1424194150.git.egorov@linux.com>
References: <5476FAF2.1060702@linux.com>
Cc: clark.williams@gmail.com, jkacur@redhat.com, bigeasy@linutronix.de,
	Boris Egorov <egorov@linux.com>
To: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:32785 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbBQRoQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:44:16 -0500
Received: by labhz20 with SMTP id hz20so37077201lab.0
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:44:14 -0800 (PST)
In-Reply-To: <5476FAF2.1060702@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Few fixes for rt-migrate-test, one to fix arithmetic error and others
to properly handle options passed by user.

Difference of this series from the first patch:

* value checks now taking place in parse_options() instead of main()
* added second sanity patch

Boris Egorov (2):
  rt-migrate-test: exit early if nr_runs is non-positive
  rt-migrate-test: use variables instead of macros

 src/rt-migrate-test/rt-migrate-test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.1.4

