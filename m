Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D939C2BA83
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 22:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E12B214AF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 22:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN5tthri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGWeO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:34:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38606 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGWeO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Feb 2020 17:34:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id p10so564020qkk.5
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Feb 2020 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdoU7pasPXP63/msNcfQdRquDE7kUNnewvhxjal6rJA=;
        b=YN5tthriBNscgy3L8PS9oykHuHz4ro/LpamQCddNVjH6OXRpoXn/pdIriq4Eol7meJ
         PK6u3UqiV5fvIyzS/54wTk963tE/N+AoX+6SoMYvIJAHIc30FYk/x6TbroWAPKUc8qS5
         AfCND2wXx8394b+GJghUfeh0VraIsAsGV2b702EtKd9hwWoiidh6hpUeiDfk8IHZ6Mo1
         pI/EKCgLVaM0kbAshTvS+AnB5Gk8pGI21K+I3md0dhlJuWDaby9u++oLNfuNxurvV+NO
         pGNkDsX9/RNrut1nOQRk17p/+33s22hSzWquZ3zXhwObHWcDuuaCq/gtt5abwSzyZkcQ
         jUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LdoU7pasPXP63/msNcfQdRquDE7kUNnewvhxjal6rJA=;
        b=SIpKDbFG5E8ikbvWYVbL6wMjRuM4EEKyncwO7Tvs49ADl8mnTOxnX3dGWNq2sszx5c
         hKQXlpuF+f2V8yXr91DvbmIChKHAMvqMzk8DPiCNkJXubaHdP1FRZAZCvwc+D5KhKM03
         0ALf2dWYPm++ZpotkYCuTE5sL4U8IfHjdze839mVrclwYmzEzpegSMQEhrpniKlvDzs4
         5NWMK9vr9zAlLJwbZXVA6JLuchNXUNYD5guigvGnbybvtHVNx5FaSfH3EmR3Uhp6caK2
         UK9hdscGkM2kTErkjzDLo5iocNP7tfxkchKO3oGk90ST0IZ1CbyT3EYhnnEz0e6rFtSw
         vBng==
X-Gm-Message-State: APjAAAVqcq8QJvYR34NnFWIeLkcG8it2TRh1S0W3oX9jYafZzcB1pojK
        vL3r/hj3Lf7b1vpKeHPKsWTiCn3/Aeo=
X-Google-Smtp-Source: APXvYqzqZHuavc1mCC34feYLoR8glLfDDxflp3cWzCKKQTBzp+mSSR3QlKNh2AYGgFZubJojXNwr4w==
X-Received: by 2002:a37:668b:: with SMTP id a133mr1777qkc.246.1581114853272;
        Fri, 07 Feb 2020 14:34:13 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id z34sm2032747qtd.42.2020.02.07.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 14:34:12 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Use a distinct shm file for each cyclictest instance
Date:   Fri,  7 Feb 2020 17:34:02 -0500
Message-Id: <20200207223402.14143-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When running multiple instances of cyclictest, getting a snapshot from
one will overwrite any snapshots from other instances.

So, create a different shm_file based on the pid for each instance.

For example if you have two instances of cyclictest running
ls /dev/shm/
cyclictest8264  cyclictest8276

You can also use the pid from the file name to know where to send
SIGUSR2

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index beac9a3ce946..2f07426389b3 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -235,6 +235,9 @@ static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
 static int rstat_fd = -1;
+/* strlen("/cyclictest") + digits in max pid len + '\0' */
+#define SHM_BUF_SIZE 19
+static char shm_name[SHM_BUF_SIZE];
 
 /* Latency trick
  * if the file /dev/cpu_dma_latency exists,
@@ -1806,9 +1809,15 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 static int rstat_shm_open(void)
 {
 	int fd;
+	pid_t pid;
+
+	pid = getpid();
+	printf("pid = %d", pid);
+
+	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
 
 	errno = 0;
-	fd = shm_unlink("/cyclictest_shm");
+	fd = shm_unlink(shm_name);
 
 	if ((fd == -1) && (errno != ENOENT)) {
 		fprintf(stderr, "ERROR: shm_unlink %s\n", strerror(errno));
@@ -1816,7 +1825,7 @@ static int rstat_shm_open(void)
 	}
 
 	errno = 9;
-	fd = shm_open("/cyclictest_shm", O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
 	if (fd == -1) {
 		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
 	}
@@ -1894,7 +1903,7 @@ rstat_err2:
 	munmap(mptr, _SC_PAGE_SIZE);
 rstat_err1:
 	close(sfd);
-	shm_unlink("/cyclictest_shm");
+	shm_unlink(shm_name);
 rstat_err:
 	rstat_fd = -1;
 	return;
@@ -2317,7 +2326,7 @@ int main(int argc, char **argv)
 
 	/* Remove running status shared memory file if it exists */
 	if (rstat_fd >= 0)
-		shm_unlink("/cyclictest_shm");
+		shm_unlink(shm_name);
 
 	exit(ret);
 }
-- 
2.20.1

