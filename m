Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5B3D5235
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837934; cv=none; b=TwlLrR3YoKJv7jx672fINyZwgJwsRgwOEYoGO5vpVwSiPnDYxowbUMJ5rkd2AEo/sgES8XBh2kPaFDbJ6oOHa/l7KDRdu2Z13ba+9RAalAG66Wmpsipd64zUvBFqJC8mLJT0YD2cGu8Wpv9nZKO3ghiH8yv2lxtVIqAFrudV0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837934; c=relaxed/simple;
	bh=OioVc5Ml/cP0NYyOgoivKfOD7ZNPTabdxRLG01hhILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuOs1kt9RJn9Y0RwZuRStvfiLFu0+oWOGMsHLZqIj5zwApBCcv0ePek3UWy8ke5S8j0mdZEFHc9mOvtVIXcUy/7rxLCu+UF90mCjNHpXJJ/DwXufCj7/QaF7gRO81ziPnfU325xeFCHMB0MG7gVXN+PRuja+FhEHjRT6737bCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4lRJj50; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4lRJj50"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfe810293so17686201cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837932; x=1783442732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAmRQGAlCdXKiJZhCihIjb7QgTeiRfjgVr5ZLR25I+0=;
        b=q4lRJj50QqufyDfnJ0CnXJt16lXgCS0oa2d1QalweH/WJrdcoMmuQgZYY9ORx+K6yT
         3fxyW1VUOHEK1B2+1ZvaBC5gHYZ2yg0vXPLeKeeWOR2FGPVWmsINE/BsV4KMm3d3Dhnj
         RIQRR0fClIA8SiFmGQm9RE65cBTKyWCwaAg51Tzmq62PmWqXRguiZxxxpwy2P68QCQEy
         AD0tcm3pnzm8law3daDTpEV68cprAawcpgYd266gQAc6rBz12pxSWWpyvF7Zub7xHsd3
         hlVT82qnC23Zdwy+YegD8P5XdDz141+BhpTfGNEdKEMC3CF2ephpHQkcJFYPxr0pNzGM
         mqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837932; x=1783442732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAmRQGAlCdXKiJZhCihIjb7QgTeiRfjgVr5ZLR25I+0=;
        b=F90tvYEwcgCaZrPlplWgAnzDjBQZkA6qYOYjhCOIDr0jZqfVIFmcG891/HtLmvWxBh
         uSabuO6jStxBBksjI4Qepf9TjrlZTb80o3FOs/GgqDDEcaK3v/BVtgFLOqRtuxJsMXpi
         MH1M1W6Ti+YHTG4UVxW/T3goOLbMW7PMXj6ASg2ns66GCl5gzsFh8nKbXTWAMxVridYj
         mQGqqdOSsF7VDAz1RBSj16zHx1Y8KdsEs/6ke3UKEXj1Kd+skJ63/yrQNVhxCXplhfIs
         NLHAZvW6zBs880tDSCYFzbn35H034vLL7Sq6CHudzrOm1f6WkqG/msalvqJGbrEeOsaj
         lvng==
X-Gm-Message-State: AOJu0YxnveLXpw1cRwYYxlI9fQmSf1ayncxxJ6vD1GE1VlNKUMy4rOER
	ZQHWdK4dh8z2ru9T4bY+JFa/I+1osZqzWz9pAgq+0sNkzGTRykh3dnllo38NXQ==
X-Gm-Gg: AfdE7clSkFzozr8q1loRP+RjDbxuxWvGyGzoSCY1FOE4opWP+ymh5OCxwu7TLuT2FFm
	Orr4/hAPzJ3Qx5h9wCmu0khaPDIMOnU7qrSEcm9ZuFvoybPoTgHsXt8AhZh6JdcTAy7Vaerepkt
	LTbA0PEOQcW1D44WM41jq3ZqgfYAFGxQVOh/2gBDRvY0c/uWV+piZ0k4H/hvy/NkU7u3AFA9G3B
	sAVUvEYySJ8IIQGMYi4CU/DyR/mo+hxgz8QhAdura5PT7UN9xa+lSnosEBOXv2GQaicc0Mda2id
	shI/3WWiqZKRdT/y9USvvbhwpr/xOq9FJQ2+H9pV20K5AB5uRTPFesxpNoYtrFWLQyVJ1xYj2Bh
	GyunLg2YFO6C7bGLOJE18M6QhePBx4VLaJMULJKJLgh2BNHSrmVFxvy3yhqijZiiLvxodMM5B5+
	egUyzs733GIrL3BtxyyWX9onsFG1NFKBQiHSX4N4x9nxcYFxOIs0d2FqBwzmGe33FCClYxqMfCf
	VtfCsksqQ==
X-Received: by 2002:a05:622a:1c1b:b0:519:89b6:78b4 with SMTP id d75a77b69052e-51c108549d1mr56838071cf.40.1782837931797;
        Tue, 30 Jun 2026 09:45:31 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 5/5] pi_stress: Ensure null-termination of JSON filename
Date: Tue, 30 Jun 2026 12:45:02 -0400
Message-ID: <20260630164502.95740-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630164502.95740-1-jkacur@redhat.com>
References: <20260630164502.95740-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --json option used strncpy() with strnlen() to copy the filename,
but did not guarantee null-termination if the input string was exactly
MAX_PATH-1 characters long. When strncpy() copies exactly n characters,
it does not add a null terminator, potentially causing undefined
behavior when the string is later used.

Replace the strnlen() call with MAX_PATH-1 as the copy limit and
explicitly null-terminate the buffer to ensure the string is always
properly terminated regardless of input length.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 45ccac739646..500b10d60737 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1238,7 +1238,8 @@ void process_command_line(int argc, char **argv)
 			pi_info("doing %d inversion per group\n", inversions);
 			break;
 		case OPT_JSON:
-			strncpy(jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
+			strncpy(jsonfile, optarg, MAX_PATH-1);
+		jsonfile[MAX_PATH-1] = '\0';
 			break;
 		case OPT_MLOCKALL:
 		case 'm':
-- 
2.54.0

