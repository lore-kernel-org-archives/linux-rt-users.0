From: "John Kacur" <jkacur@gmail.com>
Subject: [PATCH] Fix the processing of optional options for cyclictest
Date: Fri, 27 Jun 2008 10:10:09 +0200
Message-ID: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Leon Woestenberg" <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:40916 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbYF0IKK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 04:10:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so445438rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jun 2008 01:10:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Problem: when running cyclic test, short options are not parsing
optional arguments correctly when followed by a space.
"-t3" works, but "-t 3" does not.

The following patch fixes the parsing for -a (affinity) and -t
(threads) whether there is a space or no space after the optional
argument, and of course it does the right thing if there is no
argument.

Please apply, because there is the possibility that people are not
testing what they think, especially if tests are automated.

Thanks

Author: John Kacur <jkacur@gmail.com>  2008-06-27 09:47:56
Committer: John Kacur <jkacur@gmail.com>  2008-06-27 09:47:56
Parent: 7a052daef09a5af77815e21fbff84ef580110dee (rt-tests/Makefile:
Import an updated version number into RPM spec file)
Branch: master
Follows: v0.22
Precedes:

    -Fix the processing of options with optional parameters, so that the user
    can write -tNUM or -t NUM and it will work as expected. This was done
    for the -t and -a options
    - Modify the usage messages to correspond with the way the program makes use
    of the options.

------------------------- src/cyclictest/cyclictest.c -------------------------
index d3f545f..bf60f09 100644
@@ -571,7 +571,8 @@ static void display_help(void)
 	printf("cyclictest V %1.2f\n", VERSION_STRING);
 	printf("Usage:\n"
 	       "cyclictest <options>\n\n"
-	       "-a       --affinity        run thread #N on processor #N, if
possible\n"
+	       "-a [NUM] --affinity        run thread #N on processor #N, if
possible\n"
+	       "                           with NUM restricts it to the
first NUM processors\n"
 	       "-a PROC  --affinity=PROC   run all threads on processor #PROC\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when
latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing
(used with -b)\n"
@@ -591,7 +592,9 @@ static void display_help(void)
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-t       --threads         one thread per available processor\n"
-	       "-t NUM   --threads=NUM     number of threads: without -t default=1\n"
+	       "-t [NUM] --threads=NUM     number of threads:\n"
+	       "                           without NUM, threads = max_cpus\n"
+	       "                           without -t default = 1\n"
 	       "-v       --verbose         output values on stdout for statistics\n"
 	       "                           format: n:c:v n=tasknum c=count
v=value in us\n");
 	exit(0);
@@ -661,8 +664,12 @@ static void process_options (int argc, char *argv[])
 			if (optarg != NULL) {
 				affinity = atoi(optarg);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else
+			} else if (optind<argc && atoi(argv[optind])) {
+				affinity = atoi(argv[optind]);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
 				setaffinity = AFFINITY_USEALL;
+			}
 			break;
 		case 'b': tracelimit = atoi(optarg); break;
 		case 'B': tracetype = IRQPREEMPTOFF; break;
@@ -682,6 +689,8 @@ static void process_options (int argc, char *argv[])
 		case 't':
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
+			else if (optind<argc && atoi(argv[optind]))
+				num_threads = atoi(argv[optind]);
 			else
 				num_threads = max_cpus;
 			break;
