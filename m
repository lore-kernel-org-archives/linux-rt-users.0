Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EC21A95D
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521531; cv=none; b=oSR3bot3rRHMq6cbJvgPKIIJ8sCo4My9jnYSShGur/cg1qfneIOSG7211qSB5wpdf505HlqZI8clhGY0D6zqQFqEtoCvVX7FgW3OjUaC/kl5O49C/4VwIaYgMh9IHr93TbESAiD7otOeTVDcHvT2h3HbL50x/eGMolbuSaEjeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521531; c=relaxed/simple;
	bh=uBV2qgxG90E5r53DEY0i48dCReE9OauWEi2dynmm79c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDmk1p6CmMXqfqHAkhhH5TOsLUdI1qXUS/8S+KcVnJuce9agyQnJsccgUWUjO+CBohYJ8NkRraPRgIq8bycRHxZbBYjARFQt6odGjXCYZuHxpc8bbfm4bwx6Op+6fXOWvFH570rWKgqNuNNtfUt1v7J/9kQivdPzY7vCH35I+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5tfZB2/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5tfZB2/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75bd436d970so1870375b3a.3
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521529; x=1754126329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrGsVpGaVA11pcEm920ojqfOow5cQAhYIWJE+FU5MF8=;
        b=U5tfZB2/oEOJsI4ksoausI/KpvOsTg+taVZ7FhHPr92dCDJxHOoHyX0E/pZDHCkUCc
         MoYj0K1U+7sW44Pg5CCwgUA7DpCIOz9C5JwTm0vlv7SS5E1P3CWx2xlp4mNMpvYU8hVd
         tl1/lKr0cKl3RrRMWTrAD5NyR3jnb5BjqOsxgn44v5BPHepnG4SUsps//OxB1xusj+Wl
         SRSULVMXY+u1jhETlcBD12FBcmmlqrhsdUxE9GNz19DpaarEXREwaNWME4hVz1o84MlQ
         Ir15YCBN1YEeciu8ePoVaX+kjvW2ylOg2qEBhwpa1rv1HqIAvawly5vBr77VRC36rPAP
         7QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521529; x=1754126329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrGsVpGaVA11pcEm920ojqfOow5cQAhYIWJE+FU5MF8=;
        b=Bpq8L3NIpkF+o7jzuE2pga2bIhcfWK99TUVLMgZA4WHyGb+dxRveqbCV+Dv8sUXh+C
         9aICeUOaOp7oZIVlB3WpFx75M4v9xAl+y1Gu0FfIchkxOIhl7dL40EpLjf+g3vKIO5E5
         1jNXWVCO0XL/JlDPPHYdgnH/OlKvh4Ks9SX8FlSLkbGFqga6TvlovYN/qh8O/3oxeZSV
         eUpGxaGoF4kEKijxdf3jhuzRc4dyB8RCFwwBrsVuhZSk7Y2AWDzAQdGXzCj+igjVyv8T
         wz9oh4WxBE2ZI4XGgjZAEtpR+P49trREft3StV8DTIS8iTJ5RkSHptdQlYFWeIq1/bC0
         6BnA==
X-Gm-Message-State: AOJu0Yyv1HBmsGwWLEu9cjPSIIwqVYUXg5Uhsp1RfF1kZOTe6WQTjY3h
	UjJvObBoPru80YZxZSFipfyRZ+qAoGmK/6UqYfodGE0teJNfIq4YRBp3
X-Gm-Gg: ASbGncvVE6uXlPR+aHcFWkMBOjPOK+RWALi5pOmXoKdSesVmbp0tJ9+jAothWZfi4Dp
	i5EZKCHp6rhAg9BnvO6cXR6gKgIyGGoPdT30Qnkrhnpw+LGwLtwcGFJ3qNKBF0YhrlamYoBRRIt
	y4FqaA3ShkUryQtC6DdLNmvPJQG9T/fuLRCBhB0spqLqkMKG+NvR58DsPEEFMhT2G4wqyluMTRe
	3XwQx0xSEBd7h6K9hA+qaIfk+NgdF8H1u5Avl4tN+Li+X4jMWQQaRN2EYr+Z4tWVNCI1k9b1rZ5
	lI2kAS9d+8uja1NVWIE9MqjX10RgWcnv9sgnhxFqwGSqpApB8ejpdeEKg2JHVnRsT5RUqtVX9LG
	7jUdoUMFt5CQtPuzuQKQpp7QVwLJzJ4YTvQa027nbp/gjMW8nyHCQ
X-Google-Smtp-Source: AGHT+IEmwNM9kckNY1opiJOR3BdqhJOfvLxzXdJMzPlDxlQ2Jra8QmnVtgqAeL5JEkQE0BxJXYp0HQ==
X-Received: by 2002:a05:6a20:430d:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-23d700982admr7815096637.10.1753521529113;
        Sat, 26 Jul 2025 02:18:49 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 4/8] rt-migrate-test.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:33 +0800
Message-ID: <20250726091837.493915-5-yphbchou0911@gmail.com>
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

Add error handling for write() to tracefs and ftruncate() on shared memory
to avoid ignoring errors.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 8afe083..e007ed7 100644
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
+		fprintf(stderr, "%s: write failed\n", __func__);
 }
 
 #define nano2sec(nan) (nan / 1000000000ULL)
-- 
2.48.1

