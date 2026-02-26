Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1B42049
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138121; cv=none; b=r3I9vpz8Uq0LMIRLkiYh/ODi9jk5oQ3ZMRQVu8OqgKebIMRMdm1Gm3znjSionAuF9Ntapq+FKFtsDtIJy7J2PNfyKdv1zNkNXsqjF6RsToNNTR3Kefr/yPWMnsB1uayn+IYmJ/i9TT1dIDG3hXxtMtG2yr58wDM+n6SC02AQMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138121; c=relaxed/simple;
	bh=2Fd/S86n9msvEBOAidufGqfMPISJcbno9EeLfho5SSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rD/t6j3LhmcbWTwOTFplrioI4HtdF25fD7z0srYT2hjgT2okG2KlsvbQlCit36GBEQMidRsD6l4BeTPyTUMcvyUusuTJqp8nKBy4ASJt1axsk9n33yK0g+nn5nDAPKXLKlPqt+M7AUZXYwn51aDGIOAUOA2Ksu8c8a8GCAdL+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d17G1YmR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d17G1YmR"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb38e6d164so165048385a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772138119; x=1772742919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/XnwfJ72XD2/bVPg/6LPD3x5U/422g5NO01gdS8whZg=;
        b=d17G1YmRVOK5lthcrPBvwJlho2m6c729sNqRgFXvlf7GB5Ydxgi/kXDD9OL/Rh7JYC
         uVRJQhkEpSY0Fp49gWWWMIUSZTsplCHMMWeUhpPfOoBlyKnvH81dnUnjFc2SmNj3FqNN
         KmzP6bXt/p5T1LRgIP/fsG5ZHRIhS6yHlbwvVtzmssdQccRdLEYtilgjXqnpCOC9FKvJ
         cpYKXj9hRzMSR19AsY8pTgm00A8hXh/8xRkvF2miXo8ns6lvG9vQeUpt8nhfllbRorOW
         asLR/Rb+JJwbYq12E+UqFaFLy7NZIOX7NKofI2Nc6dwFnWXRNt7WXD5eS/TJurxhBSTL
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138119; x=1772742919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XnwfJ72XD2/bVPg/6LPD3x5U/422g5NO01gdS8whZg=;
        b=eM/4zXZhq2hPo6PkI6DIQjnS4U+eLLWUejn1+gucSkVqYdMjMsDrvpiQSe0l7P42sT
         ZvB2eQImtc3t1FA7qidtxxWrwnS2YVsEmXdRnLw+Efqus2Kvb5w+lq1FZS0hxF3jet0S
         NHTsfNdlJ6I3W88xzMvHHkHkckgkZ5bSUjstJhDWIJXf4cIh2s7jAWPahYRIpr2MuxfS
         lEU/gQ13UrJcdoGY851MgkMd+SgglNTROLW+U7yxZD/qx0nmkt7XZwzaYpmsgP8lfX+1
         tZTv2arm2IOVsNKJtX1qAvDBpYUpSPVsggutKyjx6rwnFKswVykEPQghaiw8f8beAYLC
         49MQ==
X-Gm-Message-State: AOJu0YycRN4Cni/oWMrhtIw+cwNs0MbYbDD+J7YnnqWQVNjy4DvoyY42
	QvZPVDpzu+SCO0BJL13MUOpBdaaAch4K5vBPqBD3qdh5ZFz4pLX1TPby6gR9Jg==
X-Gm-Gg: ATEYQzwEcSRMC6OknBOMIH4dZpjxt1fjCK5xSWfduI0oMJYQjCzbZ+FhgqzyfbK4KTm
	UT6Vl5QkkllSMeTPkAFBH4z2nED919E01S8LZiJLD4gyRY7E4Ew1CnbQGB1MkggCN8e0hlqzvMh
	Osx/bBIpK1cyLblozG6rRUg/GFFA1pRVwzM05zyakBfN3XtstfF3qkY4mwY51E5lAoHs15OQAOy
	t5TycnX3/tyW7TdULkJQ960Hr5/fR7h9vL7ffdNff7h/VEj5VWGICdhjvLpDb4F+06TfmLhqJj0
	NamwaRV7au86EC+wlQvQTajZ5VogezFFfIC/Uo69Vtq1mP+lD0StlvS2MMEoKA3PvpFpSn+OV9B
	Qp5HeGM8ei0R53PuZ9Ej6cH1H7DSAhewGL+vJYTGrfADDC1vBdKtz7q6wbrNtcryhMg2MPIJE8B
	XZQr0tvkeH/Dityzy2VhlVUfxWppCkaDFkFieLWChLm1arWkKpTY/dyXzDGhgkyx83haUjT37Jn
	ZGh91IHqd5NpLP0zb5DmojXsXWD
X-Received: by 2002:a05:620a:2947:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cbc8dee816mr42073785a.26.1772138118502;
        Thu, 26 Feb 2026 12:35:18 -0800 (PST)
Received: from Cumhall.redhat.com ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738cba0sm25597556d6.38.2026.02.26.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:35:18 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: hwlatdetect: Add check that width is not zero
Date: Thu, 26 Feb 2026 15:34:45 -0500
Message-ID: <20260226203445.110762-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that width is not zero before division when calculating the MTBF

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index abfbb954fe75..42b9f301718a 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -564,8 +564,9 @@ if __name__ == '__main__':
     info(f"Samples exceeding threshold: {exceeding}")
 
     if exceeding > 1:
-        mtbf = ((float(detect.last) - float(detect.first)) * int(detect.get('window'))
-                / ((exceeding - 1) * int(detect.get('width'))))
+        width = int(detect.get('width'))
+        if width > 0:
+            mtbf = (((float(detect.last) - float(detect.first)) * int(detect.get('window'))) / ((exceeding - 1) * width))
         info(f"MTBF: {mtbf:.3f} seconds")
 
     if detect.have_msr:
-- 
2.53.0

