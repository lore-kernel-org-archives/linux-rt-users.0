Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC62FD7C0
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115731; cv=none; b=LZI+yn+tB/YFJNG7FkIqPB7np78PB8vRxgenrinpYW9txiU22P6w9bmw71CpD2CzWVjreE3h0bsRIq3MKE3X1I+ZGPaxqiHQPfT4O/Gj7fRysO8vL/XvyUP6WoFEvVF38nLAgVNj9h9rKRjftB5C4/morMHaQ5Of+BJDQTyd9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115731; c=relaxed/simple;
	bh=QWQa8C1UGjqNahvIxv2tMVSOe5pbO/dQgT8g3w+VOno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L47QTzXHBpMZnhlYzH6gpd5Fizqc5ph/PnWVAkl6ByHCOHLDKXsbXj5qpTL7dFXrmKKn8moSb4ItemcSeczwgkeCz4y6u+UY8w8QUZKIDs5EW9hb1BF9Z+QriNjSYyHoiKXSGzjHF0Cjlmfa2+/AXyV2Ke970CsS7fH5CldYLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqf7TUGz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqf7TUGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5pOuO1duU73MwDE/1tAdCEac90zxzSOOSRsJ+gjwos=;
	b=fqf7TUGzUQj+1hJp7WoBxHot4DTvqHwDL0KAJSxWH/Qikt5tggdE2Ochl8JCKYuaB0vGKD
	30m8sLi34WXsSyFjTmxoCICt3ZcO73dMQDjjE5YJo0+G9RJ2y4Z+eKthSHC+3UUghd985I
	VXS/yRHEEcrRkLosH0b+0sCpTEgiWTY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-t0fbEyc9OT6cVFaoTFTfvQ-1; Wed, 13 Aug 2025 16:08:46 -0400
X-MC-Unique: t0fbEyc9OT6cVFaoTFTfvQ-1
X-Mimecast-MFC-AGG-ID: t0fbEyc9OT6cVFaoTFTfvQ_1755115726
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d60528746so4323917b3.2
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Aug 2025 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755115726; x=1755720526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5pOuO1duU73MwDE/1tAdCEac90zxzSOOSRsJ+gjwos=;
        b=SyEQqIwh58MBJFTEpU6fAEV1cBa7luI9YYXzmfQMRD8rj2rVUWhIQ0kp8dRVsMB1nU
         +LMPyUQroGC5HzLM92DACeWZZY7y7Lcf7gQd5U1H5WVSAMzl2s9IB5/jbebmxrpvRYW0
         7sWhBEd9Vkbb8M7hqmw1CqqhK3QPSvxA0hq7WgrXtR2wVak3FUF+5aFpBNRnDgNqY5Wf
         Tzl9eEitUj5UZxolIdrGZAp8MiUxprb9/3gdnxrNg63VjtfAZ13gKTdBW3csVotyHhzs
         Hvgb25pLJGzAMhZfuukMD50Z89G4YeiEBxC0xh7AxrPn77vsbQ9imR0Lepjw7P2ZWfqQ
         dw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUTBhPBNECi+Z5ORALzfVO8u63vTI0RZqCcNoZWnTBm5iwbfuegq9os71V+0hIv02D9ucxcbHLI08mRikvtSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lfekx8RSVfq6AiWLzEBAeFoR9OKf4eWFiBCO9oelQG0jT+9+
	7uLPviOw4/bhlMVW5dFzIock6CAfFuATrpvf5WvDc+VoQQRqsRV8CeK14LokFw87sFk2YoJcrLf
	SrsmbzQMPFrILn5iCdUX0SqUSEKTvSJCJ9b6hviUK+GG13Vrzbe/0zn5KOKhorxJrWZ43vZskD9
	+LMwQ=
X-Gm-Gg: ASbGnctRxEjGp+q1O/EIBmSBrbSKRmVt1egRa62+3TsGmCpCMhcpdpIvqk1s8pBFrC4
	r3py131+wI0WNR4pXcH1a2ByFVppYnb+MuDsHpkHLdiDRnvnqvUEX0MtvsQHm52wcKjNAXAcmUD
	npOzZCN/AsTBV9pIEUdQHj2/fWQXbhqQzOh8LBFcbY+bA/aV56si8XJwe74ZM7kegakdI2ytZTM
	uB9YCidC1Q7fdcdVtmgkIQPO8eKYU7oPRSDXLurZT96xlpNWNRauyfR5VdExxxanaoc0gJKajph
	+wadVddm3RM+ZuypujznuIOSZMsMIydFX9GdW3nd+6kiGo3/j/8=
X-Received: by 2002:a05:690c:4981:b0:71a:34f4:7530 with SMTP id 00721157ae682-71d633e35bamr3364327b3.8.1755115725844;
        Wed, 13 Aug 2025 13:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN9g9t0xfEFPFfjXHwGTxWzgdaT3aozleN1XFaWk8YpE0ZVkfMjYSIbGGMNRoMWyrwgkfUZw==
X-Received: by 2002:a05:690c:4981:b0:71a:34f4:7530 with SMTP id 00721157ae682-71d633e35bamr3363947b3.8.1755115725490;
        Wed, 13 Aug 2025 13:08:45 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.48.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d60fe9148sm1260767b3.45.2025.08.13.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:08:44 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Add common virtual envs gitignores
Date: Wed, 13 Aug 2025 16:08:33 -0400
Message-ID: <20250813200839.82200-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtual environments are a common method to develop in the Python world.
The virtual environment directories are ignored.

Copied partially from https://github.com/github/gitignore/blob/main/Python.gitignore

License of copied text: CC0-1.0 (Public Domain declaration)
https://github.com/github/gitignore/blob/main/LICENSE

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 .gitignore | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitignore b/.gitignore
index 29b00a0..1fa5bbd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,13 @@
 *~
 *.swp
 tags
+
+# Environments
+.env
+.envrc
+.venv
+env/
+venv/
+ENV/
+env.bak/
+venv.bak/
-- 
2.50.1

