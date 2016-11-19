From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Re: latency induced by hrtimer stacking
Date: Sat, 19 Nov 2016 15:43:41 +0000
Message-ID: <CAK+oA4Wi9n_ZHk2FzetxHK+Dam2BmqQaT6he3E0ew=D6428gEw@mail.gmail.com>
References: <87d1htem52.fsf@kerf.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Gratian Crisan <gratian.crisan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36534 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcKSPnm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 19 Nov 2016 10:43:42 -0500
Received: by mail-yw0-f173.google.com with SMTP id a10so182965681ywa.3
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Nov 2016 07:43:41 -0800 (PST)
In-Reply-To: <87d1htem52.fsf@kerf.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Gratian,

Just created pull request for your timer-stress repo.
Added Makefile and changed type of g_stop from integer to sig_atomic_t
as this variable is accessed from signal handler.

>From 921b6576fc27e4ca09636121bbfa668958cc5bf1 Mon Sep 17 00:00:00 2001
From: Piotr Gregor <piotrgregor@rsyncme.org>
Date: Sat, 19 Nov 2016 15:15:48 +0000
Subject: [PATCH 1/2] Global int to sig_atomic_t
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.1.4"

This is a multi-part message in MIME format.
--------------2.1.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


As it is accessed from signal handler.

Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 timer-stress/ttest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------2.1.4
Content-Type: text/x-patch; name="0001-Global-int-to-sig_atomic_t.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-Global-int-to-sig_atomic_t.patch"

diff --git a/timer-stress/ttest.c b/timer-stress/ttest.c
index c3df67c..bb97645 100644
--- a/timer-stress/ttest.c
+++ b/timer-stress/ttest.c
@@ -18,7 +18,7 @@
 #define CLOCK CLOCK_MONOTONIC

 static int g_nthreads = 1;
-static int g_stop = 0;
+sig_atomic_t g_stop = 0;

 enum {
        OPT_HELP = 1,

--------------2.1.4--



>From 3b5ba7fb5ed1ecb67148c6729c0724349bf9ff65 Mon Sep 17 00:00:00 2001
From: Piotr Gregor <piotrgregor@rsyncme.org>
Date: Sat, 19 Nov 2016 15:16:57 +0000
Subject: [PATCH 2/2] Add Makefile
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.1.4"

This is a multi-part message in MIME format.
--------------2.1.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 timer-stress/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 timer-stress/Makefile


--------------2.1.4
Content-Type: text/x-patch; name="0002-Add-Makefile.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0002-Add-Makefile.patch"

diff --git a/timer-stress/Makefile b/timer-stress/Makefile
new file mode 100644
index 0000000..7fb4ed7
--- /dev/null
+++ b/timer-stress/Makefile
@@ -0,0 +1,7 @@
+prog = ttest
+all: $(prog)
+
+$(prog):
+       $(CC) ttest.c -o $(prog) -lpthread
+clean:
+       rm -rf $(prog)

--------------2.1.4--

cheers,
Piotr
