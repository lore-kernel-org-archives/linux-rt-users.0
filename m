Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56F18B477
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833395; cv=none; b=uzEWDK36NKldfAvmi9EXmMZVSCgCtAfVEM4t/fE58c4dPUx5FZfr8aSX5jXKl3KbJK6DvcvF8fLtLXXZ5/pR2k+8cUnVTUgMFpUz19vFZfNz+H7aVIF+C+kmTvpeqBFKD0FTaZvMFEQASSPKVUZh0NUxaX90hGzBFZGNYCnVjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833395; c=relaxed/simple;
	bh=hcxfj+NlIh8uTGEVD7Bs9J2krpykvOfuJG6l2H4ZOwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j4XB8d7sxxIBhQB+iRDErql8bOvNczufYYnwgVmBWkbKUKgVYVWKQZ6n+GE5F7yzJGpe795MFYSfWxfcCkVCCNGQuJPnAFX18JbFStYz0Dv5FmkURNfJMjLSNmdQrwGOV8PxF37xp1CFa7+bIf/6RDIC/gVKbwxeNK0URlhvFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=An4y8KqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An4y8KqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738833391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YdMnCqE/ka12//pcVH2XDXJuzWoS2mK0ybALYOZNjwI=;
	b=An4y8KqW9PEi0G1HoemReGkzf9xyTxP+ARfzB0/hLR5spg4AqUNClPXc27gMnE8OWdu1+T
	3J/gZFmigWcLTzgZUPBqi7GK5eVXBXiMGgYpgJFhE+jings7vH7z24zdytzsrCzTc/jik4
	t0DEpHQjQlszgBW1zR7gO9FCzhc0+Ms=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-cOeMKzKlOQi3MbEIB6jVAw-1; Thu, 06 Feb 2025 04:16:30 -0500
X-MC-Unique: cOeMKzKlOQi3MbEIB6jVAw-1
X-Mimecast-MFC-AGG-ID: cOeMKzKlOQi3MbEIB6jVAw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f022fc6a3so16221895ad.1
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 01:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738833388; x=1739438188;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YdMnCqE/ka12//pcVH2XDXJuzWoS2mK0ybALYOZNjwI=;
        b=T4LZYqP4YLCrKutyHgJMHROHP9oMpkEiaG1MnwFpXvSQqoyHiUEqHozVmnvOeVe9QZ
         tl1fuY0eHKbJUWBNUamp/BdYJdFQbl9c7pGb7j8gS9Zh2jVgIdKtVBdSALZzkOWLD0LZ
         9SBJZuFuLDrA9kZr2KCH92Zb6Jc/ol9qOOF9p9TFoFRVWzTXUwh+uOlMWJ48K2aerXFL
         gU9uj3akaa+bjSaVk/1VI3mMtYlWcu8twbpvXH7+OGMYfiMWErGzU0H02KXBOvS0C9+3
         MagmH2peUjPR05f9MjOu9ivpXS7unY6o8FoUo6Fv4us+bdfq9MBLxJ4POphtphE+EmSy
         NWTg==
X-Gm-Message-State: AOJu0YzQelEhwEzgg6PXSWgC8IATVfw7xSrDuNZcqDp8QgaPZPFnAOgI
	aNREHPE+nFDs0ucOxn9PWBH0+Re+XpGxJBWYjEZPsvBXufI9JDUeY6Mga7fB6OEDYgKLnbUNhcy
	jtPHdESQoCQl8pO/oZECPLGHuN7zwLmZwOsPFN0ZPZNUwF6tcdt8+4sSEnl+7vaAia0hfuhbjwd
	4=
X-Gm-Gg: ASbGncvIEnx0STPj+xSGnf8IOwkgFuLUkdE/EaD7FNPWL+OmwU0+blAtxuL/aEsEpZd
	lODLsi+uTy+47bD7KOM+eDThmfZMJ+Je8FYq9N/aq5Tsnuly+OF9dRdpW8+1dc3K88xviucOxXq
	KuynS1tEXSoIwrwk4PB6YKArsBzyGhxZmNZdp+lVkColzPNkBpX7eVRGjIGM7695aLgcHyaQzvo
	fR5GiT+Lk53xROKPr8H5klRlZK/9ZrYXYvKAbL/79aUnwF0IPzn2NMpZ4EaDvz+Og8FVheEwnfs
	NPgLJyjoum1Z6pgNJixKSDgTWwWRAZB+ny7hQW9WdUSsdIPU3XdLZutAF+bcEtQNESLLc3+2
