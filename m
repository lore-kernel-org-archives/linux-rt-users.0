From: Boris Egorov <egorov@linux.com>
Subject: [PATCH] rt-migrate-test: exit early if nr_runs is non-positive
Date: Thu, 27 Nov 2014 16:20:34 +0600
Message-ID: <5476FAF2.1060702@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Boris Egorov <egorov@linux.com>
To: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33066 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaK0KUk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Nov 2014 05:20:40 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so3888718lab.24
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Nov 2014 02:20:38 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Program will crash if nr_runs is 0 due to dividing by it in
print_results(). Let's exit early instead.

Fixes: http://bugs.debian.org/716237

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/rt-migrate-test/rt-migrate-test.c
b/src/rt-migrate-test/rt-migrate-test.c
index e3c7a09..876a122 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -465,6 +465,11 @@ int main (int argc, char **argv)
  	parse_options(argc, argv);
+	if (nr_runs <= 0) {
+		fprintf(stderr, "Warning, --loops argument is non-positive. Exiting.\n");
+		exit(-1);
+	}
+
 	signal(SIGINT, stop_log);
  	if (argc >= (optind + 1))
-- 
2.1.3

