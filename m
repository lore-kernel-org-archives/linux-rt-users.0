Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5324277C93
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327767; cv=none; b=ElbAAyPUl/pB+reXjVxFd6PubZXGZYGzaeO2O81QxlT5FbeEkiawx2uKZUfbGprNcAv4fuPjxcexIIN5kizka4a683rMgbxlbL0E+9mj192EHCGyXdwrhsbad/QwCEesD7AWFRfnVtdiHWezIdMfVaQ7urfygv8qjwvz87dh66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327767; c=relaxed/simple;
	bh=6epMLwTW7ED7aDcs0Q+EO/8IoiH9+KJIfbXPh2SKr0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbqY1GBM5N3ALuefy2e73jsKWBNSM3Lijhjw+foMgH6bhfq1Y18FuRYpKfG20lZz7hEYC7PxwwLr4oE+4lbeXQR6et2d67AWp1Ehl4DMgFbHxWQjXWtBjooIUGFtW29nQZCYal0MS9RhCtj76rtSp5ZkAiXOtuatNN0UJrgwn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiAEOEPN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiAEOEPN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235f9e87f78so29256045ad.2
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327765; x=1752932565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmMmVSBLCUtZx0F5d/ODc0hL0ALz4OOsvrqKK1ngk94=;
        b=jiAEOEPNkY8FRv0PN++14hBy/pnNykCxsPQT9UhxQaR9wWY5QCx2C0hcR+apDZTIPO
         GFYlCv0VjO7I9xl7q49lyVYNVrKWyALKxFlbL1+N6dByVBz7kk5sJnUqc3WBsgj/wiyq
         6gj512Wq7zp/uZPkkC9h2Tw7tWUVdJ9q8ug/s8Mtv1YU4SWMOSY2hwTBUHxg+7chwYHN
         vB+r0fi+E+8rHf1zfRtooDNQe2WtGDs97uxbDVjjVdWX9gJI8Els7rwBOIJ8lVWYUA5p
         1TNT8ufF9WL96O4n4pqzkpvcG9wZvLnZd5qoLqHwcFoMP4oEFe0mduB9793xpjroz5rG
         ccBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327765; x=1752932565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmMmVSBLCUtZx0F5d/ODc0hL0ALz4OOsvrqKK1ngk94=;
        b=G1+ANJ6h4Qjc12C5DlJjZ+oqi2ZHfBFm9qHPRegvjapJZKvfq0y0QsHQJ//6e6oMXs
         b0tpGQGs2vX6YC22oBWjTIWWZOoANgpXbTdcFDrWmhHhGfEASAInTEk1wNW90dG3PSbQ
         hFS7qEoRxWL+/PVNRGOIHmdVlAHkqvRqBSYNysK0fDflxoaRQHAQB1zqeHU2NFF0v92x
         OJZMCS8AcKIiCYIwUVQ/YFaDZ8TLQeXBAzoxdO7ArnHKVo06htyRxHS8KRcsHboHR3Tq
         VxFSpl9HdZVq3RwM67LsVGgKUdnCTDvy+1gCKUTFRFQW052fgLI5P4sjTfsQ8Msws2VB
         WjWw==
X-Gm-Message-State: AOJu0YxBJ2Rko+p1vGr6pgOvKvSt0qUc519hLJ17hp7FLR6BBMkF6r7K
	W+qODbCn0noCbw078e0FRmmG6FsNzSYp6wNst4k/EXqKGHcqvkRQMUsc
X-Gm-Gg: ASbGncuILpzau0vlW0NsZXpyu6lpi/is7kKyXAc6tgnif/+0Y7Z3SiJZLzlBdaK+JS2
	XznoUbdU9kp8/7EtMC45J2vMks7pU2dFS0wcXXvcbeXpoHBCpR30XOLMmrQPFX1ITusA6Mbgd1F
	6aELIJfXTO5UADMk76yi6UeHn8fCTQRHyk1k8D+NzvFVBRs8uFKqvSN/ioRw34XJJ1eNqVVRzbL
	fHRN0QE4zF05zeZz2eRrkj+xDcMtKQ2WXnI895IeU1E4HCXZOiId4/7uGilk7cU7t+v1GX1ZNHl
	pmf+dVKIAyYNDkEEp6+5lGMkJ0saXwkzqwp2pxXfqbRj9u3j9ClxjylXgBnuK0Wd2gg8KSTqX4B
	Pkx99QJqwBQghkwBO5SLMGMFYhy18gi+YOYHBF5cOL3Ge2T0K3UnQ
X-Google-Smtp-Source: AGHT+IFzUGatKzqZb2WhNHlT0vc9AEKXfQnCyzy2AdkAbI6hYsPneDe5Rr6LzSFuzVZUHQBAkEoUJg==
X-Received: by 2002:a17:902:e84e:b0:234:f200:51a1 with SMTP id d9443c01a7336-23dede2e0bamr90597915ad.9.1752327764738;
        Sat, 12 Jul 2025 06:42:44 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:44 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 4/8] rt-migrate-test.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:09 +0800
Message-ID: <20250712134213.58582-5-yphbchou0911@gmail.com>
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
 src/rt-migrate-test/rt-migrate-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 8afe083..d7c0bf3 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -61,6 +61,7 @@ static void ftrace_write(const char *fmt, ...)
 {
 	va_list ap;
 	int n;
+	int ret;
 
 	if (mark_fd < 0)
 		return;
@@ -69,7 +70,9 @@ static void ftrace_write(const char *fmt, ...)
 	n = vsnprintf(buff, BUFSIZ, fmt, ap);
 	va_end(ap);
 
-	write(mark_fd, buff, n);
+	ret = write(mark_fd, buff, n);
+	if (ret < 0)
+		perror("ftrace_write failed");
 }
 
 #define nano2sec(nan) (nan / 1000000000ULL)
-- 
2.48.1

