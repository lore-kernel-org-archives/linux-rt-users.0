Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81133B97B
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541883; cv=none; b=DBowNsurGzqpd/4NWAdCuz19/4fHzJ2iXvzqcAkV4JKWOGP2rplRIggVMXVH6J6+IJZW02lHvd05nvXg5IUrytZWMW5IY4EgWxHRc/Hi15ULQoTX8tPwrJMqKr6rtKkU3BTOed2OW89/Q0kox/6CYVTyXVwYqUWKeaVWCemvoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541883; c=relaxed/simple;
	bh=0bN0EnBBdbYyQANBz9yS8dw/3PfJDBiDshTWe9qJnpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ6twJ6OrwDeL2AHEzRICVck7yzheSLmnapKe+bAjSRo31UFgXKQR3NHxG2nXHqxJWQK7fH8BflcikElV1UXaPMN/3CUiKsJ0+rteh2vXabUFQ0zrDPJ1zFwYyjdZRPuqQMp+lE+fve4YU+88M0aNj/Fkm2hUVB61SWBNQi46gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elcj7rKx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elcj7rKx"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b220ddc189so139693385a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541881; x=1763146681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eOBjMiv6P6hj2kjZiwRIukuUzRhi2vYrZmFErSdd3A=;
        b=Elcj7rKx58vdzcoWbV4X4jbwfxtqxXVTZtm07IxbQtKH+kOBqvDu7xCcJbQG+CbzSn
         JN4p+MCiXJG0LsqTiCFsGgAnsQpa8UUCFHZO9hnNRYhM7rVPTeWAdOshucZpjekvkuRC
         u568MwMd+F7NpUlAWZ7hm4atZQ2gG+IFX0jrfuwdLtrXqamwqX0vKL93XPKMqonU/Itb
         DWs1C2yr2KzG6M6Hss1S2JDGEq2mO9hgoGIednlQAPyphT4v+pz0UJ2qfszc8umLWRgR
         zKwsc8e1x+2+Pzgfb6VZNadSQs0NuHwJ9dBDfpi5m7HFDV1DF+cfhVKYn0v0hw0xfZpW
         uj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541881; x=1763146681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eOBjMiv6P6hj2kjZiwRIukuUzRhi2vYrZmFErSdd3A=;
        b=EGNkVXbk8TB4EVm3zmPAVY9PaXjHOZFbArO4HAm1NAHje5jpFvE8aMBmyGeUHp0Az6
         BbD7JiHMzBNjD55ZxTh8oY7c2E1GWgLzmej0Pa+BEhrvYcCW/c7vi7l7RJqxybHblI1I
         FE7p/6ffG9Vft1qkihEfHbNmkQ9v68a7hA+kfVJzGKDRt5FDFYjXCiHrfqUlqrQmJ65s
         tbmtebexpdSuPpvaOh3kQwksmQCGiNIvLT4zp7rRx9EyiBbA0YHuFPMpeK+V9y3KAsfd
         rSZUNHyq7cHo+uu+hZ3SOXonOWw0RHWsaWfOj3zcXScE46RhGxCKc6m2kd+y/cafnVVl
         0png==
X-Gm-Message-State: AOJu0YxJhEfIY563FYGeeTkzRfBjqmWJD/r8DlFzpPkKCAcdFbsJN3dx
	Rmyd28b4k3uQW3FwSU7NxuYEzzhOSgEaL5+ch2EHEH+XdnpyYpqm78JIZfB94X8X
X-Gm-Gg: ASbGncsnNjRTw2eabXRHfFCTIrIEYB85QKt7fxArqvPBl52IIRaqgTERoqVThf8ZOLR
	LfmbS7ZmDTuR3er00bUhBXFosLF8K1ZiLjht1vAhnxH6YlQJ2lOchwmrdISFGkj1zCvPpY1mxGy
	8IjpZE07knii5nq7zFQYKMi5cRs63R+kL9OmWtixGQ+lVJL0TmUQtWo7k5K82LNsXPD6S0uOVUd
	K6tw7rhpjIFmlULbiaFubTjxyat5dK/vsJEmji6sha6F2n4Lyp6SH6N1qr+87egjAC4eHR7swV9
	A7Gm2ozbv5+WVRNNonV7T8ZUEUulcXjQI3fQ5AizAJcu5pbUlVdKTgVLRKulDCAiHCBed7+UI2x
	/zKZtuj+WpG93MJJKRnX1S8yXRZVUo5jrx+faQ8GZtLASiwMJ12AE5hobNJDJfg4=
X-Google-Smtp-Source: AGHT+IExsE/YJ+4lJN6MaaOiLye3FnvWMFOroqqt5E9pDB7NewXassiAcdAw0Aqyi0xEUFMyUCiA5Q==
X-Received: by 2002:a05:620a:a503:b0:8a2:4d02:eeb3 with SMTP id af79cd13be357-8b257ef6348mr36125485a.11.1762541880658;
        Fri, 07 Nov 2025 10:58:00 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:00 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 03/23] tuna: Don't start the gui if a display is not available
Date: Fri,  7 Nov 2025 13:57:12 -0500
Message-ID: <20251107185732.23992-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is intended for the main branch of tuna.

Don't start the gui if a display is not available.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index e953869c4f48..f37e286bffdb 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -736,6 +736,12 @@ def main():
             thread_help(tid)
 
     elif args.command in ['g', 'gui']:
+        # Don't try to start the gui if no display is available
+        display = os.getenv("DISPLAY")
+        if not display:
+            parser.print_help()
+            return
+
         try:
             from tuna import tuna_gui
         except ImportError:
-- 
2.51.1

