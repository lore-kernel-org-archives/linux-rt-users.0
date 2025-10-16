Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449332D320B
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Oct 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615911; cv=none; b=IkOpiGWWqjrShEaCL5P/W2eal7nuu9SUNjhiJSVW4H+mIe0AP1f6Hioqrcgz82DbJ53JzvdMpvA01xUoX+g2FEoZDG6ovryzee5S+pKV2A123W4QgoNoTgq5dre/VcXDaLqafaltGquyiuFMf5BKLLaj/JzRTHkdfUe/fje+xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615911; c=relaxed/simple;
	bh=qn6PI31QdaDSVcsn1QmykMU5lA+FoddBaAVL8Sk13yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kRxMKMTDybswQtEUfEzBXmebEfn0hMQ0zEBac98NeJbieRckRdduPqqQ7ZQkVN5VJ1MasexWyv561FKnBc/259sMVuJowqv9+bEnIaRvAqFvgVHfij55Vdxh9k6g1+i6kH6n7AexZmBUJhLSUEAm6bCiDwuJ5WuwASyLahBi7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW0uwzPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW0uwzPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760615908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z9OrgdIC5dRf3Vaga5cNHs1c+iaGOfTqPCjTAgafYWI=;
	b=EW0uwzPVK6ywKDpjhrS4PNIYLlFPoJDGTLCxeRh+8YwW30/DtD11qpfuJUVBk+Auhxwkyw
	gKM0FQM49KT4j3pDmJoBpFBrDd8CCMbMzo30wyWWXEuViRSZBf4gWE9ZE6YRiJNNVUN896
	4U09T7Jj925Uar9ZjcVwQk0dOAb+Ynk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-k80rk2blNw2rs0wu5ruNnw-1; Thu, 16 Oct 2025 07:58:27 -0400
X-MC-Unique: k80rk2blNw2rs0wu5ruNnw-1
X-Mimecast-MFC-AGG-ID: k80rk2blNw2rs0wu5ruNnw_1760615906
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113538d8cso4654105e9.1
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Oct 2025 04:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615905; x=1761220705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9OrgdIC5dRf3Vaga5cNHs1c+iaGOfTqPCjTAgafYWI=;
        b=wt0iaR2PDG4OGelZlOvLc8U6SvXhJ3MXHZ0XqrliU1BDdbyj8hzkenVuLBDlRbGx8T
         NZRpVBFZhgnCcEzNTZfN2EPdJfDBcXmjT7kfLAHPQqTxp2IYknY4orOqqbPGqnPxiisE
         6rE9IEjwJnKLD6ouBG8tkWQ4Nvub0KGqmVP+cpYxVIoaMnVXw19RyvyvW/SoKZIAyCyE
         YXDHLmS+ePiY5LurHV4hnhEvM6XK/FUG/imC4ZDlvoXMLtvqKfoJVH0HCEZTF2x1KjPa
         ZEtOY6/dHo32JM89x1anLnebttA11RUbKqD6mYOY/u3N5Erh+JO8bDGBPfkk+Ad0rEII
         3NVw==
X-Gm-Message-State: AOJu0YzKyjPB3i1h8X4uUIuQz1B8ojrS2B4xkjw+834PKhNXEdGEoAEZ
	uggsTjSBp5r9G9PZukWf2zu1YqCsEhD+IrbC+oNpueZ9A+7Gb4wirc0s+MCJ60MnOiywQbSmhZK
	9aT3A4tuZnjRMZe9aiZF2wlx02JiFaX+g5x8h759TwjG9vLETBHwiNWRP6uRsyrgfVsBBaGfax5
	KCiiS0spCHs/APTM/GFP0ir9n0gYsazPH05GzXQJCYwDRutEw/WWtiiB8=
