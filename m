Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55D238C1F
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Jul 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220241; cv=none; b=gyibCjBVuOlqusDzam5dKHqWMB31F3dFYZZks5vNnCTcZhs2uOSHUxjQbQTCHUQtFaEZYl3cqOXv0qrEO3Xk2b2T75/Ay/+pQ8QWDEWHCSVyBQzT9xg+Z2pDwC1U2KrocaMT/GQbD+n03oTRX1YFy63Q+ThFpPPj9A3Y5HKBCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220241; c=relaxed/simple;
	bh=vCZaw6xUGV4JxBHjpvgT2xt9QO6zqrtUDtcGQ5slm1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eh3fZxZZD+HaPDDY34XaJGCVMKsE8XHDw2eklnQagATyJDNyeKw5Y49mDwKaor+bgftzY9Iii3i6TDqNZy3lQcGqaxt3hLe/1hLoJJM3ZXn+iscTsiahnycxhqTtIjYDbWBiRWE8GDv5kf+6i9pkcES9e3CZ1Ns5nJIlPnu+q+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGSr9W2y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGSr9W2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753220238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h331okJKtMWFnWbWONln17u6+BcJ0xQAwsJUPVl0SPk=;
	b=fGSr9W2ySesOj3bkWtQS8+TNlRbIJt35NwskROcMKLJEJhlWt4xnJRPGsZ3djZFUiliEI7
	0NwpldvXdnQ/md3MNYQrjaYH/fBUDogto2YRzaNoM/hIVGI2qp1tdgv9kv2fl8CKq/38k1
	RYeKiCmuW29NYiY5OFNLbrx2Wt6pbeg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-oShpqvd9M9O5diQeOiVWPg-1; Tue, 22 Jul 2025 17:37:17 -0400
X-MC-Unique: oShpqvd9M9O5diQeOiVWPg-1
X-Mimecast-MFC-AGG-ID: oShpqvd9M9O5diQeOiVWPg_1753220236
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb1be925fbso89383916d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jul 2025 14:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220236; x=1753825036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h331okJKtMWFnWbWONln17u6+BcJ0xQAwsJUPVl0SPk=;
        b=iRQqBrdpJqRr9DbanupRKikQWAxqMoPu11cSyFCLPif5g8y9dhrbzQ4nhuZojV1Y01
         hVjt4jtIvciX/RkPaxBbw1cfTZwhbPfp8ABCnA1uGC9dRzI4UvwTmL4Q14Zhm8hLZ7a/
         XOH/0Yx1htOhitZjg8wtooXxsmY3ix/ETXQeykd2V9LIP2K/7Km1jdf8NgidcnOoqzaY
         yAmEru9nl98fMdVn+V/1PZMzAkyJZ9oobzzdxZdWdTYFYeFC83IxMxN7BWWG5wTtKupj
         pa8eRPsjmri2hQtVtxFaJe6ToJZBAH5ODgGVCri1iLhSY5SyZuNVbEyNXTkcSc5NSJ9W
         1ZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF6zMna3fTT9qWndh7Fp6N0+1w+EJUZOQ1DSlJH6bP5qzulSce7W5s1KovBAYcrRoreOCFRaN4q0xoY0ZcqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySZQSGbbFVkVQASMxDuM/oaa4/6pcnZxkiM/Rtelyd0GBaRyT0
	Y+E7aO43RHu69vmfYouSybwRs4wUvtvM6BRD+YeziI2xy1Ex94FwNbmE6eVe4+fZ+X2PKy023bW
	xcLr1ChPB9G+IUQxNcZD2QSfPFc6z3ep0aG/AUpPu4+7fEbCwUYCusnuhuKT4POOGFkJS
X-Gm-Gg: ASbGncviduuHWk59853EyRrHrS0fkct6PK5Gk2E85u+nL8Cdx4pgv6ye5h0+8ckHRXd
	/Jmj26iHDI9MeGQaPUl7XeYQD8+bOfgyH7Jx8RAqN1puUptqtlZD4Xgr8No8yiaQEHaNpeiyxjN
	q6SZTbm+wBxXxqlXLaAJB6D5B9Pq9xuVYBtWJg8DgL/vnt9Q6kttnbn13Y58rbeMMHCYiVJrQXh
	PZXR/zW8k+RRMG0fFo9dbwjNjdEKIB1Ze9DvBKJXNlw+hzMO/f/3fq8rRNZf5m9FnY+uJZUlqve
	6Da5nmzGAsI6s0ETg3Kpxhv9HcDjiWnLco+wtTCCVIQgqVrwBgQ=
X-Received: by 2002:a05:6214:20cb:b0:6f8:b73e:8ea5 with SMTP id 6a1803df08f44-707006791f0mr12695106d6.26.1753220236445;
        Tue, 22 Jul 2025 14:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6J79wo7JY6KTxJreqt+ytCE4uw46vlzRJMCAIfG0MO987Bv+Gzo7xNP7WnjafSwazpV3UPA==
X-Received: by 2002:a05:6214:20cb:b0:6f8:b73e:8ea5 with SMTP id 6a1803df08f44-707006791f0mr12694806d6.26.1753220236143;
        Tue, 22 Jul 2025 14:37:16 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.76.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8dfd22sm55321696d6.24.2025.07.22.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:37:15 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Add Pyright helper
Date: Tue, 22 Jul 2025 17:37:08 -0400
Message-ID: <20250722213710.14464-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pyright is a common tool to assist with linting and finding errors in
Python programs with an LSP like Visual Studio Code, Neovim, and Emacs. _("")
syntax convention is used by gettext for translations and is a common default
but Pyright needs to be set to not give an error for it. Add __builtins__.pyi
with the _() convention to satisfy Pyright.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 __builtins__.pyi | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 __builtins__.pyi

diff --git a/__builtins__.pyi b/__builtins__.pyi
new file mode 100644
index 0000000..0e3a4b2
--- /dev/null
+++ b/__builtins__.pyi
@@ -0,0 +1 @@
+def _(s: str) -> str: ...
-- 
2.50.1

