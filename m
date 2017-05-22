From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 34/34] read-only struct option array constness
Date: Mon, 22 May 2017 12:04:24 +0300
Message-ID: <20170522090424.16086-5-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
 <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0090.outbound.protection.outlook.com ([104.47.2.90]:12271
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbdEVJEz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 05:04:55 -0400
In-Reply-To: <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/backfire/sendme.c                 | 2 +-
 src/cyclictest/cyclictest.c           | 2 +-
 src/hackbench/hackbench.c             | 2 +-
 src/pi_tests/classic_pi.c             | 2 +-
 src/pi_tests/pi_stress.c              | 2 +-
 src/pmqtest/pmqtest.c                 | 2 +-
 src/ptsematest/ptsematest.c           | 2 +-
 src/rt-migrate-test/rt-migrate-test.c | 2 +-
 src/signaltest/signaltest.c           | 2 +-
 src/sigwaittest/sigwaittest.c         | 2 +-
 src/svsematest/svsematest.c           | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index c1854d9..0da5db9 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -130,7 +130,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"interval", required_argument, NULL, 'i'},
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 369ba04..9c0a966 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1524,7 +1524,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		 * Options for getopt
 		 * Ordered alphabetically by single letter name
 		 */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
 			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
 			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index ba804f5..d7876e2 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -348,7 +348,7 @@ static void process_options (int argc, char *argv[])
 	while( 1 ) {
 		int optind = 0;
 
-		static struct option longopts[] = {
+		static const struct option longopts[] = {
 			{"pipe",      no_argument,	 NULL, 'p'},
 			{"datasize",  required_argument, NULL, 's'},
 			{"loops",     required_argument, NULL, 'l'},
diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 695ee4c..f646d4a 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -68,7 +68,7 @@ int inversions = 1;
 
 int verbose = 0;
 
-struct option options [] = {
+static const struct option options [] = {
 	{ "verbose", no_argument, NULL, 'v' },
 	{ "quiet", no_argument, NULL, 'q' },
 	{ "no-pi", no_argument, NULL, 'n'}, 
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index e29956c..1ca40de 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -145,7 +145,7 @@ int uniprocessor = 0;
 int lockall = 0;
 
 /* command line options */
-struct option options[] = {
+static const struct option options[] = {
 	{"duration", required_argument, NULL, 't'},
 	{"verbose", no_argument, NULL, 'v'},
 	{"quiet", no_argument, NULL, 'q'},
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index e2d5f36..bbb3df5 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -286,7 +286,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"distance", required_argument, NULL, 'd'},
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 26e800b..5630e19 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -203,7 +203,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"distance", required_argument, NULL, 'd'},
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 0a0bb77..a04532f 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -193,7 +193,7 @@ static void parse_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"prio", required_argument, NULL, 'p'},
 			{"run-time", required_argument, NULL, 'r'},
 			{"sleep-time", required_argument, NULL, 's'},
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index dff0c56..5c6b8ec 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -230,7 +230,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"loops", required_argument, NULL, 'l'},
 			{"priority", required_argument, NULL, 'p'},
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 6e6591f..36506d4 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -248,7 +248,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"distance", required_argument, NULL, 'd'},
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index b688831..5a88cd4 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -278,7 +278,7 @@ static void process_options (int argc, char *argv[])
 	for (;;) {
 		int option_index = 0;
 		/** Options for getopt */
-		static struct option long_options[] = {
+		static const struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
 			{"distance", required_argument, NULL, 'd'},
-- 
2.9.3

