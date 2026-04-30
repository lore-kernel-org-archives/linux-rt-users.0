Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B82DC32A
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577536; cv=none; b=do067uR+7ykri1KFaln7Fq+Sz2Jd/70u6zGkmU1MMtAOcvMS1w58TbJEQgA9Yr94RIydn+PocjgXRypVULmtT+Cobq+7r3CShjb/cbeF6gt/LnJZM5pQ/yt4qIsG8EKHWgSwY1IJQcrIbVgY4n8hH2tmJaFthlgf8ZU+DwSrqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577536; c=relaxed/simple;
	bh=S16Ah6BHXsMM0+LhF2QmVp3sRGwn/61qOQGqzNU69WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyyaimG0wZs3VKxpma87h/5O50202vKiVApUEzJLIgi28X6RbFtRU4esDPN6TeM2VNuH9K2cxulSnpCkme3BfK2HG9tPLXOIuDmtaQA5z6HngzA6nTy3KRh6yYnFB8y2aoPnciPwmAuBSu7Z4L4F/w4Ofzd+BHUSr1giT7KXFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIl9N7cz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIl9N7cz"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d67a483d3eso141107985a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577534; x=1778182334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8X0Nqs3tT+K5xD/91WHirpS/DehFTp6ViOb67gT66w=;
        b=JIl9N7czZx3Ek/bJVNn/bW5YaDaSa3l3sHvmEtk+a7HNl6z6HiP/AGfvJThS9dMg9T
         gj0SS/RHRrwl6ozHnF9btGWk/FDf5Zn1y8Lpb7YdAln63ro85eLUtVcZNSUUsLRtI/5Y
         tw4/Cqir3MZZl9K4bgirilOgi6EiC8c0GzHJLDx5NoTLhHoI+Nsbt46AAj3mVnH3/2hQ
         SuQheEcNyp7OpimTPudD5pT+iscSZbiRqS/kSWhVESYdN8jth419lL3wL9CfTXpDMGa5
         E6xF+YJowVE7XScgwPdt9xwBs9L3cMdTbMy0blWoUyvGnr+X6YFs4+1EbRKsdM+uNoA5
         NNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577534; x=1778182334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8X0Nqs3tT+K5xD/91WHirpS/DehFTp6ViOb67gT66w=;
        b=hqPSXPZ4T7OdOaCHXddTGBmz2Bps9eYNgNpJE9hDI5qnRKYADTQbEGbcOBsLGruGKZ
         qUAqigmvLIyX7Fx8mkxWkx45JyKElZxfCfcb1o3RkDwKrXsI9SDkFjfvlmHOqAcwRKfo
         mTxKVTDWAJzQV+2mEdHnwUuwK9poJk5S/tJTuv52zflfBI5nQ5A3nZz0MJySn+HsGpd6
         f3S+RNgoaXJZIxFj7jHCXdpeG6r2S/JRJltP75UHr8Nb71oAfox3bNJmgLOPGu6EsWvu
         XEMTk8gxY1aJpClq/NML5oAJMVXEE699xDqJlTjXtUDr0oVJ/pWCV4f3ham1NY1v1Dib
         hHbQ==
X-Gm-Message-State: AOJu0Ywudn3+geC9EdjuXaSBDyW3gE4+6jktJRluy8clHE9qHon9jzIQ
	phjmfbgQbnpYbuUZ7csRgwmbFcP0Eqw/mW3da7QdQPjQAEG9HQ6iqigxXkMHmw==
X-Gm-Gg: AeBDieubTdzAzms7DDvZ0hy8Tc+oX5mKqc/f90/0DOT9GD8IOdlMbS8z4bdusqdCrDL
	KUpoWS4JEYLaI+r84qI/Tmj5YPD6PTHlh4I77TVAfWAZ4Ar1zI/U53o5pLqFAHAv9b/27/yn2VD
	7irFKXC0R/N0vRq0nVmwA95c/9XbMrlMhqQnPmp3PXQKfgp/Z9BfOOSYVLUVseMsMLZNGV3FKZ1
	BlE2N5aU4mKjcF0H1PSL/LJlGEvSD3vIJvfTYe4g7/cqAQR4kklAp+7tmBi2x6iKhUT13eHwIsm
	2RzTQvoBl0GSichfaNrCEr1MCjX/QysmRZ4gpdErjGEZlDx7V0jtnFJj6hp/94yWO55U2jC7fFb
	UsjSVkVmUGUSDEL1J2BiTR3r58m5UEE2Wv7SYifulwtdq8L0DSuoLc/ieZnfIlAZvBga3y54yW8
	GY1kVIv2ZRNTkREDJEFPDqH7dHxaVD4lKSk0XQwejL2FVie7sIdWtWDIEhELjQKyrVgZmHfurSy
	LBhZNGc2a5WyEm4q6S2GSEi6PPW8GpQoH0MovVu
X-Received: by 2002:ac8:5ad6:0:b0:509:4406:44e0 with SMTP id d75a77b69052e-5102ab52a6fmr62564321cf.27.1777577533535;
        Thu, 30 Apr 2026 12:32:13 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/7] rteval: Add local/ directory to .gitignore for development files
Date: Thu, 30 Apr 2026 15:31:42 -0400
Message-ID: <20260430193144.354599-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add local/ directory to hold development scripts, notes, and other
files that should not be tracked in git.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a6e940186be7..ee5621e3fa3d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,3 +28,4 @@ MANIFEST
 stamp-h1
 autom4te.cache/
 rteval-[0-9]*
+local/
-- 
2.54.0

