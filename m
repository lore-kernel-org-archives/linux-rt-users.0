Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D233BBBD
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541891; cv=none; b=u2XCKi7hgekA1pr5u+PL8mn1k4+UcbQV7aTBvktk1xFmw8tjcKfyPkgogVTQAyZED1ht36UhNUMdon3ng1mUeO5JLWtnI6twOe2ABQPLuk1ctw32dwhKJPR4U0V7YrGGj8YkAAiWKpnjtchVutFMKrf1Ynhh9o0AeL4slaDj1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541891; c=relaxed/simple;
	bh=2idhkHiCkzn1munMZXazs2rThmW4kMXqMESP4qRT8t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhqcwK9Y+fgixjurk6hPF8MUm1BfWjQrwCE/REH9MLLxYULh3PB0zX45FN3ROVwZPtpH0n87Oa7ACqw26IDSkFCGa7PGRihHYT+/3hww6wmIzUg0yIENSZ0uwy0n80NkPLYae27pR4UhCJknFxeQ10XM/GY/zRZ0ldc3zpUGe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdQveqZp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdQveqZp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89048f76ec2so109393185a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541888; x=1763146688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=124A6PGwT0zr/HJO3Ek/wYlRD6lJn14sA253/warar8=;
        b=FdQveqZpOTI9aEW/rrKbCO8k1WtyeHBmXlHNMxUbRk5tUbvXJtsLniX/iX0JFGL2Y+
         5U0bRsmrXst9zPjvFhRsEdrzzi5gpnnnHoyHrKbgdoi8SQzJY3bB2BNlScU5cQeYxu4D
         cnDEfFZrApeCux2xbOUcD2wKoyZBTkphRggDnZbePzxd37sWLkPw0pBus+AUZxvuE+qi
         E5TVNoVNZKk+1Jhw8V1Ab+Roy+obSIsCjdOFviG7RQVKfspRSSqD/dEWy24kvl3aVtU9
         RYtcgeZUEpHO8g98jOHsTkpiYFB7xYRxubLJcgTWqiooQ9yBnmIpyRbXcfEw4EJlnXdl
         bHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541888; x=1763146688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=124A6PGwT0zr/HJO3Ek/wYlRD6lJn14sA253/warar8=;
        b=RyJO384qU1nqusRti18K2JHI0ob79xHIdfgoPfu4qmXSIvWnYl4InzSF8hSkiLRGcc
         3DCEWhdQCVNFPoCg/YZcD2ojsrpJKlmnoW6gdEan9Sp7qSm8PSCqWxycJSPtTxuSZQ0z
         3l+W2vRrbRgesuzbvELj+Sn9wDe705VPCXr1YQ6570mZ6csGnaZZ7+K8lueE7rPzGr9m
         dwZj4AcggtRKttlaHNbowLDlfXxkSo9EVS+9XF0p3YwszUUtjEVdm9hARq2PSCNUGA2H
         cDOPfOiGMOlBgKyIMLVzVYfDREo9nI57laKXI0R+ivKKZ1P+RAtAPE2yKC7LUh4xlQhP
         I7VQ==
X-Gm-Message-State: AOJu0Yz82GXuRQTm8K937/V7aRMtEeVxQ5NiqeaXLSf8GSjf9/CAPt/a
	C9dFBJ6cSFVUSkrHp7m0T2yVu9bJriqJLhzMiNkCCM4d2smTVzb6+0LB25LR3m8r
X-Gm-Gg: ASbGncuv/xF6GLezv68221KLYtu5NGKOEE3qo5/TLw2BSWcfZOY55tkMsbfNz23aKxR
	xmOgUV2VTJn282aBTCPrGVIHBqit9mLs88Sl6nFZQ0FPOZ4J3cfD30Mgi0fV3RlVPfoWLcN3+JV
	wqaF9u4A2fdc7cM2YxrFiiqM1IM38g8QUz2Vqw4n4YgV08UCFoYDBlhklZu3xomPvpW+xDEl2DI
	0zvaOqkDvAPgp+Y3osTQ2Qh2HiSdGrXUIOhl6vFPAcchdDjKc7AsvRNpHONyNKjx8cJ9/myjlk5
	FVuWiCttYvRppro25YQNZf7vtRhVlXLh8oyPpCSZX+aPAOyPOqbdoP4B6yH5Hh4POfDW9n7hv6j
	P+AmMALg41vxtjhZ9n0DTzSXkKBJeZhci0mQGoMWxo3w9omwI1dPGHrzP6JPU+jE=
X-Google-Smtp-Source: AGHT+IFFrRgKFZgOUmuMsw8zNC+vego6mrEhZLfnpPZL07pb1a/WDP/2id8stYoQBhVxTbZpcPycSA==
X-Received: by 2002:a05:620a:4723:b0:8b1:1cd0:e710 with SMTP id af79cd13be357-8b257f03a49mr46088185a.25.1762541888479;
        Fri, 07 Nov 2025 10:58:08 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:07 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 10/23] tuna: Add Pyright helper
Date: Fri,  7 Nov 2025 13:57:19 -0500
Message-ID: <20251107185732.23992-11-jkacur@redhat.com>
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

From: "John B. Wyatt IV" <jwyatt@redhat.com>

Pyright is a common tool to assist with linting and finding errors in
Python programs with an LSP like Visual Studio Code, Neovim, and Emacs. _("")
syntax convention is used by gettext for translations and is a common default
but Pyright needs to be set to not give an error for it. Add __builtins__.pyi
with the _() convention to satisfy Pyright.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 __builtins__.pyi | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 __builtins__.pyi

diff --git a/__builtins__.pyi b/__builtins__.pyi
new file mode 100644
index 000000000000..0e3a4b2d50e8
--- /dev/null
+++ b/__builtins__.pyi
@@ -0,0 +1 @@
+def _(s: str) -> str: ...
-- 
2.51.1

