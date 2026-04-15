Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979C3DBD70
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267792; cv=none; b=ZSigkUl3GR88NcDMjklhnmpsdYZ9jVYbBSrl+tCImPACHKj5mc03maUCtKef6bq1l1Zv3cx5Ps6A0f93791G0BVAQWt9Zo72PpcWY6Wt4IXV3Wxn4GkZn7Hl0V9B2QhUD39RARBlSa9erk1lSvPwaY1QBzAgAQTIpQppKph2+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267792; c=relaxed/simple;
	bh=ouVzZioZ69/egCryjKfN0oqzCfWRq+93N9O+hUI+aes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+u8tb4JT+HsjeFr6sMhPbkHedNw9AOGNUp63Zvt2mkPE9DTsn6R45o+UwvWIhf9TGtN1xKmpHJjC8uVG93MWA+GcjlpwmnloZeDxPAUK4CJSYte2XraJEXDlP1B1cuQRIMPM2Jkjpr9C8XZnPbWyFPefBOkqg7aDgggsVZGweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qInW8zDP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qInW8zDP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d7e7f48499so676803085a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776267790; x=1776872590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UGEf35UaHBKRapnb7PGIlG3iTkMLlRU0+8kTH5QR63Q=;
        b=qInW8zDPY+RkF6itu+Hx+loxS9MULd46ouXxgD5lmVmnP+GHYDRhmY0lhXxJuE7nlp
         IPKupyTVC5ZkWsn1kTxRRVUsRGv44AnQru1Sa/Le2CYMhjkmjtRDQlwKJcyC4oywHXlq
         NXC9tzgIiNR8sljiek5H2eyi+sPxhYHtWGg8ZMq7DjVb49IuTXz29+OwFl1K4myPmzcA
         izgjcdTbeiYPVwcMk3rkDxPtP60xY6ZaC/Aw/7//pslA9RJAMVgFIRTPV7e4ctjfAOBu
         DCXtv0oHhXKuMhppzWwhD9oPz8iHQnwuyBUBOxhGBnnzqkc12sA9x8WchP2blIJEfy0B
         OlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267790; x=1776872590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGEf35UaHBKRapnb7PGIlG3iTkMLlRU0+8kTH5QR63Q=;
        b=QQWG5om3N11pUkJSZBwATHNVeoDgUv2nW+YIoAp+9u8BVX1/KbVmtxeIVsnncCXM3Y
         LWvIjvhCVEFmuVswmy0aD7Oops3LbGhcPieMavJ+FoNzhNVMl96PSF4BxXT8ngBzrppi
         x8EKxFBh1PZyyS4eRVuP3lB5W4/QcnCzWjiYrPk4FFBG7vLkPSOxn1MqnjWQpv1F+4ca
         KaIHsggIKaQ9Nn8E+3fLPheZorhtPNa99AlVD+FyAaaLcpmTB+uwAEkrm01xMJntUJ9m
         3cO7HFFc2pABF47QOD1vGE76ng8+Bi0OBA82usMZ5LIbqHQKxmE6OOrjMI2QC2Lu6e82
         z39Q==
X-Gm-Message-State: AOJu0YyfeRjst4kjo3HrByx6ZYcDuvPduaQ+mf0FPObej/2fBme7dCyP
	WrtI8LLIMUIgkbtrxX4wFc9GqPTZzLIJBxF6IYe9gDf1p9V5fnEqJaUG3C7g3Q==
X-Gm-Gg: AeBDievl8KL15KlHlylPELNLC6gnI811pCLm0vtzIJZQowJdduvHxxQL7z2TssteI+0
	qRF54F6gPJtiDJ1Eg4d2Gor/QHCK4BiGTUoqk1Wn+IVHsBTCtDD6R5CSd8IDL7873AFPD7YMPfi
	S5i4yU+9UQNM7nITlfr3EIEIbrMAw/7y1bCb8EhIGt6jdM6C3DTvmtQtRyqHhEFxCxSvY0mBSVy
	a9ZIEpLMpWuIrrRZjkAIW0D7a/SIP4YQVPDq1JlyfcLtxMExNRBD7yqSTpLbQY/A6koPQCHfiNc
	Ivdtzg7R7yFcqIjGYgpFHnjnqAlB2aM9bhpseDYnnUHTV8f2nvpvic4WDFryl0ChnNoK/TWY/8W
	QvF+4QxQQkoTP02121KL7W7BFVNSIeWTNVnNWsHX4SFtDcp7TFwMwje14I5MhvR8X753FBZVokj
	HMdl6inZ6CahdX4+ocUHqwwb7EP/IDrJMCwIk4dTENeYSVvR5+0JhTTQ8qT8/H1Jpb1+gWCpiqO
	AsYnFA+n7KI6K3sORU=
X-Received: by 2002:a05:620a:2804:b0:8c7:13b8:8b55 with SMTP id af79cd13be357-8ddcfe9dc35mr3359679485a.46.1776267789655;
        Wed, 15 Apr 2026 08:43:09 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e5b53ed0e8sm30770085a.28.2026.04.15.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:43:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH] cyclictest: Simplify auxiliary clock parsing
Date: Wed, 15 Apr 2026 11:42:49 -0400
Message-ID: <20260415154249.139258-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace eight individual strcmp() calls for aux0-aux7 with a single
pattern-matching implementation that extracts and validates the digit.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index afc3a8c452da..71cf5cb25c22 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1054,23 +1054,13 @@ static int handleclock(const char *clockarg)
 		used_clock = CLOCK_REALTIME;
 	else if (strcmp(clockarg, "realtime") == 0)
 		used_clock = CLOCK_REALTIME;
-	else if (strcmp(clockarg, "aux0") == 0)
-		used_clock = CLOCK_AUX + 0;
-	else if (strcmp(clockarg, "aux1") == 0)
-		used_clock = CLOCK_AUX + 1;
-	else if (strcmp(clockarg, "aux2") == 0)
-		used_clock = CLOCK_AUX + 2;
-	else if (strcmp(clockarg, "aux3") == 0)
-		used_clock = CLOCK_AUX + 3;
-	else if (strcmp(clockarg, "aux4") == 0)
-		used_clock = CLOCK_AUX + 4;
-	else if (strcmp(clockarg, "aux5") == 0)
-		used_clock = CLOCK_AUX + 5;
-	else if (strcmp(clockarg, "aux6") == 0)
-		used_clock = CLOCK_AUX + 6;
-	else if (strcmp(clockarg, "aux7") == 0)
-		used_clock = CLOCK_AUX + 7;
-	else
+	else if (strncmp(clockarg, "aux", 3) == 0 && strlen(clockarg) == 4) {
+		int aux_num = clockarg[3] - '0';
+		if (aux_num >= 0 && aux_num <= 7)
+			used_clock = CLOCK_AUX + aux_num;
+		else
+			return 1;
+	} else
 		return 1;
 
 	return 0;
-- 
2.53.0

