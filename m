Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D61E7C27
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105773; cv=none; b=c6OecKxuejNcBRlmwRUqQzyIlo9qWPS42GqXbnpauN4rnSJYYaxyUF7H3pzNFcpYDXaRhUxkHiQNMTYiDPZxvi+tzBRN7prxBganME45CN54Fa3DXD03viUEzYUsu3eKgOKDUyBLWvVfT65ApAZX+E6QlgccNHbyGUQfGYinNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105773; c=relaxed/simple;
	bh=MJRANOglSbN7KwhRox13AKA/5vZ7hqfgL8U91jrkl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JivvjaaWtRy87Gz1JB8SN+3k57CLT/n3xIMUqV3+JY906TUycwkgyP9h6NxD/gOGn/ZYetiTgxQn5KxgmLegSIzulSIz8V5MovZIleaUi22slGTxPps6Ccv+LeBAXCOoDKvkKTcnou/k8cSG0UCqqpdhQvkwSPjbvPkWpi+oP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIUoc6vN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIUoc6vN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efded08c79so8754802a91.0
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738105771; x=1738710571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRUGbi4SrRhZaW9tZAsl5kbCcUvWBmsIqE/AgHUzNqg=;
        b=iIUoc6vNSn+MPeqSVnAtTmdUExxrZwuCYS1Q5zyU9+smiM6UvxEIdnnKSVl710Lkit
         pLiSfUFUbTx53nBmONW4to13U6rhpjMpsKLwYPfJYSnHTiywR5/rub7JFLVhocIrlGgt
         rUUzskkBFGquzFOFwJTmrKEgwJEaQDrm+fsKy4Sa9UBI/E6ok4C2LrfbWbmRkQ/3OCh4
         K4mIFUjt374tRs+0phvk32ELK5KFge+G0WYeru/Z5oq93Mzx+UKbUEcWtwXBQRiuXrEY
         TYvZi5QF8BhW+1UPlS2h/A7Hz/wPzY7d63PzC2Eh13nti2LjYFGYCv1ukTprVHNrSllU
         Jsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738105771; x=1738710571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRUGbi4SrRhZaW9tZAsl5kbCcUvWBmsIqE/AgHUzNqg=;
        b=wVjn0txIpzduiMeMhsdb9DqFTwIToxRChnAIOzoXK0K3gC7o512fkCe7yrOK4cvy2H
         bSjA8nQlZJHKx2urkdNa2ODtD5d78OJv+t7K1Gq/jSz5yv3d7AD/p2mwG2Di3AoqDp5+
         SYbdH+vBaJzzNdnvWmJWkT2y2LHUnr8krwKZnm/pK/nQNNnVXhzBEjzJwRO+51/vvuIo
         GLTm0L5T00r1+mg3JYEHlUwqFBk+K76rlKaLbxbC9z5XPS8CAJyuAk+dNE70iLnExSpp
         wfub6zMRCWrF4fbq0YdgBCo9TAYwnME9VKBCY5H0ZnqpewspcXn4N9jlheUPIT/WY4TI
         B4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXtVDe1B0dB5QXSQJBlb6EHZZg/phWnYDVa3iXjUTs/xje8/y0G54NdONg+UCI0Bnx5wM9qmGSZrMLRRhHpfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqObiLZLwwOgDUkXGZxd7wtkxOUUFoPAQEf3HEs6bQg7yPLrUG
	5XsVeSbAhvdZH8TA6auxR5F411b487sRsssNpoCz9JLj7bmmlrEm
X-Gm-Gg: ASbGncui/nleHZgJu1awJU9dLC4CfKsPrIV4lMihmJQPIRDFIwyzv9A5ATDnON0O6Ch
	vaAnBjnuGHcFjJaSByyWCR5hdHhwgtdViEmaLpWWD1wJeWGCvgbcDIL9fz1cs0317TrkX4mLBXe
	YIO26zq9KZv5TN2TwxQa+05vtbQkWhS1NIDq2f26CX+h2Dj3Y/NDuMjXJfolNsnc380AaVg9i8v
	vZB7zpfaF622ZgmXTmXOT+FWT9N6Y0r4+t5sB+a335UC7Rmdxk5a6c5SQbVOUHlnQ7k49PIE2bm
	vFz77rM=
X-Google-Smtp-Source: AGHT+IGzBAXevDL6H40wrk2qDszZjBgAR1onfe5iazK9s9lxvzFw2Oab/FoeaaNYtqurIFE7FQwImQ==
X-Received: by 2002:a05:6a00:1396:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-72fd0c7bcbcmr1576837b3a.20.1738105770846;
        Tue, 28 Jan 2025 15:09:30 -0800 (PST)
Received: from apollo.localdomain ([2601:646:8201:fd20::eb05])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6a002csm9874825b3a.21.2025.01.28.15.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 15:09:30 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Khem Raj <raj.khem@gmail.com>,
	rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH] sched_attr: Do not define for glibc >= 2.41
Date: Tue, 28 Jan 2025 15:08:38 -0800
Message-ID: <20250128230838.2311298-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128230838.2311298-1-raj.khem@gmail.com>
References: <20250128230838.2311298-1-raj.khem@gmail.com>
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
