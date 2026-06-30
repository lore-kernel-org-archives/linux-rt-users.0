Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CC3C4B83
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837927; cv=none; b=IMjwKdhCsLJ4rw/Gb0ZMrJUvbCg6jkaswab+bLg1tEcCLAAoOfCahydPy2q/3UrVJmxjh+m9bv6A6Ed42MhrG/MgF68R9lCUwzKPSYaqlCLwUQtTF2BcLdMHdNUIZj+FVSUm92Rw0D5deUFLqU47rPt6/9WijPgVtRrND2NsXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837927; c=relaxed/simple;
	bh=DAj/ijelPWcF2xG6Sy9sritmrdKJEMOFdwtybg3hD/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFT7k2bzS9gIul2/2ib6wAcecHt5b5fMjsuEB7MmIMW91Jo+aoWDVg4rx5nBWcUZr1OxFVl9yddpzHdITeJsxENrKm+kU3XoJOcY50ac0Z1MguUOCUdb420E0H2jhBpX8jpHHBLGAl+VosJENAs83C4XYFbt2vjKggUtWK0IhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTSx8zmi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTSx8zmi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c16ac21acso5973051cf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837926; x=1783442726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccek4cqkJ1xbil8hOW1ZtBdWNeMpVs0Wr44PwoC4M7o=;
        b=kTSx8zmiawauSVmbh0sW+hG/1YVUR/tjBIaCYZZnC8654PziGMYAg9o24YX6v81U2d
         si9HoRA3+MQ5fPBd8oou/Q1EnO3pDng3x9WLWvYR89tc/blWyTiMash3a9fFfT5BNRcM
         nFhjOBVaFH73ca8x9E2waK0X0jQDnbDsCYo341SIeEl2jpIhbCl+fimbOxjX2s177oAQ
         FVLz79f3gPfM41pEG1eU1Lpd2flmiB7Tyy1GFy01GS2JgM+1MlDUU03kdTExU7ZA+lcG
         /00LGgrJJgQsQMGqEurVA/BqZ5swCFAn0TwUgStiOGSccZ5faZ23rtXxHss3TbXxNBa6
         uYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837926; x=1783442726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccek4cqkJ1xbil8hOW1ZtBdWNeMpVs0Wr44PwoC4M7o=;
        b=STKb7NwtW5cWtvGjl7F727c2zwxtCSmjauD+sxaUegUVT3DOIwpAj+i0gMXx4GN9bm
         NGUTE8rMgdW8CcEwKoP2aoKkSI9i3Nn53Zm2/MnkTdL3P++qwdQk9C1wKiPXXyIUE5px
         g37u4t0bF+dpm0akAzGJBhlHQP5y3D8omaIX81y7OAO28FYKnccN/OauTIk6T6FXnnoG
         EjqEuSQFvUjPo3TivFrpSwHa1Mc39zyv8bSS6pNnVsLde9Mz34/ctC7ZAMliOlTgVgSy
         UNt2jr0QeXuYcA4MoKfRRUBHRvNcKYXjYAdoAcJ+wyY+XTDb/zcd0oupp9q+rNOfefN5
         EBpQ==
X-Gm-Message-State: AOJu0YziX532Xz9ov+Etul9MZLKmidvpIo24W5NzwZvIc7UjLRSd7QiR
	/GNuyrNLbV4PKIn+D7KtDODLzWTfpGRckSSwPncXDZNm7s8yuYKcs9rZH7CKTw==
X-Gm-Gg: AfdE7ck8By91v3Zy6/rGSw6l1OIxuNLNYVzvAJv0vep3m9g8+xairS33GbH+JCGwu4V
	6nP12HUba29NBrJ+5Fw5Q4voaourne19IGJrgk3eFPg2lS4FIGoBio4PGL7mu+NmXaw4i+SlUNe
	OedsuD+ofKPbL7zulfGROUduYxriPUiTwYkg05bkrE00M2cSzYG2i+AfdVd85O9oxrw4Y9GmxKy
	ELfjNzU9yMt3+YIJyBy2AilCzi2KkKrd8PaQ9ZJ4ZgeO1pMwdRFEANBAtzEcnNvlcb3djT9mVSI
	V6SVmsJEedphCXA/9mj5Uq+jRu0A2QIFoJaRYryjHjztmf4sujG5D5WDITMxW3wJpdD1LHE70YZ
	z3tPYv1DV+E2OalkN99IOKReHvfR7M1W2KUt2BUgTCIoCSBmcfEfIlWjOAwDxNxif3dZqmCJba6
	tw5S/XCsMs76MOm4dOmBtC3TMvBCmv5CF4FVl/S6/hl02fk0IYT0VNSpvCB5nDt9lAQ148s1nx+
	NvhCPxXjw==
X-Received: by 2002:a05:622a:608a:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c1075f88cmr67315241cf.27.1782837925533;
        Tue, 30 Jun 2026 09:45:25 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 2/5] pi_stress: Validate numeric command-line arguments
Date: Tue, 30 Jun 2026 12:44:59 -0400
Message-ID: <20260630164502.95740-3-jkacur@redhat.com>
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

The parse_unsigned() and parse_signed() functions were using strtoul()
and strtol() but not checking if the entire string was consumed. This
allowed invalid input like "123abc" to be silently accepted as "123".

Additionally, the -g (groups) and -i (inversions) options were calling
strtol() directly instead of using the parse_signed() helper function,
bypassing any validation entirely.

Add validation to parse_unsigned() and parse_signed() to ensure the
entire input string is a valid number by checking that the end pointer
points to a null terminator. Update -g and -i options to use
parse_signed() for consistent error handling.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index b7f7515fa9b1..c8c895a71e44 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1092,6 +1092,11 @@ unsigned long parse_unsigned(const char *str)
 		exit(EXIT_FAILURE);
 	}
 
+	if (*p != '\0') {
+		pi_error("invalid number format: %s\n", str);
+		exit(EXIT_FAILURE);
+	}
+
 	return n;
 }
 
@@ -1109,6 +1114,11 @@ long parse_signed(const char *str)
 		exit(EXIT_FAILURE);
 	}
 
+	if (*p != '\0') {
+		pi_error("invalid number format: %s\n", str);
+		exit(EXIT_FAILURE);
+	}
+
 	return n;
 }
 
@@ -1211,7 +1221,7 @@ void process_command_line(int argc, char **argv)
 			break;
 		case OPT_GROUPS:
 		case 'g':
-			ngroups = strtol(optarg, NULL, 10);
+			ngroups = parse_signed(optarg);
 			if (ngroups > num_processors) {
 				pi_error("the number of groups cannot exceed the number of online processors (%ld)\n", num_processors);
 				exit(-1);
@@ -1224,7 +1234,7 @@ void process_command_line(int argc, char **argv)
 			break;
 		case OPT_INVERSIONS:
 		case 'i':
-			inversions = strtol(optarg, NULL, 10);
+			inversions = parse_signed(optarg);
 			pi_info("doing %d inversion per group\n", inversions);
 			break;
 		case OPT_JSON:
-- 
2.54.0

