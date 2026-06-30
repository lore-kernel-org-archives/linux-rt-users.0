Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FA3C4B83
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837925; cv=none; b=S0cUkb99qfncF5nzm6g9/fuT3WoLQGUfLMaKX7TH/NfNwN3tt59xRBxY6Ps7R1g6dkfUmIo4mwjIynBZJ2g4sANGv96wpZANaq8YX11xk5OGu837vWTkqWXaL0ECyZiMONmPrk6PixEyWmsHjE/792+aAFlkk3N9c18+uK6R/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837925; c=relaxed/simple;
	bh=RVKT1LcUpzDn+E/SqzlWJNY2u+bI7LpXXNUZuo3IXUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ul1IfHWGFi2MlBHIyxK/m9XAQfYP5UtmhG7kTX8KCb70w7gmWnuQNkhBQ/43wpRL5AWqdsI9yUy5x/Nba3jcVzqPa6IVWzM8w0H7XdVT3vJQ4dcx3ollDzdPtqkYT2N9vxlDNTvCW3YSYHX2/kRzGkOwKVG5GO7Ry5gTfsd3670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUfT/Y6P; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUfT/Y6P"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516d0db9372so38057171cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837923; x=1783442723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dW42tBcjNFFqnLwh9kt8SqsMNISWgZWdYsjn3gcTjDQ=;
        b=aUfT/Y6PrQzIFO1xfav84z3uh8G0k41zi58mZcZQM/SxWopurIxeJiuTlumijWk+Vo
         G+YXUygH/ovXy8RuutKdi5KeRVBaXXRW8awwrKmsLD92+Sh4BgudE81H5glYjqlfTlby
         xpjGvPG9qxeEy+XZmHUygXs+DNqmYe7UoNi0X/C1Xcp0I11rYdVMwMe6t/6Wvn/Q44XR
         diFCm+kda4cvDfjm5jq0VQJL++XvxvvGZ6zRKL41QwEWGxiRl4uhzpUcKrULfs/C9Fi3
         3TY0UPkE/2FQJimGJLUljrGaU/LiUT1NSXynDqtYf9mOg8es5SSKXmGqGJ8UVs92bBRo
         p52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837923; x=1783442723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dW42tBcjNFFqnLwh9kt8SqsMNISWgZWdYsjn3gcTjDQ=;
        b=QdEv6/pqgpfXSn7D5yVmQPGlnU9yK95wKNBCkH7FBaXhC+spU+rwIGDIuyHpIQb7zi
         WFQMVfKRhxwPRHbyPowLdhSqu29PRWmCqwd4VdevrI0ozYaWj/t+K+egObA5qmrJA1pO
         4Srfvft9o2wLo9nNul4JG6g89A7e1DjLnZhH1IZrkFSWOzL/6ezHOUmK8z4DRjdaj88E
         rXN6FskUiNxq209N/P2UlYF2liCrO6/rmXWVo2z/3hn0jl3lxCb9SP9HYrV8gigImUOe
         4Qzhd7L27RWSsODi28MpLN+O9k4B3Z3ScVTnrVY3FHYeGac4RDtnIx0ji4rZT1N1rJ6Q
         +p/w==
X-Gm-Message-State: AOJu0YxoDHHRz7a8d7wi2LsKhaukM5iS/f2rrJo1iJC3mezAzEyElv3t
	Saq1ymIvMVT7Zp/nxo3ATk2YtGqDJjUW1kKQGrvUvgQqtT7Uu56F6ad+Rhg0Mg==
X-Gm-Gg: AfdE7ckFnfg7gNkJudfUdxxaRe5+SjC/hDzTBwkPALXZs5MJ+Dm4A0oHbTWeiX45n2J
	ucvGLyGuOevjfsTnB7YldCVHZ2m9q5lD4VClxgmBvRub+dQ5l2tVYGTvW1Qfx2l+1tISyr1ca70
	mMRSLEiVa/VOpKfi54/oO7gMdFPBYfAlLNIBGzIQB1mT3UwvGQxLw+pQMGrlSI2jF6ty/jB6giA
	kednKzsdAIXeqvL8fLMoZ2d6v1KQWsS9t5jBSEdOcbs6Ffl9v7Kb6RTUOuvQJCXEoaDXbje2trg
	24nz7Y8JsthktppirEoQGdcPzM+MtQg4L1PgdPNu8Kx4MA+zR6nXkypiSYJcRRC1cEqpoixP86F
	+PziT5bVU1fXMTnZLLK7VwJxu49yHst+ijZBMxi7Io8TkitZlBsNk8yle8IGd+elTcPnjliMFEf
	rOJuI2ZK5h23NwTmCbhNqouNo3sQ5hDNZHfRaoW0aOOpanIBVwG7EfI0gOISoYqd6FPhYeTfWmK
	AKBpkkzdQ==
X-Received: by 2002:a05:622a:124a:b0:51b:feee:b08b with SMTP id d75a77b69052e-51c108b7396mr59070041cf.45.1782837923156;
        Tue, 30 Jun 2026 09:45:23 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 0/5] pi_stress: Bug fixes and improvements
Date: Tue, 30 Jun 2026 12:44:57 -0400
Message-ID: <20260630164502.95740-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses several issues in pi_stress:

- Fixes a critical deadlock bug in error handling where inconsistent
  barrier wait logic could cause the program to hang
- Improves input validation to reject malformed numeric arguments
- Enhances error messages for better user experience
- Fixes cosmetic issues in debug/error output
- Ensures proper string null-termination

The first patch is the most important as it fixes a real deadlock
scenario during error conditions.

John Kacur (5):
  pi_stress: Fix inconsistent barrier wait logic to prevent deadlock
  pi_stress: Validate numeric command-line arguments
  pi_stress: Improve error message for permission failures
  pi_stress: Fix error and debug message formatting
  pi_stress: Ensure null-termination of JSON filename

 src/pi_tests/pi_stress.c | 44 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.54.0

