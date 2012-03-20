From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 2/3] rt-tests: Silence unused-but-set warning in rt-migrate-test
Date: Tue, 20 Mar 2012 12:05:02 -0700
Message-ID: <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38874 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab2CTTGg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:06:36 -0400
In-Reply-To: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
In-Reply-To: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The variable "end" is set and used, but gcc appears to lose track of it
across the call to lgprint when it gets incorporated into the va_list.
Silence the warning using the unused attribute.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 1963641..d2ac400 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -532,7 +532,7 @@ int main (int argc, char **argv)
 	logdev_switch_set(1);
 
 	for (loop=0; loop < nr_runs; loop++) {
-		unsigned long long end;
+		unsigned long long __attribute__ ((unused)) end;
 
 		now = get_time();
 
-- 
1.7.6.5

