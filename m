Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0A21A95D
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521534; cv=none; b=IgwMypK9LmZ3fgfRn668/n+GvlvIHjy4mXekTaG0DZ44wHTD/eGmKFoZah5m/Wqteo2anZHb20DyjL5ERIPRBYF4/BVVwBivukWjVAPuZf/vJKPbuytbpP7p87ekaoyiCrCu67TYYaZlnbLDrT9gGEtll3piR2OimORJaGRyejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521534; c=relaxed/simple;
	bh=VtzAwHvKpnmZMJSkbRonb9WFXMV3/iZMFeTPU4cAWJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlutFpCpGZByQ79Tcwg3ZDoWZYlZgyPZz43ziqnhPkYrWgtEMTDrurty+XpntvRBQGpIEwU8CTrVvnAt7HUvYsUFYi+acxImPreVbcrbbg7orzuZoUvlRXIm60GDaVOP6OkSLb08vdzMqjvaQunnxcG2wpA84+ZgRzRHdfTtX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYYi2fJm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYYi2fJm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b54cead6cso1968151b3a.1
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521532; x=1754126332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGCQuiM/9gunqhKpGFChIp8ztPJzim8lF+vc0kf9qpc=;
        b=FYYi2fJmQK1jwDzkfMm04RCDGpXjshWk9KfP9Mhw/U73CAAKvhaXzEgnoS7Y+p0h0o
         MdXYjYS0MLklOCcBy6HSnyy5Oh7YNUjDMtBEq3vzawtg/0Z9CBOi3UrEUlPcWC2HAjLj
         hAeoFfReCPTRWNnosEvRT17gBg6njVdzxhscYcWIy0CETIKVix/N3/AoBRYh4kc8v2bV
         ZgQzz9Xj5E1WfFoUhneAcW5GVcgsbSJaDQU8NP9/83wxIo2lGgR9X9IVGr0eOGDgLJXj
         fYXOod26rxqJBqQWHo++Tk7CrXEJ3TAvlDOM3DEcJvoT+BBI6bjUCSugbV85xWepVU4V
         9kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521532; x=1754126332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGCQuiM/9gunqhKpGFChIp8ztPJzim8lF+vc0kf9qpc=;
        b=Nm6x7LWq8jAnPh3gitMOZqVHRtHYPuKuEhgjNd2+9He6emcsIbLe/T+DKft1iNjLVI
         hak9/fMeSGa36mW0Tz0eUpTomOnNCmBg4mbh3E5uRhzMr5Huy8pbQU3VnLQZ8FD6O0Pb
         L/K5BalC8mZTaFfGr8dJ4y/Tv/c7BbryAlbwY61WaIPeS5DCT41IuS9q0QD1SkMhoeJA
         ErLo0cSdcZmCT+xQCkhN55eOArXWuBXDY53YA5qpoj/9LvnE6665Yos5LAD0+hFHDbIh
         4OQICn+eWxYHbGFYd6eDX+2yYnPd93X2aFfR8TmRvAFTpfK3xRwJw5kNaRlI3v2Ln3PT
         vVYQ==
X-Gm-Message-State: AOJu0YzZeJBodcCjr8oX/qIsxaL4b0C6HYs+7Kdl4PSup6+1SHMYKArI
	OXXMghYi1VZ403q0fKaezRgEcF1KtWUu/W2z0UWXUbvxX/yuQYuxsjo1
X-Gm-Gg: ASbGncvhR+QO61FqAKhimrrRcG2PVC7bBXZfMJ4KPWs67yLM79zCgl3M6RlqFa9XjKq
	b0SmbrHXLToWKbCZs5HBNrjZUFAjN8GI4IX6NUhRQMTFtFrFU8X0cKYStHX14LzMoC6mgrF67Tb
	LDYihvE4PdL6niiEs9AtWqULa92JVQTKLIfn0DjH1sHZ6hwPEc2yi7EdacyJML01qirVXKJT7B5
	k8KEInN46WYNJQSsf5c8pIyVTnbQd6a+qdJGEgM3rqUQY+MzWzgL/BqJufOi6jt4r+55osqR6+T
	RIG6KmY1YxWjQZLWR9xDx5unPC7DGDVEOiadE+p22/HwXwcas1ToRjhpgkxXd8PNYsZFZte0K1W
	fh3Bbww1VX3oAv7BjkLD9j9P5XcWkFHNBhLfcc1TVh7OOtIN/QC7f