X-Gm-Gg: ASbGnctkPVPRdkaYM8vGuLOImxC4RfxzPPf9NTg5zaFtrQuFO9bKocKZ4+cfshek8Zx
	ud4gdoEzyuHhqOX1iu2RRP0RRiPW9gNxWIdVb6NVeyHmlYresAdg1CtFtXIpCTRMW3I9WlAERiY
	Xgb79tDTUOEOCaqo2Y6gTlU78QC9MLkt6xtrF1PdNbFuT1pgXU51i5shkEjJDmddMVVQcFRIG5p
	k/zMEMtRCh+scdzhYamqRl6VZ23Bmtp5VVY7xOU4A0mfS3oVoTd5lLhg6xsOaN0YYs/Hr+SQZmp
	ykHSPFk+X+JjxD2+cfxPUksWQEK1ZmGrpMqk/A74Gmwl5QlUh6q2feRfcO5y9VOCbvreVBGV+TM
	390V/EXVmZlx8Zg==
X-Received: by 2002:a05:600c:138a:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-46fa9b092aemr199929655e9.26.1760615905488;
        Thu, 16 Oct 2025 04:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQw5aM6MTxFJgOrRVoSmZjkDoi3Mw2fR4U2VFreDYa92bkMPmtj0xi3mg72ub4mWtJXKiXpA==
X-Received: by 2002:a05:600c:138a:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-46fa9b092aemr199929375e9.26.1760615904939;
        Thu, 16 Oct 2025 04:58:24 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442932esm22684755e9.6.2025.10.16.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:58:24 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] rt-tests: cyclictest: Add MTBF calculation for latency spikes
Date: Thu, 16 Oct 2025 14:58:10 +0300
Message-ID: <20251016115810.390980-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cyclictest reports the number of latency spikes but provides no information
about their frequency distribution over time. This makes it difficult to
compare results - a test with 10 spikes over 1 hour is very different from 10
spikes over 24 hours, but both show 'spikes = 10'.

Add Mean Time Between Failures (MTBF) calculation to quantify spike
frequency.

By definition MTBF = total operating time / number of failures.

In a practical environment where the number of failures is not very high, this
formula is biased.  For example, imagine stable periodic failures.  The total
operating time will include time before the first failure and after the last
failure.  These intervals are determined by when the test starts and stops, not
by the system’s failure behavior, which adds measurement bias.  The resulting
MTBF will vary between runs even for stable periodic failures.

To reduce this bias, calculate MTBF using only the time between the first and
last failure, divided by the number of intervals (failures minus one):

MTBF = (timestamp of last failure - timestamp of first failure)
/ (number of failures - 1)

In Cyclictest, the failures are called spikes.

This metric enables meaningful comparison of real-time performance consistency
across different test runs, hardware configurations, and kernel versions.  It
can be considered a KPI for real-time stability, relevant for certification and
SLA evaluation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/cyclictest/cyclictest.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b4bce8915b43..8ffd05a22b44 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -165,6 +165,8 @@ struct thread_trigger *head = NULL;
 struct thread_trigger *tail = NULL;
 struct thread_trigger *current = NULL;
 static int spikes;	/* count of the number of spikes */
+static int64_t first_spike_ts;
+static int64_t last_spike_ts;
 
 static int trigger_init();
 static void trigger_print();
@@ -1753,8 +1755,13 @@ static void trigger_print()
 		fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
 		trig = trig->next;
 	}
-		fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
-		printf("spikes = %d\n\n", spikes);
+	fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
+	printf("spikes = %d\n", spikes);
+	if (spikes > 1) {
+		double mtbf_sec = (last_spike_ts - first_spike_ts) / (spikes - 1) / 1e6;
+		printf("MTBF = %.3f\n", mtbf_sec);
+	}
+	printf("\n");
 }
 
 static void trigger_update(struct thread_param *par, int diff, int64_t ts)
@@ -1767,6 +1774,9 @@ static void trigger_update(struct thread_param *par, int diff, int64_t ts)
 		current = current->next;
 	}
 	spikes++;
+	if (!first_spike_ts)
+		first_spike_ts = ts;
+	last_spike_ts = ts;
 	pthread_mutex_unlock(&trigger_lock);
 }
 
-- 
2.51.0

