Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398B40A956
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152982; cv=none; b=szBfBHmmLTdaCW4loxPSQ7b/Ngx8Q60EapDJ7G0yMQMknYH8z66fWJVaTFl5tO3UtIQZox45ad1lLKrpig7CHHrKkhsI6+yrk2yCIDd+ReBo+faPcaYjtWcS7bNooqKsdvempJXs2DkGO6XaLPAtECzml2+tRnZIc4Pr5QbQhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152982; c=relaxed/simple;
	bh=28a/aJMTzqQ0s6+iypvWek4AcYQPcoriCPt0aqmS/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO1V0XxYIRvgBfLrI4sqyW4zrr4TEF6D734CTo6ivjsgtdIB9fljoGjWCXmPVvh29+iZpqWTL1W+FPnmyjhBotS+/7CFzjaIWCxLm31gRbp27mJsGhyCWOLwipSJ+0VI7GIIP8RPpG3ZCxp5IXK7CrI4y8WwQgEiX3xMB4WVkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpHcEEwt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpHcEEwt"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e7bde5596so13282996d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152971; x=1789757771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNZy5+rVjI7pWaCFt46CRxvMxRoeZThW1UQTrA/8Opc=;
        b=CpHcEEwtteBzx/nOZcqqGn4PLo06w3rc2JWKZuntXiWZ+e9n8afkqQ3sv+jC8AxiQo
         EiPoOWC8tQVDOpE0YX21M49MAdt+/TtzzNBUZQiEv5/Htx3HXwbXZiGYbXdRH+Y/DH2q
         dK2iuqHaWBrCwzt8UKNV49UZH2Tj02K+k+iBxneu5adfNfOSksHnDxj9RLk4VCu4HQCc
         ns2OPl7Mrk1kE6o8oWcl+bJr5oTDWcujoVS68EKflJwSPulna5hvONCH1hWT1ZVUeOUx
         CPh4cQHptfi9afcsW6dmWwj5wZzEtK9SFCLFBg2i+1lsAY/WakZxjYW8RqkiKxFIqYI/
         mFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152971; x=1789757771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNZy5+rVjI7pWaCFt46CRxvMxRoeZThW1UQTrA/8Opc=;
        b=GDK2Ny8gRWYXdotV1zE25DSAcAWgY3ITUDEONj86dOzy3dBOlqv7GIVEk73VbnAYng
         2KiJaETJ9YZ1Gc3RBASfmU0FoljlV9d9LSeIZHXGIIIPN3iG4PnGI0afiA6U+qzPaI0x
         bJq4jWF6hDbxtyrOlmRJDBesd3ZmiBozjlZ9U5d3EoQF8lUtb+9MdP8LJupxKtBPSvb4
         NcP4PR9F9HXLI8Ba3pAAu60lF2EHpGqDlixexM+v/lzwrOBLx0IFH+SvqYwLb5TTfqlW
         9iHy6s1c1ghgfudMhwZBLvp+qHavIxHcVo/SeoZUO+PPloQgZPKVmEU6tN8Valj0xdEs
         JOVw==
X-Gm-Message-State: AFuF++lKSuWiLvuZiVkqWxt+OQPwMB/kL3KXz+4zlQozIWR1WNIX1ejI
	xiYmNetxn8izSYjd9GKWOr50e+XZi456tA+0W25Cpw67/O18S3ZN0zoUYFVA2A==
X-Gm-Gg: AYBFou1GDnMirUFteRIRbm+uVA1kQVzfYbgxuXaFGeCu6N/sFXVgSNU8Q02k/fh4//p
	aYZXckci2WkrKnyl05vbMsD5j53euDUNqq8xzY7Uj/cRUfvd7YNXNTYSzynJ9MXGsk5KdfLegGH
	o7Fd2VWC7xGQL0LH55Z8IRjoOzjGGEj6YYgbH1l2qmXLoNAGwyZwWrWjmOS6KSf2MuUDnKWzG8m
	THRIS95vQHEzhCixdOeUin3/Cx3J1uJ9bIBKcgfdu2AKlpGVHVrANmgyRDs7FdIN5RbEc1lphr+
	xKVkbz4RzzleN9wCYjJHgEaWy3gruz5MAa5genzN4RkNVn6uLEV5EynQivKrB7ILGdPKIIxcz9W
	nbrna0AJIIM9rBsNFD+RNv+7v2oWUPL4QV70zvc3ruh1EAPUtzu+Ph+8+u87zfXhQy1fEBhSZP/
	QxHbAAjNixucvLCSglxWWGX76jEZDl2lK0ZrqUh/qFE/4q4Ca2xexfoDb2wEqsGaIy63+1kCLrb
	DSum0c8UcLxlEAioJd3GNocoHBezI7eMSZOC44ojuU+nqqqUSY+9D0gBSa/PoCk
X-Received: by 2002:a05:6214:2b95:b0:910:70e1:e73e with SMTP id 6a1803df08f44-91212113f7bmr75911246d6.36.1789152971078;
        Fri, 11 Sep 2026 11:56:11 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 06/10] rteval: Ignore *.log test artifacts
Date: Fri, 11 Sep 2026 14:55:39 -0400
Message-ID: <20260911185549.604199-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regression test suites (test-cyclictest-error-handling.sh and
test-timerlat-error-handling.sh) write test-<tool>-<scenario>-<pid>.log
files into the repository root on every run. Add *.log to .gitignore so
these generated artifacts do not clutter git status. No .log files are
tracked, so this is safe.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index bd20ca2f4a71..d00862cdeb0c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@ tarball
 *.gz
 *.rpt
 *.xml
+*.log
 *.o
 *.swp
 Makefile.in
-- 
2.55.0

