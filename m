From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-utils: Fix some checkpatch errors in rt-utils.c
Date: Mon, 5 Oct 2015 16:10:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510051610010.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33591 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbJEOKv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 10:10:51 -0400
Received: by wiclk2 with SMTP id lk2so122543655wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 07:10:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 373987c151acb53f3a8392472c4068b382344e94 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 1 Oct 2015 00:20:42 +0200
Subject: [PATCH] rt-utils: Fix some checkpatch errors in rt-utils.c

Although we have less strict rules than the linux kernel
some of the checkpatch complaints really do make the files better and
easier to read. Fix a few of these.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 462ea3ce394f..ac6878ccacf1 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -49,9 +49,9 @@ char *get_debugfileprefix(void)
 		strcpy(debugfileprefix, "/debug/tracing/");
 		goto out;
 	}
-	
+
 	/* oh well, parse /proc/mounts and see if it's there */
-	if ((fp = fopen("/proc/mounts","r")) == NULL)
+	if ((fp = fopen("/proc/mounts", "r")) == NULL)
 		goto out;
 
 	while (fscanf(fp, "%*s %"
@@ -98,15 +98,15 @@ int mount_debugfs(char *path)
 	}
 	if (!mountpoint)
 		mountpoint = "/sys/kernel/debug";
-	
+
 	sprintf(cmd, "mount -t debugfs debugfs %s", mountpoint);
 	ret = system(cmd);
 	if (ret != 0) {
-		fprintf(stderr, "Error mounting debugfs at %s: %s\n", mountpoint, strerror(errno));
+		fprintf(stderr, "Error mounting debugfs at %s: %s\n",
+			mountpoint, strerror(errno));
 		return -1;
 	}
 	return 0;
-		
 }
 
 static char **tracer_list;
@@ -137,7 +137,7 @@ int get_tracers(char ***list)
 	/* open the tracing file available_tracers */
 	sprintf(buffer, "%savailable_tracers", prefix);
 	if ((fp = fopen(buffer, "r")) == NULL)
-		fatal ("Can't open %s for reading\n", buffer);
+		fatal("Can't open %s for reading\n", buffer);
 
 	/* allocate initial buffer */
 	ptr = tmpbuf = malloc(CHUNKSZ);
@@ -145,7 +145,7 @@ int get_tracers(char ***list)
 		fatal("error allocating initial space for tracer list\n");
 
 	/* read in the list of available tracers */
-	while((ret = fread(buffer, sizeof(char), CHUNKSZ, fp))) {
+	while ((ret = fread(buffer, sizeof(char), CHUNKSZ, fp))) {
 		if ((ptr+ret+1) > (tmpbuf+tmpsz)) {
 			tmpbuf = realloc(tmpbuf, tmpsz + CHUNKSZ);
 			if (tmpbuf == NULL)
@@ -158,12 +158,12 @@ int get_tracers(char ***list)
 	fclose(fp);
 	if (tmpsz == 0)
 		fatal("error reading available tracers\n");
-	
+
 	tracer_buffer = tmpbuf;
 
 	/* get a buffer for the pointers to tracers */
 	if (!(tracer_list = malloc(sizeof(char *))))
-		fatal ("error allocatinging tracer list buffer\n");
+		fatal("error allocatinging tracer list buffer\n");
 
 	/* parse the buffer */
 	ptr = strtok(tmpbuf, " \t\n\r");
@@ -179,8 +179,8 @@ int get_tracers(char ***list)
 }
 
 
-/* 
- * return zero if tracername is not a valid tracer, non-zero if it is 
+/*
+ * return zero if tracername is not a valid tracer, non-zero if it is
  */
 
 int valid_tracer(char *tracername)
@@ -232,9 +232,10 @@ int event_disable_all(void)
 	return setevent("events/enable", "0");
 }
 
-int event_enable(char *event) 
+int event_enable(char *event)
 {
 	char path[MAX_PATH];
+
 	sprintf(path, "events/%s/enable", event);
 	return setevent(path, "1");
 }
@@ -242,10 +243,11 @@ int event_enable(char *event)
 int event_disable(char *event)
 {
 	char path[MAX_PATH];
+
 	sprintf(path, "events/%s/enable", event);
 	return setevent(path, "0");
 }
-	
+
 int check_privs(void)
 {
 	int policy = sched_getscheduler(0);
-- 
2.4.3

