From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: hwlat.txt: smidetect renamed to hwlatdetect
Date: Fri, 13 May 2016 15:29:21 +0200
Message-ID: <1463146161-9354-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36188 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcEMN3d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 May 2016 09:29:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so3715188wmw.3
        for <linux-rt-users@vger.kernel.org>; Fri, 13 May 2016 06:29:32 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- smidetect was long ago renamed to hwlatdetct, reflect this in hwlat.txt
- Fix a few spelling mistakes, and add a missing option

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlat.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/hwlatdetect/hwlat.txt b/src/hwlatdetect/hwlat.txt
index 11dc067c1ee2..4ac79d0a52e3 100644
--- a/src/hwlatdetect/hwlat.txt
+++ b/src/hwlatdetect/hwlat.txt
@@ -45,7 +45,7 @@ latency_threshold_us	- minimum latency value to be considered (usecs)
 max_sample_us		- maximum SMI latency spike observed (usecs)
 ms_between_samples	- interval between samples (ms)
 ms_per_sample		- sampling time (ms)
-sample_us		- last sample (usecs). Continously updated, may be used
+sample_us		- last sample (usecs). continuously updated, may be used
 			  to plot graphs or to create histograms
 smi_count		- how many latency spikes have been observed
 
@@ -76,7 +76,7 @@ samples during 5ms every 50ms:
 	# cat ms_per_sample
 	5
 
-After a while, data may be verified to atest the existence of SMI induced
+After a while, data may be verified to test the existence of SMI induced
 latencies:
 
 	# cat smi_count
@@ -88,19 +88,19 @@ latencies:
 
 Depending on the latencies observed it is important to better adjust the
 sampling intervals to obtain more accurate measurements. Care must be taken
-to not create a continous sampling situation, that might be perceived by the
+to not create a continuous sampling situation, that might be perceived by the
 kernel as a deadlock.
 
 Python Script
 -------------
 
 A python script is provided in in the kernel scripts directory named
-'smidetect'. This script handles mounting/unmounting the debugfs,
+'hwlatdetect'. This script handles mounting/unmounting the debugfs,
 loading/unloading the hwlat module, setting various parameters
 for the SMI detector and then starting and stopping the detection. The
-smidetect script handles the following arguments:
+hwlatdetect script handles the following arguments:
 
-Usage: smidetect [options]
+Usage: hwlatdetect [options]
 
 Options:
   -h, --help            show this help message and exit
@@ -114,12 +114,13 @@ Options:
   --cleanup             force unload of module and umount of debugfs
   --debug               turn on debugging prints
   --quiet               turn off all screen output
+  --watch               print sample data to stdout as it arrives
 
 
 An example run looks like this:
 
-   $ sudo scripts/smidetect --duration=1m --report=smi.txt
-   smidetect:  test duration 60 seconds
+   $ sudo hwlatdetect --duration=1m --report=smi.txt
+   hwlatdetect:  test duration 60 seconds
       parameters:
               Latency threshold: 100us
 	      Non-sampling gap:  5ms
-- 
2.4.11

