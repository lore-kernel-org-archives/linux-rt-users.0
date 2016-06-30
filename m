From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: deadline_test: Made '-i' work and added help text for it
Date: Thu, 30 Jun 2016 15:57:46 +0200
Message-ID: <1467295066-9358-1-git-send-email-jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36646 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbcF3N6F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 09:58:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so23137784wme.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2016 06:58:04 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Although the interval code was added the 'i' was missing from the getopt
list, and there was no help text for it either.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/deadline_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 196dfecbbb78..2a63c5f91639 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -72,6 +72,7 @@ static void usage(char **argv)
 	       " -b - Bind on the last cpu. (shortcut for -c <lastcpu>)\n"
 	       " -r prio - Add an RT task with given prio to stress system\n"
 	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
+	       " -i interval - The shortest deadline for the tasks\n"
 	       " -p percent - The percent of bandwidth to use (1-90%%)\n"
 	       " -P percent - The percent of runtime for execution completion\n"
 	       "              (Default 100%%)\n"
@@ -1804,7 +1805,7 @@ int main (int argc, char **argv)
 		exit(-1);
 	}
 
-	while ((c = getopt(argc, argv, "+hbr:c:p:P:t:s:")) >= 0) {
+	while ((c = getopt(argc, argv, "+hbr:c:i:p:P:t:s:")) >= 0) {
 		switch (c) {
 		case 'b':
 			all_cpus = 0;
-- 
2.4.11

