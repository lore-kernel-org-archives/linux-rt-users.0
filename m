Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEE381B1A
	for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461439; cv=none; b=ht6z9mVG/i9MX5gkQZdoXEfrYjmon5NIOsdeA6RkoSoew37xXtDGwqMuLJm160rK4REz0w8LHHQzXzLqBxiI3VVmhssv7HrabNBRjQlv9ujbHRC/bsW1Ay4i9p+tYMHH8ukncjjkzCMkFytFddyH3iih/qRs5sBumvcrgzeHgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461439; c=relaxed/simple;
	bh=uuHNI8rSvdgPX/WQWChRMFHrIIxSRxq7s+b1/cqk0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEyckXf6QQwMBAyI1MIjtyhW4IcuANNwlxOeygBJXCofFWh6nJNLNop9ToB1xfZAj9mHO5CjNaTsdwua7dr1rpuJuaeyylBxtKe6DtsZMvozsD9SChVomu3al/c/Exj57A0e2ckx1hyFo0jXoM6+s9XPs93StrFImAt4P6bJ2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnHZcIel; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnHZcIel"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936dfd009d1so149630085a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2026 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788461435; x=1789066235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZ6gX6+pfxZRARsxbvpnzwE3yZRYHDUUmYEtiFXsm4I=;
        b=BnHZcIel4JqWZqqoLWrAhutxt0HNjZgWzJEHZ/6PedZG/Lgk37B1EZHnGiWMQgctsm
         ygfrc39EG8Wdl5IPXG1mi4UEeMGKWQTcn9UbpSQ4YzeKRnttS2jlS0xjCFUUQR8dB1Y1
         D1ck/CXtdWtXQyk7CmJ6hw8DCAiMepbzKKYczz3BX56v1xChHhjVZnDFX+14a+DusCYh
         9ooZK+95QhLsO/3GEgcyssWAax60SPjzStozBEAel6Scp4LSYR3mTb7NQu4rcUmERc6p
         T8bDahrdnDIdAWdWAZ+oJFBUbGS3AIk9AN1nLurEWzRgu0qQQrhOJCA/jX9VTnR4bOFz
         X1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461435; x=1789066235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZ6gX6+pfxZRARsxbvpnzwE3yZRYHDUUmYEtiFXsm4I=;
        b=kINxxOwJ+TWLam9vW5SplVmaDsRmSKisWTV8TfHGAz+zspT7vUQ5DMPAe59goNvaDy
         Gyvm6ARJjbn1LC83Y/3NJiM6EDrCkNxhR1f9eBEmQSeZOmc3C2eagIeD8tzLLq3tmMmk
         9Tn3Fcx7/BQz5ok4OkHmbzEQW7qimG7LehqG/C9usei9/Y0lew5Ri85R6CeXhabq+Aye
         sIZUhvuwyO2RbhnJRGMDeMSkKEo43WdsN0G8ROgbNB+tF2OKs+gNcRMx4JvRnHXtB9eh
         w8B21REIRD+gSB+Akfh49cVYu4ks0+8i/TlYAaJi3pssypn6hjKxGQo0whNo1t0QRKIK
         3Gkw==
X-Gm-Message-State: AFuF++k+mRlH9HjQlgBi6MI+JBi47CF4Cd/14Y5kz9pufBMKXlT3t6VL
	fMJ0Z+116as97HcflTWWsKF4F3gIrr5RgDcqugT9IKlK9dmgnTYOU1hADI8p4g==
X-Gm-Gg: AYBFou2/hi319boOu4E0DAe6Z9WkW0U92QmJHuoSPV6zyrsaFMPurvD/cG2GY70gJZS
	Jx6PZHezkvcHDgcpVLg7FSXFts97MwaUybRRL2QNRDVxV3j6Iinj96Ghe024Z4t0p+2AcEDw4BF
	46pJlo9Ie1UdQwnQRpqIPQ7QZUN9j/2QvjGdFQUtQGE4aMHBL1y1dPFI2iwdl7LXVNBFHRmB1x/
	YRf8rF/YIVNwCuiAOJUCzm5+4aK5OmhaUe4D+5Na8y1bUD/Uv4qPcWtArZPpkNqdjgaIaH7sU3j
	FgF+923759X6aqbZVg8EoMFaUyHIhcEgfVMtlfDjSupFapfY+7ig0c+eRg9Ct5xF3UEmCssoNBg
	HoNFqgy/UIiPi7uI+xq11QUUauaS3rRZVQcxPK5luXsaP3eQAYo3XyDUWhwfYmqoe43DR3QAdma
	PRN2HSiI44cGSZXbzVvl6Q6cqipTw3YDgJ/mYZfupYXc7M1qZRYywOlSlE10eHG7IInYz+UYdzn
	v3rmqkQb9fOyEOe13DWeEZ29OuAqUx1ES97JO9mKEQ0
X-Received: by 2002:a05:620a:aa09:b0:939:a45:8c96 with SMTP id af79cd13be357-9396e07a4d1mr645638485a.19.1788461435219;
        Thu, 03 Sep 2026 11:50:35 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb678b8sm34816885a.30.2026.09.03.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:50:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rt-tests: rt-migrate-test: Report trace_marker write errno once and stop
Date: Thu,  3 Sep 2026 14:50:15 -0400
Message-ID: <20260903185015.135928-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 1fc77b9d100a ("rt-migrate-test.c: Check return values of
write() and ftruncate()"), ftrace_write() prints "write failed" on every
failed write to the trace_marker. Because ftrace_write() is called several
times per loop, a single persistent failure (e.g. tracefs not writable
under SELinux/lockdown, or the markers trace option disabled) floods stderr
with ~150 messages and disrupts the progress bar, as reported against
realtime-tests-2.10.

The trace marker is a best-effort diagnostic aid, so instead of retrying
and spamming, report the failure once - including strerror(errno) so the
actual cause is visible - then close the fd and disable further marker
writes for the rest of the run.

Also clamp the vsnprintf() return value before passing it to write():
vsnprintf() returns the length it would have written, so an over-long
format could otherwise hand write() a length past the end of buff.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 1c60fe4d3a01..c33df58acf1f 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -68,9 +68,27 @@ static void ftrace_write(const char *fmt, ...)
 	n = vsnprintf(buff, BUFSIZ, fmt, ap);
 	va_end(ap);
 
+	/*
+	 * vsnprintf() returns the number of characters it would have
+	 * written; clamp it so we never hand write() a length past the
+	 * end of buff.
+	 */
+	if (n >= BUFSIZ)
+		n = BUFSIZ - 1;
+
 	ret = write(mark_fd, buff, n);
-	if (ret < 0)
-		fprintf(stderr, "%s: write failed\n", __func__);
+	if (ret < 0) {
+		/*
+		 * The trace marker is a best-effort diagnostic aid. If the
+		 * write fails (e.g. tracefs not writable, markers disabled),
+		 * report it once and stop trying, rather than flooding stderr
+		 * for every marker for the rest of the run.
+		 */
+		fprintf(stderr, "%s: write to trace_marker failed: %s\n",
+			__func__, strerror(errno));
+		close(mark_fd);
+		mark_fd = -1;
+	}
 }
 
 #define nano2sec(nan) (nan / 1000000000ULL)
-- 
2.55.0