X-Received: by 2002:a17:902:fc8d:b0:216:311e:b1c4 with SMTP id d9443c01a7336-21f2f1376bdmr42120945ad.4.1738833388244;
        Thu, 06 Feb 2025 01:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSe5gm5LJERYAmvg8dHA+fDyQb1fgKXbdgKW2vhPm52yEY8EgsuICmSTYNyrMf5sx++mDUVA==
X-Received: by 2002:a17:902:fc8d:b0:216:311e:b1c4 with SMTP id d9443c01a7336-21f2f1376bdmr42120655ad.4.1738833387855;
        Thu, 06 Feb 2025 01:16:27 -0800 (PST)
Received: from ?IPV6:2804:7f0:b753:c149:7884:c5c7:2b46:5945? ([2804:7f0:b753:c149:7884:c5c7:2b46:5945])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af65cfasm714162a12.62.2025.02.06.01.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 01:16:27 -0800 (PST)
Message-ID: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
Date: Thu, 6 Feb 2025 06:16:22 -0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org
From: Rafael Folco <rfolco@redhat.com>
Subject: [PATCH] Change min/max to float numbers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make min/max consistent with avg by recording the latency samples
as float numbers instead of integers.

Signed-off-by: Rafael Folco <rfolco@redhat.com>
---
 src/oslat/oslat.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 9e5a08a..6d4a9cb 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -159,9 +159,9 @@ struct thread {
 	stamp_t              frc_stop;
 	cycles_t             runtime;
 	stamp_t              *buckets;
-	uint64_t             minlat;
+	double               minlat;
 	/* Maximum latency detected */
-	uint64_t             maxlat;
+	double               maxlat;
 	/*
 	 * The extra part of the interruptions that cannot be put into even the
 	 * biggest bucket.  We'll use this to calculate a more accurate average at
@@ -330,12 +330,11 @@ static float cycles_to_sec(const struct thread *t, uint64_t cycles)
 static void insert_bucket(struct thread *t, stamp_t value)
 {
 	int index;
-	unsigned int lat;
 	uint64_t extra;
-	double us;
+	double lat, us;
 
-	lat = (value * g.unit_per_us) / t->counter_mhz;
-	us = (double)lat / g.unit_per_us;
+	lat = (double)(value * g.unit_per_us) / t->counter_mhz;
+	us = lat / g.unit_per_us;
 	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
 		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";
 		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
@@ -526,10 +525,10 @@ static void write_summary(struct thread *t)
 			 (j == g.bucket_size - 1) ? " (including overflows)" : "");
 	}
 
-	putfieldp("Minimum", t[i].minlat, " (us)");
+	putfield("Minimum", t[i].minlat, ".3lf", " (us)");
 	putfield("Average", t[i].average, ".3lf", " (us)");
-	putfieldp("Maximum", t[i].maxlat, " (us)");
-	putfieldp("Max-Min", t[i].maxlat - t[i].minlat, " (us)");
+	putfield("Maximum", t[i].maxlat, ".3lf", " (us)");
+	putfield("Max-Min", t[i].maxlat - t[i].minlat, ".3lf", " (us)");
 	putfield("Duration", cycles_to_sec(&(t[i]), t[i].runtime),
 		 ".3f", " (sec)");
 	printf("\n");
@@ -547,9 +546,9 @@ static void write_summary_json(FILE *f, void *data)
 		fprintf(f, "    \"%lu\": {\n", i);
 		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
 		fprintf(f, "      \"freq\": %d,\n", t[i].counter_mhz);
-		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
+		fprintf(f, "      \"min\": %3lf,\n", t[i].minlat);
 		fprintf(f, "      \"avg\": %3lf,\n", t[i].average);
-		fprintf(f, "      \"max\": %" PRIu64 ",\n", t[i].maxlat);
+		fprintf(f, "      \"max\": %3lf,\n", t[i].maxlat);
 		fprintf(f, "      \"duration\": %.3f,\n",
 			cycles_to_sec(&(t[i]), t[i].runtime));
 		fprintf(f, "      \"histogram\": {");
-- 
2.47.1

