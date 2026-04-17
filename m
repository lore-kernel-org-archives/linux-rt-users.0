Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA42264D6
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455496; cv=none; b=d1tzyUbuCC8JSSp+Oi76ZnNfjWPeqcxLo/Ve9aVIlWBsWqNi4cD4C2SNPOzemKGYoxKrE9ePpY7uQHbqfjQ1nSNnPHqjqq/pfbktm83kMymOY4KCvLew8G2HuvLsnpHAtSZLYxeLjWpDaGFaeUGw7aua+L9TDULVjN7vhMtxWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455496; c=relaxed/simple;
	bh=bx0rJZIkYtTf1LIdQCEmz/b5aczOMd/wvuWUpKO20fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALUf/wzZVVLpnj3M0VZYhsbd8Cx8szata3BfKBUtrSskj5GRS0N9mEs2rfexxlVWXwio7TbNsHTsAl7Ql1gql2580fnCup4j05E/NvileLAid/X3do5ntREznsYROqMXWH9I1ArBLK6nx8uPH7uHFojUq5Uls1odzX+FIILR7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIccIH3/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIccIH3/"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d2945e6adso13631471cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455494; x=1777060294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI2UxSbIm0bjRd5v2XjWCKC7hVh8PN6v9z0JPiuOzw4=;
        b=cIccIH3/Y9tEomaGw321DKsWX470Z6DQqIJRej3SP3xx4Gc9DrjowjZeeeB5quP9Oa
         iFCZrARsurH/BnV0T67RSA1vhqw6YdHYr4VaatFQulXiVEzXp/RylaJSKXi1leQRexmV
         viXyU2YRpAUD11xlrk1xYc2iNFBsVOgyZ2av/EZoFwINVP3XTbnguRMnp2Ks9i2dtXdW
         mMovu+MGrBH7hMoWsbHeG1fqUDS+OO1nbX4mc4LWQTc6df3To/6gTbbLoLtrpngt9r34
         ADN9pUngEsU2RsrbiubBdXiU/fl610jXR9J38xICVZ5D6DzOIfTtytFinpsFwZziNpfy
         9wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455494; x=1777060294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wI2UxSbIm0bjRd5v2XjWCKC7hVh8PN6v9z0JPiuOzw4=;
        b=OW7wqvncIM6dkGgHEIdkEyZmN6dybJOARgjZcLYn2vG4O4Dk9wFRWpRPaJ0rO7bEdR
         7bD8HYW+cC2eN07gHbz1eeRrnaOllZnQl7TQYPxvvznSAZdmv7sKbh1Bbm4hysJSq9tj
         y6HPfIC/ESewCtf/pX38CpTJ21jkcEYLtYXN8S5m1qIcogHlH77l8lrBRh1yvIF78UJA
         I8vpeJyN+9WkJ+97T+kLt1stMBqmtydn6CQspr0DtAuPmaXmMgBBWTjjDI12sPQObYla
         jOMBiGuT+tnXkzLj9nNBgsimn1skuDhBeUclCOuzaRz31AG4BQyet3j30g+Ka0VJw/l0
         mU8g==
X-Gm-Message-State: AOJu0YyLV6S7nUb9Y61r62alARBS9wg+dg1Hf3lnFOqbo99rN9bGen3m
	I9HCxLn7Mb3LvapmfCwZGFhz7VsFPFmKbuTQXpO5sJSO5pAM5c0qiYY7l8jA7Q==
X-Gm-Gg: AeBDievVMlatvjyx0UWdftHL7g4bXyGag6CdgFqYsO9woaj27s0o94oeA/+3fTpYgf7
	D0VPafmfeFEkg/IhT05CNLJ/8zREELQqiWs3Lr8rZRnZlUtragcE9Z1qhYzK002qA2HVpyUGQKr
	6y6hOcWTB1bTx96/pv6VQ8OHzMqUuxTlfhlRnDXBtQfgzGVcmK80P6xn4eehWjVbINPMC9dul3p
	d9VxMFk3f8vTJKwwtLnzdPaLlkTQyteICty+MiIh+4Is6vyCYvM9aYSmAOSM2X9VVzFSLM3u087
	KzZryxIHocpnX8jcEBenWtvWt2cP5GAjsnRorkcuDPaho9vnPyzyW+OBvDAjxocc9hAunOfJv71
	9V6Ft+YObHyVTI9ICUxH5O5BTse7eEBXhQwa3LGN7l5LyBliHabEN6bB1ZclMSUi8Xh3Zggj6K4
	ZFFSdX3QerS57a03dIkWGztXF1Kb97zwJsHGmosEhhRq/7jRhI5Pqfk0duHV+oFC0FqvJs0ncDx
	x5K+fbC2pSUvx/w1Rki64P7wB9LsA==
X-Received: by 2002:ac8:5792:0:b0:50d:38d5:c6b1 with SMTP id d75a77b69052e-50e3694111amr63814171cf.16.1776455494176;
        Fri, 17 Apr 2026 12:51:34 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/6] rteval: Fix xmlout unit test XSL file path
Date: Fri, 17 Apr 2026 15:51:09 -0400
Message-ID: <20260417195113.177799-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417195113.177799-1-jkacur@redhat.com>
References: <20260417195113.177799-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xmlout unit test was failing because it was looking for
rteval_text.xsl in the current directory, but the file is located
at rteval/rteval_text.xsl.

Update the test to use the correct path relative to the project root,
which is where the test is run from.

This fixes the test failure:
  Before: 2 successful tests, 2 failed
  After:  3 successful tests, 1 failed (only DMI test which needs root)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/xmlout.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/xmlout.py b/rteval/xmlout.py
index 710d50a1fc0f..5ff426643c3a 100644
--- a/rteval/xmlout.py
+++ b/rteval/xmlout.py
@@ -283,7 +283,7 @@ def unit_test(rootdir):
         print("------------- XML OUTPUT ----------------------------")
         x.Write("-")
         print("------------- XSLT PARSED OUTPUT --------------------")
-        x.Write("-", "rteval_text.xsl")
+        x.Write("-", "rteval/rteval_text.xsl")
         print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
         x.Write("/tmp/xmlout-test.xml")
         del x
@@ -294,7 +294,7 @@ def unit_test(rootdir):
         print("------------- LOADED XML DATA --------------------------------")
         x.Write("-")
         print("------------- XSLT PARSED OUTPUT FROM LOADED XML--------------")
-        x.Write("-", "rteval_text.xsl")
+        x.Write("-", "rteval/rteval_text.xsl")
         x.close()
 
         ##  Test new data parser ... it eats most data types
-- 
2.53.0

