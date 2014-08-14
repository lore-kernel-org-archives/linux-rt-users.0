From: Joakim Hernberg <jbh@alchemy.lu>
Subject: [RFC PATCH] fix the broken 'e' command line argument of cyclictest
Date: Thu, 14 Aug 2014 19:21:21 +0200
Message-ID: <20140814192121.29e1baa4@alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:38440 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbaHNRje (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 13:39:34 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4547831..c54972b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1232,7 +1232,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
                        {"help",             no_argument,       NULL, OPT_HELP },
                        {NULL, 0, NULL, 0}
                };
-               int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
+               int c = getopt_long(argc, argv, "a::A::b:Bc:Cd:D:e:Efh:H:i:Il:MnNo:O:p:PmqrRsSt::uUvD:wWT:",
                                    long_options, &option_index);
                if (c == -1)
                        break;
@@ -1280,6 +1280,14 @@ static void process_options (int argc, char *argv[], int max_cpus)
                case 'D':
                case OPT_DURATION:
                        duration = parse_time_string(optarg); break;
+               case 'e':
+               case OPT_LATENCY:
+                       /* power management latency target value */
+                       /* note: default is 0 (zero) */
+                       latency_target_value = atoi(optarg);
+                       if (latency_target_value < 0)
+                               latency_target_value = 0;
+                       break;
                case 'E':
                case OPT_EVENT:
                        enable_events = 1; break;
@@ -1421,13 +1429,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
                /* long only options */
                case OPT_PRIOSPREAD:
                        priospread = 1; break;
-               case OPT_LATENCY:
-                          /* power management latency target value */
-                         /* note: default is 0 (zero) */
-                       latency_target_value = atoi(optarg);
-                       if (latency_target_value < 0)
-                               latency_target_value = 0;
-                       break;
                case OPT_NOTRACE:
                        notrace = 1; break;
                case OPT_POLICY:

--

   Joakim
