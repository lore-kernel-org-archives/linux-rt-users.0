Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31E26FDA4
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Oct 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041671; cv=none; b=RalZTq3BGTcGjGrlrRQggAtRnjBiCsMQ5hr0H0SrZ2uI8HEn1CHEgI3adKi0Z6it6L/9oaslKBPAJwwOzNPXgAsmv2kAncFgn4n4vJ68P7QudzWDzVCEliw+zjXtoQRie+XJ7/vT5k0btPusveXwQWqbBdcgXSMeLjzVYWfqZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041671; c=relaxed/simple;
	bh=h+dNiEeDY11vEMIvK3PEXFCXYZ9R+DRtk4UE2BAsBJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXfll6B3LyBygxlkfrTqcE7aWpWjHXJfyJjmLJn+6at3E7fOrcqb3pL+EKqtbSX6Sd18aE/fEnUgWUKToTEhDa7ud+NsvdwK/zVvabjkosOYTaPHixAOY6n+vCtfc0kcbhowztWBrIe12kNfRpNHqbyjRfnwp4kF/xrc0ULkzPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGFddr1s; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGFddr1s"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4dac61ed7a5so13761631cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Oct 2025 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760041669; x=1760646469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1+e0F/5RqOBq+uztSI5CooRh4XNIxnkjTkvppYN1O4=;
        b=JGFddr1seD3Q5xouzIKgBwXSQrSCT9ThGuaydn0PxmaLd8EJEPRw7z/FVfAWr6SIBR
         Q+jQbNRaFwlw/+K/t2GC0YhKBPWEIwdmFtF8iqMmvG62JWa6yIEIrXyPFI4e1HrsTYYX
         VhgcM9ctFEnSuivX2QvgelR5bi6ZbPYh3pVlko/32F7ew8bYYuzYAuaFulJM9qZRMX7B
         4iQxU2k6A3Djy56EniJ7F+528BsxA39GV1MfA32zipYpOgn5uuLvPgyHVy2gZUAMTJ02
         7/qC657khcNe39a4Fizpdjqhv8nCIDPWaOyX+kyESTUZ9tM1nmDPqN4SWvhifWob3BeQ
         XBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041669; x=1760646469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1+e0F/5RqOBq+uztSI5CooRh4XNIxnkjTkvppYN1O4=;
        b=r3iCFDJCfPEywDd+CX3v/BNmOVHQomp0XaEGhQbFJBuXqtDhzBrVObciM3wsTGiYAm
         5HjloNm13rx63mEm5CCsdKUD6t2clY6JPASlxt0OgLleL793l7BP+JygVrJ6uBUe3wWx
         raJdLGQQQNsQxygZiD9kW/EwxIvxbN++IcjQlK1AQy1r9eP3JoK3RZJXgqc3vhOxhYSB
         SeAIxuLb8j+KOxyE6QkU5ojz7318gN7iQw24FhJbk4MCnUBFuJJJeORv2dwGk5e5pM0C
         xI/AYEexPNgZTN3gdnY7LHZs/dDLSccSzTy9RY+9p1VtplW+6It6VIhlBVKvrKukpa8O
         e0JQ==
X-Gm-Message-State: AOJu0YwAXv0jGLHGySvdsgB4m656KwKaDZJyuZjAV3+oKfM/pJuio1CV
	Snn6gMPy7sm2ipaGmvB3Wv97y1pCrt9uRHz25ywsZYj/dl+GZlWzkXBvUD43W39At64=
X-Gm-Gg: ASbGncvUVBD8pByTXFRsD7CrfH7PJ+zRAXgi67dfXnN3ekT/ttTolxpX7SqglMUo2/Z
	21M3uvbR3xPSe2IA9jsBR6JO8f726jUVyjNSnlBoKy+AqBW5zNLKSnjRVv+V8WqECNoSdvK41df
	5GOAkHBMPi3Z1fxN625kAneK9YeCRHsUNgSqQi8SqPNRBwiJAPJow1Q1Ra6OkG9KZOje2neADFe
	xMQOODyHF2+jXaRvScX9YRpv/H+jJQR8Rpj1jer5Kyd/GruUth6YBYTFEzJHPquSCihfmZumtke
	yP4Mts69+IWGIGI8OoWB/Q6y2ML8YLKgwoeNs9fE0QpvNUOpnUMcKQLfEBDSZEKqzZEJnH34cS/
	gAN8uMDyrgniPKjUWoJsXqiNikCbz0AmKfEZxhaXDRW8Nqhvu3SuHRKNYjcZS5a0Z+4bZtDODSZ
	y6CRpqeu16OlK/IDCBKJ7DRdF6HdtE1G1i3+Y=
X-Google-Smtp-Source: AGHT+IGO4QbDYQMxPbAhlZnFztLgrG+HjfYhAmeHS8yRHUia0MpuQ/cWAnd/dzaiy1dIrO7M+WGegw==
X-Received: by 2002:a05:622a:58cf:b0:4db:7bc2:92b with SMTP id d75a77b69052e-4e6ead54b16mr134008171cf.42.1760041668803;
        Thu, 09 Oct 2025 13:27:48 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713ccsm2664286d6.37.2025.10.09.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:27:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/4] python-linux-procfs: Bump version to 0.7.4
Date: Thu,  9 Oct 2025 16:27:32 -0400
Message-ID: <20251009202732.57880-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009202732.57880-1-jkacur@redhat.com>
References: <20251009202732.57880-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 procfs/procfs.py | 2 +-
 pyproject.toml   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/procfs/procfs.py b/procfs/procfs.py
index c33aa73cd211..acb205324d9e 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -15,7 +15,7 @@ import time
 from functools import reduce
 from procfs.utilist import bitmasklist
 
-VERSION = "0.7.3"
+VERSION = "0.7.4"
 
 def is_s390():
     """ Return True if running on s390 or s390x """
diff --git a/pyproject.toml b/pyproject.toml
index 01c4866add76..0fd6a0294568 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -4,7 +4,7 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "python-linux-procfs"
-version = "0.7.3"
+version = "0.7.4"
 description = "Linux /proc abstraction classes"
 readme = "README.md"
 license = {text = "GPL-2.0-only"}
-- 
2.51.0

