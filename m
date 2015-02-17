From: Boris Egorov <egorov@linux.com>
Subject: [PATCH v2 1/2] rt-migrate-test: exit early if nr_runs is non-positive
Date: Tue, 17 Feb 2015 23:43:58 +0600
Message-ID: <027f97e3e6fbf00c019fa0d5d5c5b3fc80b5aa73.1424194150.git.egorov@linux.com>
References: <5476FAF2.1060702@linux.com>
 <cover.1424194150.git.egorov@linux.com>
Cc: clark.williams@gmail.com, jkacur@redhat.com, bigeasy@linutronix.de,
	Boris Egorov <egorov@linux.com>
To: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34834 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbBQRoS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:44:18 -0500
Received: by lbjb6 with SMTP id b6so5911954lbj.2
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:44:17 -0800 (PST)
In-Reply-To: <cover.1424194150.git.egorov@linux.com>
In-Reply-To: <cover.1424194150.git.egorov@linux.com>
References: <cover.1424194150.git.egorov@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Program will crash if nr_runs is 0 due to dividing by it in
print_results(). Let's exit early instead.

Fixes: http://bugs.debian.org/716237
Signed-off-by: Boris Egorov <egorov@linux.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index e3c7a09..711d8a4 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -226,7 +226,10 @@ static void parse_options (int argc, char *argv[])
 			break;
 		}
 	}
