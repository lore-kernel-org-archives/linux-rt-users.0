Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C218277CB6
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327768; cv=none; b=qecnS3YdZmf88+eCz3gPwdq33/dLYDWj+49A/UMTcOUMOebTWYK9HO15xCcLyrrtCJaef8tWyNDdLxMUix58yyE4xqdvl6XO8N46ZN5xL0CX/ZiCuPMQ67qnMK09CNUXC9PKynIds7hj8WHmQ/rmX1vhcZtafLet7f+Ckvlvu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327768; c=relaxed/simple;
	bh=ylCvSlC1Xdvp68TbF+gcdY6lwOvyszunuDUQBen9MgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az2JX//51dpTiEod9ZIwquHAMMLvZKOicU3/uOzYkHYO+/LwMT49r7qz9E1LdSQIjjzFFOYvxEWts+kUf5r0cRIituIMEzaHPZVlBxkqpTqQoe9os8M6Pp3gvPeamXmfor86NonhE5c5Eu8lDE3v/vEECTkM5CtVDL5oP4KUIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELSCNPF0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELSCNPF0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23694cec0feso27401975ad.2
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327766; x=1752932566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpCs3tte1yycaOcCuMYPRuF/lb1jRf0kvUqRI6BHb8g=;
        b=ELSCNPF0Il7XDSZg6bd19du0XHEF0gi6gbgok+TUm4QWAqLZu6V4JDfNPEA6iEJ6Pv
         rcWb862o6eLvL+FIZ/+/wcqhAJ6olUgzHUq8KKJdgyffLAK1MQflKuXmLItAG07qknvE
         FLQp4HMxJE7zEFTH8cdIIejCaajHWKdXLOb9iIKkGvVyshmwqGJ7zuAAznZSFmlx2xMP
         RZ7+MbA3u4ChcBEfRPjvH4P1J6GFR7DspdnZ5+AL4kRl1z/o0GQ1a/xQyIcIwPS7TxyU
         IHGS+GQmdT/0oAuHXgTy4JsoL1hmWCz6GZL9z5UT1opo/t2auNICLtEg5WeqcTuFqHjt
         a9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327766; x=1752932566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpCs3tte1yycaOcCuMYPRuF/lb1jRf0kvUqRI6BHb8g=;
        b=M2Fx5stHV6bBKfUTOReTNswDNybPvi/ZdRtJ9ktU3p38cunOBNl+oc1xe5x/ySzs9G
         d/vCJQLSmqXILMXUPKVk7HMPCaK29zG3m+F1IIaO1LIWsM3Z9h1Yf+OHojoLxE9KYA2k
         NQR1PeR6ZZnplMscbLShTmrr70rH7l3u3twZ99WSeNgBbK3WPf2Z6dM/0LBHEJf6My9C
         WTiBqMaXv+cnz6UyaknTQPZ78U7A7m18tmfHNYc1ueiqL26v50+j5owZmqWGhPTo2vt9
         6ZyVzue+gj7KcaRzy3AMHbSetPm3MSnaxLovC805eKt//X6ZknU6U6sm4uc5tOsfKA03
         EYOg==
X-Gm-Message-State: AOJu0YwsdMz69rudK3DQrm8wZdYzwDtEp2l3uQQt0J5LVR2OwkhUBS7n
	f8/LdxYLVl3W+ltzEylF8ioEXSu96U7tE2V/+2FhdiI3qTlhD8Q8OdOv
X-Gm-Gg: ASbGncu90EKaT/4sDAwPQe13d7F98FDZ1ZyCGnA4dnPf/JM3TySXZQEHBh9gYrWTGQY
	WOBeTwrTXUatzHDTJZg8gRoY8R24ou7bdviPZ0D+R4AmeGvel2F7yYFFnTbIRU9PcGbtyhszW2h
	C+/SgNXQKZHALVMSmLl97lm58Z6JtE6XMBLtx2gQr1Xt9LLw2w33DUVVPgtWinMvC0tyQIALfZy
	fxxSephrgcMYBRnPawUw8GY/4r5OR6FxK3OBV3hsckMXdGGe6w8Enn2Y+NKTSE6ODnI0joNQtq9
	7GIIEcFJJwU7sGF25q/hCxnz29loQ0GTbpfS2Ib65Dhme/K2ezAy2VH4XKhtG+iLX1ZVTY04/rm
	hl0UBrU37uZmczs2IqiOMIteUWw67RUTCKEf/MGgdHO4Q0Dbg/6Sb
X-Google-Smtp-Source: AGHT+IGgXHY9PQVTF87MJ/PCEpjFr5cXLRtmd6peuHqToH1Wt9FiH2eGDCBeE9o4zp2egZlci1oHog==
X-Received: by 2002:a17:903:4b24:b0:23c:7c3b:4c61 with SMTP id d9443c01a7336-23dede2d292mr90633755ad.8.1752327766085;
        Sat, 12 Jul 2025 06:42:46 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:45 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 5/8] cyclicdeadline.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:10 +0800
Message-ID: <20250712134213.58582-6-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/sched_deadline/cyclicdeadline.c | 32 ++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 04e61ed..f1a0ba0 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -206,6 +206,7 @@ static void ftrace_write(char *buf, const char *fmt, ...)
 {
 	va_list ap;
 	int n;
+	int ret;
 
 	if (mark_fd < 0)
 		return;
@@ -214,7 +215,9 @@ static void ftrace_write(char *buf, const char *fmt, ...)
 	n = my_vsprintf(buf, BUFSIZ, fmt, ap);
 	va_end(ap);
 
-	write(mark_fd, buf, n);
+	ret = write(mark_fd, buf, n);
+	if (ret < 0)
+		perror("ftrace write failed");
 }
 
 static void setup_ftrace_marker(void)
@@ -448,6 +451,10 @@ static int mount_cpuset(void)
 	if (fd < 0)
 		return fd;
 	ret = write(fd, "0", 2);
+	if (ret < 0) {
+		close(fd);
+		return ret;
+	}
 	close(fd);
 
 	return 0;
@@ -634,7 +641,14 @@ static void destroy_cpuset(const char *name, int print)
 		sprintf(buf, "%d", pid);
 		if (print)
 			printf("Moving %d out of %s\n", pid, name);
-		write(fd, buf, strlen(buf));
+		ret = write(fd, buf, strlen(buf));
+		if (ret < 0 && errno == ENOSPC) {
+				fclose(fp);
+				close(fd);
+				fatal("Cannot move tasks out of cpuset %s\n", name);
+		}
+
+
 	}
 	fclose(fp);
 	close(fd);
@@ -656,19 +670,24 @@ static void destroy_cpuset(const char *name, int print)
 static void teardown(void)
 {
 	int fd;
+	int ret;
 
 	if (all_cpus)
 		return;
 
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
 
@@ -1164,6 +1183,7 @@ int main(int argc, char **argv)
 	int nr_cpus;
 	int i;
 	int c;
+	int ret;
 
 	rt_init(argc, argv);
 
@@ -1387,7 +1407,9 @@ int main(int argc, char **argv)
 				  CPUSET_FL_CLONE_CHILDREN |
 				  CPUSET_FL_TASKS, pids);
 
-		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
+		ret = system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
+		if (ret < 0)
+			perror("system call failed");
 	}
 
 	debug(debug_enable, "main thread %d\n", gettid());
-- 
2.48.1

