Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A47339B28
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540034; cv=none; b=SwWJhetbii2rYool0yqQyvItOkzW/ItqJcgpT3uMc+JcL6nPxF8q5LQJkQ6N+MoiOAOYCckLBiFUl30RZEfpfAfoa+kqx17HIaprLi+4vBBnQZDSem4dI26y1ujbA7nCfObio8V+zSHmvNf5Zzxdl+ddpy6pfewQiYEfN1sYtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540034; c=relaxed/simple;
	bh=NN52jyDRh+0IUiteorhKKNDDZsXxyK2O8TnEMj70Vgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVqIAH3IUst6ZDFad7bmmQ9WJMmlH24+5Jnx2tphWDILpfdWXO3JjkwEXmhob90r0F9qNnQouIrEh2Dc0UtCK4PSAzLC4jQRKaD8GtjsDuA1UJ2g1N3WQsqhjvK9GH6Ee28IUgEqbqvnb/JJ2GPeemnglRVpVTDc13zT6OqbDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5sY2WTw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5sY2WTw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b1e54aefc5so90048085a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540032; x=1763144832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHK6s57ws4wEkfgKSKbhDSJMQg8aPzluc52+JTExZnU=;
        b=Q5sY2WTwTvZYtzV6TV7LQmu8lK+Q4PwurL7wn1KfBfg9j5BqF3PnyKa9VKPjvjqHYl
         ZBhXPkQevNIJpg1CBipf9oXhJsxDX4RntJSkFytDEUqQ0GRn6f+GGpZZ6OaUvOgYP66b
         CihWR8dREC2ovBa9F04yrsxAuWmSlC2S+rbivENPEUpgGjpN2P43RECW/URdtbWUVxoE
         G+HanWWxx6PiQwW18Rn3kzkJPxeA6gN7kaiXFDPI1ULg4qgRA5Pw1YA1zARmwt9RsVQ1
         adikvhHTfZWy5vchM0H+4jqTcxLCqG5QgfpCMFnt/mRD5JDok7NG6mtkK0OxZxkxNztt
         2MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540032; x=1763144832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHK6s57ws4wEkfgKSKbhDSJMQg8aPzluc52+JTExZnU=;
        b=G49cpFPtgGGV0XaEpz9QOo2u9Y+rKxutR7fMrFda3fK4AqpniAKMDtfvQjRsb2Ekvl
         QgEAbKPpHKh5UNTD11djZHR1Ywwh47+SdNHk16JI2RskUbfCo5hsGzC1P10md54CYV2O
         IwDfoMFB260d3vtUm50gjnyxq/0c59fggB2OuzdzPBMomy5nwLoLQyobUbmou46nQyjC
         wlWGm/1GSaP+GfLr5f2dy80WgqeQk6PgBuhy+KqVAEJqfE5HXEPBDQILnGEO4N5bC1ru
         qlcsIJiYfRrd6jrrIQig988EOhVVPFDXhhzPwXo5HfPAuyYuPqkdallz5O+l768j7p7I
         oSxA==
X-Gm-Message-State: AOJu0YwBTSV1WvrJrmYhM73fCpG9ZuGAa7EZIZa6sGLdOeIJeyI84tVn
	HHt++u570k/VLopzFtujfRUUEhrWFHPy/Ggxbu+e/Olzi8g54BFoTu26lBMhsiK9
X-Gm-Gg: ASbGncswv4k02nj49t6KYgrfwc5oDuC+Np7aND3ZOO31ORtXp06om6Sp90K9yCe8Egu
	3Fl8pdZ5m/5+KXihbMLlKxwF+ImfnJE7Y4hX4PhfnwTrzXEXO2mVPoqTvnF9aOgU1AEBm95vYqa
	fFmz4ZWxF3YYVSwJ8qY8pcH8XSklDKA3rAfgasfGY7WNehg4kmZyVbLsTLn/ewG8FVvT6ABSGOf
	MsHuOCDfTWiKbf+iSjsKPH6hFgrkFHHLI3bsUD3kZNnS3/EkrFwuI3cXlLMtrjWrq+jL6Bczj5i
	uKLLUvqBol/JsveXk7vttKzAukGGX/LUWDxltLLmeIEL/JjCV2UGYaMTe5JaIr6tWTqzHLWRH2K
	1X0Ux0ULoPXadWtxaqT6q1X127ZFgE5VE/Agp/apPxfS9+06N57C2Hxziirs34BcayKvCYcX2LA
	==
X-Google-Smtp-Source: AGHT+IGIF660kNNzdPFDCPnz3Q2+id6kEvIdR6UhuHKysiw1olnmH7zfCHevQx7kaFJZjf7FbQIKzQ==
X-Received: by 2002:a05:620a:4014:b0:8a6:9a86:75f2 with SMTP id af79cd13be357-8b257f55f5bmr32571285a.46.1762540031408;
        Fri, 07 Nov 2025 10:27:11 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:10 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 05/12] rteval: cyclictest: Fix typo in comment
Date: Fri,  7 Nov 2025 13:26:28 -0500
Message-ID: <20251107182645.19545-6-jkacur@redhat.com>
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

Fixed typo 'runing' -> 'running' in comment.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index f32ad2690f45..f7039ab2749f 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -270,7 +270,7 @@ class Cyclictest(rtevalModulePrototype):
 
     def _WorkloadTask(self):
         if self.__started:
-            # Don't restart cyclictest if it is already runing
+            # Don't restart cyclictest if it is already running
             return
 
         self._log(Log.DEBUG, f'starting with cmd: {" ".join(self.__cmd)}')
-- 
2.51.1