X-Google-Smtp-Source: AGHT+IE8dKuxprhrf75sUzR5lPXZZUNHKPuDgWhe18URU9f7Xh1sEgpYoGMsYTwuakD5upo1DQyEiA==
X-Received: by 2002:a05:6a21:339b:b0:232:1d30:cd90 with SMTP id adf61e73a8af0-23d6ffe4a50mr7298718637.5.1753521531847;
        Sat, 26 Jul 2025 02:18:51 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:51 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 6/8] deadline_test.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:35 +0800
Message-ID: <20250726091837.493915-7-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726091837.493915-1-yphbchou0911@gmail.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error handling for write() to tracefs, cpuset control files, and
system() calls to avoid ignoring errors.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/sched_deadline/deadline_test.c | 37 ++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index ca2da47..a74d514 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -325,6 +325,7 @@ static void ftrace_write(char *buf, const char *fmt, ...)
 {
 	va_list ap;
 	int n;
+	int ret;
 
 	if (mark_fd < 0)
 		return;
@@ -333,7 +334,9 @@ static void ftrace_write(char *buf, const char *fmt, ...)
 	n = my_vsprintf(buf, BUFSIZ, fmt, ap);
 	va_end(ap);
 
-	write(mark_fd, buf, n);
+	ret = write(mark_fd, buf, n);
+	if (ret < 0)
+		perror("ftrace write failed");
 }
 
 /**
@@ -626,6 +629,10 @@ static int mount_cpuset(void)
 	if (fd < 0)
 		return fd;
 	ret = write(fd, "0", 2);
+	if (ret < 0) {
+		close(fd);
+		return ret;
+	}
 	close(fd);
 
 	return 0;
@@ -875,7 +882,19 @@ static void destroy_cpuset(const char *name, int print)
 		sprintf(buf, "%d", pid);
 		if (print)
 			printf("Moving %d out of %s\n", pid, name);
-		write(fd, buf, strlen(buf));
+		ret = write(fd, buf, strlen(buf));
+		if (ret < 0 && errno == ENOSPC) {
+			/*
+			 * If we get ENOSPC, then we have a problem, as it
+			 * means that the cpuset is full, and we cannot move
+			 * the tasks out of it.
+			 */
+			fclose(fp);
+			close(fd);
+			fprintf(stderr, "Failed to move %d out of %s\n", pid, name);
+			perror("write");
+			return;
+		}
 	}
 	fclose(fp);
 	close(fd);
@@ -910,16 +929,21 @@ static void destroy_cpuset(const char *name, int print)
 static void teardown(void)
 {
 	int fd;
+	int ret;
 
 	fd = open_cpuset(CPUSET_PATH, "cpuset.cpu_exclusive");
 	if (fd >= 0) {
-		write(fd, "0", 2);
+		ret = write(fd, "0", 2);
+		if (ret < 0)
+			perror("cpuset.cpu_exclusive");
 		close(fd);
 	}
 
 	fd = open_cpuset(CPUSET_PATH, "cpuset.sched_load_balance");
 	if (fd >= 0) {
-		write(fd, "1", 2);
+		ret = write(fd, "1", 2);
+		if (ret < 0)
+			perror("cpuset.sched_load_balance");
 		close(fd);
 	}
 
@@ -1790,6 +1814,7 @@ int main(int argc, char **argv)
 	int rt_task = 0;
 	int i;
 	int c;
+	int ret;
 
 	cpu_count = sysconf(_SC_NPROCESSORS_CONF);
 	if (cpu_count < 1) {
@@ -2041,7 +2066,9 @@ int main(int argc, char **argv)
 			exit(-1);
 		}
 
-		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
+		ret = system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
+		if (ret < 0)
+			perror("system call failed");
 	}
 
 	pthread_barrier_wait(&barrier);
-- 
2.48.1

