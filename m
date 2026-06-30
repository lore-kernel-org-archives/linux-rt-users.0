Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B23A8739
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837926; cv=none; b=LxliUcDC6dB9OV3z21VTXM4+7SivPpR4d3Jd/gvP+bgUH7K4HiW0ucsHSVb7HT09X2DK/HYU73LCvN3DaQpWGq/RcEm2e2h7jGKboJs6/xF0xHJ8MhxdYm02FMPVba7V15Kkmcy/EJZdBVj/qOdqfTR1k0fltxMt2+2EU2MhDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837926; c=relaxed/simple;
	bh=5bOCsdWpYb2zqSZJYD13vhJT994Qte/umV9TceFA6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+ETla6OFStAV1Ci/A4Jq15xpL8ScuqpAwrOwNsnc+bx0QM/PRisI7OtVMRM3Qu7IMboTeXY9nxZsQdIOottUvpYlmr2hTvHTRMlpxaSdDEFO/zU7LLcTpSuX4B0QkBRT3iFyy5reIniy9zivXK6aIVU0Yl9H1AJAVs9sqPpCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR2jZELE; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR2jZELE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c15bf5000so6557541cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837925; x=1783442725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvP3Pz/j58t9E6If0Rjywr2/Sc2oTXv619kqLg2CE8A=;
        b=fR2jZELEzNImdR4KCMoioV7/7JTJWXPwa1YXeJerXD1GrvgWFhyPUZsmoFs+AG6gW9
         Bt/2keMnDrnC++48aDCGO4qWQ00/I2MUPhh+bhE2Qj2V2j7rStjV+ofs7/7MS91XOCEE
         fKeeb3T0KsABYoF+g2+MSlHMxvpSkuoR9rtX7IuinighTi3Y2GJjakXh7p0vmV4OgsNy
         8o07s7dh0QdB0j2Gj13dk0MjsoxTAptgY0Q+O+4f6x8p5ChhmBLplXDCo4vqLjWXlG7L
         e4PcwBD/GoPPrvxc3aq4zei9xnXgMpOASG0Ehxgwudw4rkrol3sA1A/e6Ao9Ad6qqusn
         fxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837925; x=1783442725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvP3Pz/j58t9E6If0Rjywr2/Sc2oTXv619kqLg2CE8A=;
        b=EaB2CfAf+1XQiUMeWHMtWaEdsZU5GFNXLTWCJobskJib6ij9zZhe6GAJiKE2K01IfT
         SgjBh4FfDQET5DEWkDYGcKgedbLg5jJjIwvQkKGh5mHxUVxFHQD1XCM1YSBuQIQXPhZs
         T98uDWUP2Q86QpeR4m/4IEuN3E05Faa16bJV9LhQ9NKT8oMPwXWBeCmttN9TvNCnLxFR
         b+C9F6dw36Ln1vem2QJBcGcqdWGoCbOeXtdL34tcbB6yOk+H+Ty5euvQpzfd474RgAWi
         agV/nPBYK/ubtwxhs34OJNZDGyZ+ihKhPOl79jikirKfd+DgdHsHfAbXwCbUkAph4pTj
         oCJQ==
X-Gm-Message-State: AOJu0YwOIlqDpo4sZ/5an/hXLKdaRHndDAmEimE/lg6uCalfKKJlQf8l
	KCguBochqOSRC1gg3lIMaJ2KnkC9Hx4bGPHWi3aRmpHc+CD7988bdQhZDK/k9Q==
X-Gm-Gg: AfdE7cmjd5isKHjq+8yyF15c5iib3pDrHf2kOLwMdOJXDmef/UPzBhiGRKTtbvDqizA
	AOiUKvaGHNum0goTdnft67TF6qoUGtGK5RnHDWtec6Jj3wx5LOTRPlCTMrbjAVZxd8i0XYjhzEg
	5eXQCtJvhY1NmKey1D/7VZOY//Mdm9nVfB5AvZ2ckz97yPnX51k8/vBtykesnFaDkLTbkdk8iy1
	uwfPo4lb+rIomWQTR6MabmHyRgH6KeS4TUphM41QThVfvd7Ajs4h8LH8fSc+AJNwbbwsZf1HcsZ
	2G1Scy2/eNo3Ffquh56Ll6y7hq+FSgiWS6cTCdhTx8aex0+3i5MUjDj1Xo2KbLEmYVFvj9MXZRS
	6L3wZqAezXV4I4F8GDL3eOHN91qRO0MtSlQdh3qvgVg3lGJPwU1NbdRW+HJ4vzxcgcmIbH+huLX
	NHlLMv9eWMNEIlKQPnSndq76OE7Q/+c5scP3uKM+b9fXkdTrb0y7Jr0PnKYCDCU0qczi1BAkvmQ
	og4E8RXTg==
X-Received: by 2002:a05:622a:2595:b0:51a:8c97:9383 with SMTP id d75a77b69052e-51c1ca3ae00mr19381631cf.58.1782837924375;
        Tue, 30 Jun 2026 09:45:24 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:23 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 1/5] pi_stress: Fix inconsistent barrier wait logic to prevent deadlock
Date: Tue, 30 Jun 2026 12:44:58 -0400
Message-ID: <20260630164502.95740-2-jkacur@redhat.com>
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

The low_priority thread function unconditionally waited on the
all_threads_done barrier, while med_priority and high_priority only
waited when have_errors == 0. This inconsistency could cause deadlock
during error conditions where med_priority and high_priority threads
exit without waiting, leaving low_priority threads waiting forever.

Make low_priority consistent with the other thread functions by adding
the same have_errors check before waiting on all_threads_done.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 74e7bde0c21f..b7f7515fa9b1 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -605,13 +605,16 @@ void *low_priority(void *arg)
 	}
 	set_shutdown_flag();
 	pi_debug("low_priority[%d]: entering done barrier\n", p->id);
-	/* wait for all threads to finish */
-	status = pthread_barrier_wait(&all_threads_done);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		pi_error
-		    ("low_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
-		     p->id, status);
-		return NULL;
+
+	if (have_errors == 0) {
+		/* wait for all threads to finish */
+		status = pthread_barrier_wait(&all_threads_done);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
+			pi_error
+			    ("low_priority[%d]: pthread_barrier_wait(all_threads_done): %x",
+			     p->id, status);
+			return NULL;
+		}
 	}
 	pi_debug("low_priority[%d]: exiting\n", p->id);
 	return NULL;
-- 
2.54.0

