Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505C339B2D
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540031; cv=none; b=uyIeiEHhnyzGLQlE7J4sQjVtZELNsuNl1rNy2Onu/739Tn9lphs2A7Bzs5+c4rE/NstbAQUHwqaksL+RGH6VGhIEjvbKyfFgfLaYnBI53JB/dMuQ8oSh1ffaR54R/AFmAXzzUBcPN0biZ27rHVAglNIObEgj9lnS3n8yG2D9O9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540031; c=relaxed/simple;
	bh=iazVcM4xrfju6a38HS1hN5VlagUpQgLLVMDF6gqCa4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYypyHA3r07rDdqiSq+Ev9iWRkdzybEo8jVEfu1knOhDDh8d7ReBE4m3ASza10pVYQl541qBfNoBmzymsbhMUPHD8SKSLPKT9EpL6SRC3L3iXUXUa+/e9+CrjkXhgt168rCgLm0T36Do9kiD+pEfMoXF+fAVg1iRR+9UOldJAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCzy09XQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCzy09XQ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e8a25d96ecso13643681cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540028; x=1763144828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWJ9VDdfhet8+uyEO89sH+apFrKo3R1ARXJJPv3uP4E=;
        b=dCzy09XQv0n9yYzHkaJ4RG0GSTV3tkNJwJIUmKvgkkpVVxRnTKHsFWvj64Kq3M+TWZ
         YW5i7wQlmMN5sIU9CNaZk4RfYkzpZcU2CB/EIJyx4bWCk9QyS0ouLEwrdv+Q2zlX8VKE
         toF2Ypza3fUHifQFd8UJwjVk/99Vzhv0THZKDP2L0jSQ5NVTaNdJYKfHejEPQECqjq5n
         m666cKrbWTZsKJluSkmFgoPI1j0a/MPGMDnyHkTwCDYJDbahc9UgBbRVoETIJE9wAHKF
         h3fJTfPZNFv8On5iQJjGTEwCIBJLhK9lmgN1uOEvEar3b31uq5T8R+kV9g/e34bofTfg
         8cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540028; x=1763144828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWJ9VDdfhet8+uyEO89sH+apFrKo3R1ARXJJPv3uP4E=;
        b=tGOAxE8iQt16Qo8OKFX04WNwRIiykjmFqmT6ANe/x4GuAq76u3kfr1oL98o8MwVGD+
         /+ZdPJz975Rtcpqd0SRLdkDzWueMx7jJ7hIkY9PMYL3hjqj0vVgL7ijkymRqVbdVc413
         xPh7744sAce9u/I8RDqejlsn+o9GX8QC7Cqz/2CLY7KjswsfgH5bGBIPOMDppD/YVaO6
         FSnTcsEZakuY8IULR0AFulw+9YKdCJkRbPBnp/ZrjtNmgDdQajH4r3BPbdagLYav4eJv
         n4829Xda7MO4Ig31JVK3ZG5mp8/hKmBH5wwuL5OLXy7POQOt9ZsAxZtV66OUIp/kkpox
         epcQ==
X-Gm-Message-State: AOJu0Ywpbo+JysgcY5zTnGi30SpjJf+MzYmUV0aY9v9Y0PGJymLKYdal
	6SwblrO2enf/ImYsnn5jr0LWZ+GxOYXwxRIGnnwfY1t+Zo4NeGmCW0hitMu7gYYG
X-Gm-Gg: ASbGnct7CVLTwTwCVTOdtr+ffnYRKL/9B++MON4zrlXU/XzhcTuZsHfjFuTDEHK1w6Y
	22FXFcgZblfE3oK79Vo7VVxiXUT+cys5qmXVtIq4beSdaQBP7qzF0oUNachEAJMTS5XXGy/Rgqs
	04FUiwVZtaUxQ1lS35GDIwyJHbWZe7c+fG6NjJaz+RtX/f3gfnKveOUufxVs9gHKSZiFx2HEwAq
	eczp2+69negKLxRelcnO3sUwrBkds2Wcxk6Si4mkGLq3iUNct7OXoqpL+Z2RU5c5v5UOxfp3xjA
	ZHw1GXbp+gsi5AWY2Ck7eMvrZZ+8zA9ML+odpXJtVsKVS1FVSOgedrSiD9Y4PJeDpmp9pa8bcqD
	zTLCBks5mLkNHl05nlrAtINL+SsNPAcrXE26QFqSnmJxBfBVyvMXsiPZiqEjmtp/moSvfD0f3Mg
	qsKoKvCZQr
X-Google-Smtp-Source: AGHT+IEhQB3EtCzbPYK5U2cJvhe3IjyziKvhFvx0vxWW/HBCuIviJxoevZsy6g5CijKEJjMJ+zkNVw==
X-Received: by 2002:ac8:5d42:0:b0:4e8:bab2:9e0d with SMTP id d75a77b69052e-4eda4eaffa8mr1229181cf.18.1762540027720;
        Fri, 07 Nov 2025 10:27:07 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:07 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 02/12] rteval: Fix typo in comment
Date: Fri,  7 Nov 2025 13:26:25 -0500
Message-ID: <20251107182645.19545-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed typo 'summay.xml' -> 'summary.xml' in rteval-cmd comment.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index 4e13d312a24a..b936ade23d86 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -68,7 +68,7 @@ def summarize(repfile, xslt):
         xsltdoc = lxml.etree.parse(xsltfp)
         xsltprs = lxml.etree.XSLT(xsltdoc)
 
-    # Load the summay.xml report - with some simple sanity checks
+    # Load the summary.xml report - with some simple sanity checks
     with open(summaryfile, "r") as xmlfp:
         xmldoc = lxml.etree.parse(xmlfp)
 
-- 
2.51.1

