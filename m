Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4633E16AB
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210338; cv=none; b=FggWN4LRfahShP9sPAhIY/YzyCZAt+b1a5mCAt+hfm0xkWZ7zDxTSWRA4n3hC+8whg4yjie0LH1mU+qdLCY8NcSzd0ikYXDHd9ZlqJWquscBBikeJQQ9bmBRe7qHecU3u58auTPEateJnZTuAAoXVORLxYwthbXp+PyYXZOY9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210338; c=relaxed/simple;
	bh=98oRjC35YC8TD0IXrgUuKyV8IquNf5wGnbu7uRgrcZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5dLoWjzg0KFiXYgOAaU3uYrtWAuN8nab+0sDsisf4RUNPiVo8D2lz3455Y/J90ehHl5oF7dlP2Guj/jMKZl13F6haSWffRmgn41UYBlUNU140l2taAu5KFvMOGBn5JUmmUEmEgdn/OnrTLHKjwIzRhOXOw7pmKNDjFBJzhemxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvqTipa9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvqTipa9"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5178a42caa3so3059461cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210335; x=1781815135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qztivgeNJycbOXxMebsV7d4xXiNhSWeJylh9E4Rha0A=;
        b=SvqTipa9G6Oj2FXW/roOuDZeY0cvkuyg3qYhSec8+DiDLFo/AbzVZxPFDugemtHLxY
         uP7I4731hQRl1rXYs3Q8PYo2wDzQLSuxg5q+XCaUQeUesT/a/PxDQNI8K4OJngskjC3s
         DQsCXzqfTybcGIgvA+Y8p14kYdcV4ar1IJA8Un42IVMoBE3oJGDF4cy3eMDwTcivM80T
         6rEj1680PN2dkOPagRAzPSGgOM893+HDskYgk9423f8ItiCgMUqUkt+FQW5LdlC9ZeEF
         KParCTX8B0bWQl316UnMljLD2acDMLsDf+Hq53y6EtIEjElUM2/pAEjj3bJl9XM5qSBQ
         895Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210335; x=1781815135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qztivgeNJycbOXxMebsV7d4xXiNhSWeJylh9E4Rha0A=;
        b=gVKf3V5bTJz8B1xGJZ1gvPty/XVWHusHIFbUoAkbzC6dQ9HEp+/jKQFiYofVp6WikN
         +ls6DyPFmCOF/kApaY8rNMqx8m9QQb2uFUpkfaOQucBXhH5+GfqVDqjB/bHD6xdkLdI4
         FzUUxEKkuaL/7nNNghlocK66N7oqKLi7CCo28xm+XcrensttrJzp719jUKMW95x7rLwO
         FH8PBdIqBPfUj5t1CrMg19YY1IQEhG1ekMdmQ4uNMaRmHwB8CDJnoqslXmYO/BMyQsYs
         kZuWPQnHfSiOCI27XhrH0doWq3MGVESuCWwHqAcIGtC5WZfhGIyhL8zZrgSVsk3FV6CK
         trqw==
X-Gm-Message-State: AOJu0Yy3IVyI85fAUG9RoJWWf35Z74yALREaja3GkijcrLjyvF+XPkN0
	8e0QzVieDK2qYCREzDclu2Sjfx5ggOLsJtkPGvqQC046f4DemqAhyoWBLPYlcw==
X-Gm-Gg: Acq92OGZdAERAKQw93KjWE4cdoeRRplY+Xhy3MIQT6JnVYnFku9SEnKBervsgjcescP
	BfL+DN6MrZHlncmaCaayYRlaRrr1cVT4B4Z30hsNRI3B3ZV8zPzFMFNFSJgyTkgr+33/WIdVLmg
	3CuGPvoMAXLSFLuEUVf055LxL8keFyJiJqpaQQH1bAgg8/7as7fpOROdNUlM20d1BEeQg9Me2V+
	46WIM0EkM+9Rd4EK3Plakmxvrw9wfwtaui0AsDawZVy+Px2JOZ5DWqgQc4A6OiTaXYlEWaC1sWa
	4YApcsohRmNZktfirLPSfMYBbXh1EK//hxFYVh7P7LBcpSEqd1qr35Q61QXWj22I9U1ZIQRZ51H
	mRRzUWrHrucP7d9VWnbMXLwh+dRzy03PCm2L1B07cH9wAt8UNpi+bjD9dqR55a6T+U/GgnQlm5o
	8aeDwMh2qolulNPlf1RKANVVnaNt00GAJ2yUPomS8pAmzuIDfA0ZR4JfB9wdd4d6N/RoD5uOnaX
	XddnZMySjktuDo+tGs=
X-Received: by 2002:a05:622a:17cd:b0:517:6354:65fb with SMTP id d75a77b69052e-517fc320452mr3070761cf.9.1781210334996;
        Thu, 11 Jun 2026 13:38:54 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 4/5] tuna: Add .local/ directory to .gitignore
Date: Thu, 11 Jun 2026 16:38:31 -0400
Message-ID: <20260611203832.176805-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611203832.176805-1-jkacur@redhat.com>
References: <20260611203832.176805-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .local/ to .gitignore to exclude local project notes and
documentation from version control. This directory is used for
storing development notes, enhancement ideas, and other local
files that should not be committed to the repository.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d8e20215de9b..273af4ad6006 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,3 +3,4 @@
 *.swp
 tags
 CLAUDE.md
+.local/
-- 
2.54.0

