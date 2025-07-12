Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AE277C81
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327769; cv=none; b=W6cAF+tW10ax/PGbxEXwlUX539QDCDMju16BJrBHSQ1oK9Eozp+/nuL1bnvpu7ZZGfu3+gvAe3JkVD96COEeTFKLzUvnJhPs7VV5iip9ELkbccyjgGElTAuytHo/abFJAfK2iSe0iR08Efm/aCmYhAkqrhrVuKWqV0rsOSzPGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327769; c=relaxed/simple;
	bh=CqzApoAQ9rWremRWZmXWavMmV7Vb4YnQI5As4t6CDSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa1T5rcF6nXf6ucsqajy/9cg38MEx1ptHqvoVOsk4h+KqXIwkyhJ7nmOfvGpDqkxvun+m9K0gPAra+YRdMDVUwX1NJYFBkPCvfNSOuWhR0gVSrzc60x71bR8KRRaZuQFWXj1CHQptVjL169S1xrw6hxbWVbAtOZN+tLGCbAKFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGeauSV8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGeauSV8"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b350704f506so2373262a12.0
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327768; x=1752932568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YSc8Fn0OR8YucL/vwEoif3LrDgb5fjUrqja363VwEU=;
        b=BGeauSV8mXR/NSxH2Kk0e2nfExTS3qIwOeYk3m0ezlq9JtuQlzDpTyVWcVvoYJYNQX
         U2ZP8/Ms7OXxXB+aHDSBJwYnOHE7+/YaQMFjvRJiFsxwvKvYIAf4aYGN/jlt/1rKTevk
         wTuzFytmk4U8PdBFgnUCvEkMI2QqLLD/jUv4GJuS3LfNnjZ0pzmKIHNmUrecRjSG0O0f
         qGRKkjTOGbiYi3/zaswuwaIA6LLUPvlcgmKnCqGbOlDIHr7FkjzhhDUT0XQ/SGt011g5
         VyPVwVhwSgjTVH0asCbDdQuw/ScasGRgamhNNd1ws3GICMDB3cAmYZL2h9Tj3Ffwc9rw
         IQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327768; x=1752932568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YSc8Fn0OR8YucL/vwEoif3LrDgb5fjUrqja363VwEU=;
        b=pmjDsLe15SA3A6uJs5eBtSzitWdd/3XPINx7HLyrEGbkCoJkCRhN74nBbH64+qqMWg
         hDcm15HisqphucZk/J4y7VinO2pZngJ7kKWvtaJ+jOGQjtuY0p4jJ0ywkj6yoTtttVgq
         Y1VwWeGR93/hA82Hatpv1r5txE+iFSuaOziWsxdzrWaFe7XsCGcfaO17gf5gVxeThF4l
         K8muCn9llX0Tmws8WucD1eTFF8MsDNui63FosYZ31E6ruqeDcNoYRerX2UfxF618Ey0u
         u1Oq4kp6ka1EH5e1QgbBtZGoSbdgD8to2Hrk9Kk0MDrpQFEMhykev1dgzrnKLx1IBHx0
         Olng==
X-Gm-Message-State: AOJu0Yw4QCHLMRK6z5/gQzMdl3aBylqPtgPVv/cHQ/mj8f+kD3YJm+wI
	KK/4oLtxCa5jPPtRT9L5sD2BwvmUqphrMLie5tKxM8QEe386oET1Ks1T
X-Gm-Gg: ASbGnctRSyQG0LEHxsohvXlCLSl9tfzkOK3CJXpw/gTPaIRYiPrcGraPdWQ4/h70seJ
	SGuMKW+FId5IhkSuM8RgVb8iWPQEfPPtkbtZtBNaQnmYHJaXXipoJNtl0jSmzNXFgki9Q4jAjPS
	MHiDU/yJP+VDmu0oPFwTTTzuxlVVcjReC/0wqQp4BrN5UReJpeIaX0jWkO9kFbFxNX/0AbY6KQW
	giLIdrbAjYJzy+JdYXN4f+neSmfvabEe0FbTD5JW6mY4txqQgsOgu4oUnllA1Tpax9UoqYFGyXR
	LcGr2hzQVkbhMd3d1R20Y2T+MsxibyjNVuAaVLxkcuZ8NOg1XtMCH2VQzZNcjOUaCrerwSpcQq5
	SOtS2pecoHjMrrN5BlObHERj7u4BlW/d7keUJWfuI9abNQDF0Ge1+
X-Google-Smtp-Source: AGHT+IEY7MUVY+0hSz3eSSt5TA5Q372EcvX2O8rftJ6CChu+KFPN+9moBVife604PkMV0kuudfFLPA==
X-Received: by 2002:a17:902:f68e:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-23dedd025f3mr111388135ad.1.1752327767426;
        Sat, 12 Jul 2025 06:42:47 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 6/8] deadline_test.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:11 +0800
Message-ID: <20250712134213.58582-7-yphbchou0911@gmail.com>
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
 src/sched_deadline/deadline_test.c | 37 ++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index ca2da47..4f9a6a6 100644
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
+		if(ret<0 && errno == ENOSPC) {
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

