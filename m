Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBCF1E7C11
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105724; cv=none; b=m9wrYaIWeFTog822D34MFoCklP8GMYXb5wuS4PgLfFmx8WkCznp9/y5lVwqKb5KBQPWajE4iSDqGgxXHCC5rchJdZVl0bX4Z3dSt+m5V0NnNluTMCWg8IwWCRXiYMyhyxXuHlNmFBpp7v1l0sIFZ9I6vaW5dfDB7wEwpuMHGHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105724; c=relaxed/simple;
	bh=MJRANOglSbN7KwhRox13AKA/5vZ7hqfgL8U91jrkl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNAkIa5GRIHEPOPf66ayUgwcGXPOUZGIsrHMBtG/NQcpoYvifvLhCiJxM4nMgYrUrp9Yi3k7A2i2ssWSQXWXweEzL8TMTYlG4fd5GPk00lB06Vbq5mbZKb7BrRmSkxR+sdiBkQRC5Dp/k2HpP5bkQHjcJwrj+AXu/knoNjQon1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwxL5HrG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwxL5HrG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8732398a91.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738105722; x=1738710522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRUGbi4SrRhZaW9tZAsl5kbCcUvWBmsIqE/AgHUzNqg=;
        b=JwxL5HrGXNd2+9WyRP9HNzMpkB9h9FbU+BA7KwKDig/fWqPS1SHpYT6A3onH4gOYdO
         Ny6HS/VYKi97nX7vafn9nDMEdIYrQMQcxv3R4yWIzpGr/kIHIr50KrHCQxlRVFKrIzZ2
         EBh+7mg2/ylaay7nnDO5RvyVY2vbSFMnkVvUXVy3TeNcO4Fy01VQmqyQgWDzsiRIWoAv
         oRAXxZS1mJzx/QvrkjWQH1JnQ9S/eldxPFg9iImSivXTvr/nwVCbN4yAo6z9zz2OMyRL
         COfAqNlJkKUBKnE3NM+faj8aHMvdoh30ha5/awADC0oF/48wi7/iFEC5++mj8AUELQRC
         obUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738105722; x=1738710522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRUGbi4SrRhZaW9tZAsl5kbCcUvWBmsIqE/AgHUzNqg=;
        b=EEyI76Jl35XISmGgDH+S1I7PJc9kCEEf4+AOSYUgyBGnSo0YvLGxmNvyygdzjfxHcX
         iYB60LDgIjITJJbsxInv9jKNj+ZitLZcfo9L+XYtBQTrXBy+slI5KXkz4i3hIdsdjq5F
         /4nWOIvKBwaelOCrd+nMkjr/lBGQ/c0lwNEjTP28aorO8voyENIp2Pshb4jmUeOWE1u6
         Pxz6LsoJoFLHlEf3ZNw+YkYJLEcGvHz6L9ISN5n8KjroNqy5RCjZv/4eX+WoiXOIftvo
         nQIIU27/HbF8pJxSXiuGrGeaeUuzUli4s4mMGWh0lmTHphQt6CXqNYlrJAVgqzlzZadm
         g3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXLiWAwtEmDBzvjV/q1Qb9aYAbmgRm7xtM+ywg0UFcJqDSoSJfwGBuObh3m40EE1u9VxlHIkuHYGIFlDMaaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSJvSdDErsr0Tp262ovhbDvDJk38g5nKdGyXkbJbOqZOQAgGH
	WRsJbsE2AJ35Wo3B+8sYOqtUpYLuAnr5e42Z0+472h6ei7JqjMP6
X-Gm-Gg: ASbGncs9B7v2AW0pan5qZ3iszpZId4zxwoKV+D7JY3ksHm8EwkpwJHpil9TSMScQ+83
	W3f1dzSdceaTnqa+lwcHDGXzDsQ1P5gTM1XPRnufh70yZiH261oeSoLkE/p0/yVXgSJnHR54COV
	ngypslmqPq66g4JmAKYVrPWeOnOhB0T5GzA4NPFmFuLAAaCNK4CoRIEYfzDk9lqYUm+8o2Kjfji
	UuZ7luF08p63WrNBb9umF5KZAx0tz0KNQ0iTXXE87g8OL+d5e4qylpdPA00DU7737SfdpT+VfKC
	rh+VmjA=
X-Google-Smtp-Source: AGHT+IGpBbi/SWLYluv7cF3pPrus3FJ7Kpxh2jJNxU0dgZtyrqJgi7NjH9a6Td4iGgP3NZjOAkbWPw==
X-Received: by 2002:a05:6a00:4210:b0:727:3ac3:7f9c with SMTP id d2e1a72fcca58-72fd0beb025mr1271659b3a.10.1738105722223;
        Tue, 28 Jan 2025 15:08:42 -0800 (PST)
Received: from apollo.localdomain ([2601:646:8201:fd20::eb05])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6a002csm9874825b3a.21.2025.01.28.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 15:08:41 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Khem Raj <raj.khem@gmail.com>,
	rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH] sched_attr: Do not define for glibc >= 2.41
Date: Tue, 28 Jan 2025 15:08:37 -0800
Message-ID: <20250128230838.2311298-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
and struct sched_attr. Therefore, it needs to be checked for here as well before
defining sched_attr

Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0

Fixes builds with glibc/trunk

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>
---
 src/include/rt-sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 80171c7..9cf0e3a 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -42,6 +42,8 @@
 #define __NR_sched_getattr		275
 #endif
 
+/* sched_attr is not defined in glibc < 2.41 */
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -68,4 +70,6 @@ int sched_getattr(pid_t pid,
 		  unsigned int size,
 		  unsigned int flags);
 
+#endif /* SCHED_ATTR_SIZE_VER0 */
+
 #endif /* __RT_SCHED_H__ */
