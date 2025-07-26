Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B932264D5
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521532; cv=none; b=Vqp6jehOiLUvA+xiy0FxyKrSWkYt30qURNEu741kVjOBYZHAOVFzZcApFnxp6941/6gFccBzusueRRltmL8AR64AizdH7RZ++ubZUb1TOuXbsuM8epcKbT8N/m+aQ/L12TR8VMUYVcPizhucMWhMFtAc35I2gF+BqqCym7BWPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521532; c=relaxed/simple;
	bh=w9xwZ5xvy9g2bEIzI1y9oWQnc62BHCaJhnknJB0mybA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym3gx/OlWNjqJ8L9qt6vGLzajw0k6z4Yvtt+rg0VDAuddswDnG5hldYpdgb3OeFMg231VOzQEHUOiO914OxaopGyhaNLoeuQdUmDVOIHIBGr9ClsmBVBJXFe9esaZGR5Wcn9BQGIgumG+JM677DOro4ACSt9K2xOp7NIrHv+ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h77XS10P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h77XS10P"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so3631754a12.3
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521531; x=1754126331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCB1eeG2Dmnx5gO46V48MoYbNf/NXD5UUzKGQTbSw2o=;
        b=h77XS10PYiABnpdZ+7YQuy5mG1s/IVORUerrB5Apx4Y2V4qtdFBpjEd352F1mWayHJ
         89oRiIaJyav7SDiPjJ0Uqr0wF2NQngNiELs6RMdLpLMyDTiSGxIgD0/40UqtW3nFC0s1
         +93QAE2+y1TdhHxnmlpmZs6+1zFqdu4zEz0xatVLyquR9p3SnIncVZymXRXSS7uUr+8m
         /VMDSJfuMOhlt7VT5PlQfwOP/BtygStIn1MNTYpzqKng/bMZzTQfjdGbwTVzyjf8xVX1
         FGoqBHv43OxESFtGZnF5ADMz8VX75mI6lAjDSmuv2efvHL+YjvGManmCiblCpduH4asy
         +MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521531; x=1754126331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCB1eeG2Dmnx5gO46V48MoYbNf/NXD5UUzKGQTbSw2o=;
        b=WoTJG5n07YEr+jM5+zuhfCru/gCtatAgRcWnRZwZLWTzp2suot6eGTtFaxZ8jhDjiG
         +cU/eX78Ks1ECMsBGkiKo5dhPA3/YkVQ8iXIXfP0OVc8am8uraWcu7/rBmKagQzFJR1H
         gt/iFZToTzLQ5mI3nAu5Gtk2Pn177ddRdprdbj4hPu4QNlhlCQyb6XJSpuXJJJXDKqhE
         UzNwEz+cgs4gB16JTxNAfd4Q6BklxFlpUAyTeSA35uWyPoBwwKw7gPSrc2IbcE8fErj6
         IfcH/InRk5c+TjzttmEvPZyEn4JTf9CyX8h/UYZmHHR+ItZdQ8xFbW3T92LSFQJf/u1/
         auEA==
X-Gm-Message-State: AOJu0Yw2vtN9JmIBR8U8T+HGxbTOBQXhksU2r8JDYHgXrfbzkQLRrp5D
	DUvvCi/XYbwb6jbgjMRgfZXzuh5SeBun+4YFm8yGfg/6JCAGQ/pglkro
X-Gm-Gg: ASbGnctwmWLPu0uCxXowAQLkaP82R1AAo6o3NMnVZW3G/CU0mlJMy5dSVjY6HCQGIy7
	gCx9Dhbj99QLjbWmvdqc9axvGhOALApQo6MpP1OnR+ho3cO6xNcfpivt/LaS9pWU2I/rBNTvrw5
	xT09GeN98SFFruea65cYA2H7OogV2tfJU2lv+K4Wt+2G17h5pwu3cCCnB+fUBepkG3nOH8YJ2uv
	PSvoc4AtN0km6r0oqC1i+YNvmjqYMQl8pEXfzbS7/m2ANVOn6tZJX1BxarulIsTm6baAE02iBKL
	fi7pOoneT0okgk3ZQwpKT6lRqkE0AwOFGdumQTUQ9uH4IA0n+fiumiUClIDVstRx2DFZMtvAgtt
	Ap5EtaGIMDukXNBbz7Gu7ji0hA6pQ3Ylnz1v3y5/5CZy3in1BsSnV
X-Google-Smtp-Source: AGHT+IGEid1K70yU9LJRFK52nW8UEeSyZBcyM4sii2gQXE17Xvo87lAkGnknMH6aeWatYtJglC45Xw==
X-Received: by 2002:a05:6a20:94c8:b0:21f:5324:340 with SMTP id adf61e73a8af0-23d701ebc8dmr8691077637.41.1753521530493;
        Sat, 26 Jul 2025 02:18:50 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:50 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 5/8] cyclicdeadline.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:34 +0800
Message-ID: <20250726091837.493915-6-yphbchou0911@gmail.com>
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
 src/sched_deadline/cyclicdeadline.c | 32 ++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 04e61ed..6b5d3e0 100644
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
+			fclose(fp);
+			close(fd);
+			fatal("Cannot move tasks out of cpuset %s\n", name);
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

