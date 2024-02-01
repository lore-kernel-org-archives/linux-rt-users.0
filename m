Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA27C6CA
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Feb 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809881; cv=none; b=eUsxojGsqj4ZFgXOQc9aLhMQI/HyD13U3tNNBkEN7sw3yOczBoCOZbL8RSUgfCkutBdvb2TWoiO5KKyskA9tY37+5olfu9oVBhh3mZGdBGewJghFNfFQ4kvDIi/oO6Ihn6Irx47psHqcXUJAQ214xX6ZBqfQoLlKRxL//4ZYqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809881; c=relaxed/simple;
	bh=wZCiReGeSWTpXpLShEr5Q5VWyKGPy4sZGmly9UsMkQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CI3wZu2kTquFBbjgD6zJ95MvDUnqMZxbGkbz+kZuZQjcIgl5S+MOWiPR+xGXQ6jFMVPDl3FalvRoVqTWS4KKwc5wokVjmA+/Ge9uXlXXML1Fv8m3/cEQ4NGnXGpJgYbM8nwfd++/MStp0TYLBli0df6TmEGCbB0GjqwonV7cCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ0Gyy3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ0Gyy3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706809879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9k/WywEPf7ADkkV76UcmYbNhpJhINrRsLHFGePd7itA=;
	b=JZ0Gyy3MaBP4siEYl/hK1lZ7Je9LPcQZpD8Nt7wI9Yf1MZ8fMgj/UOHe05r4Cln3xMXlqA
	5XXfcsFhcj01Lh9R8+DnoKjIZ0nmGS/Qq+DLG/un7Lkk0V+c4g+wOLZ200a5DKa/bO5dHG
	1JyKO507byFZ81zfb26kmkuY2rej0JU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-11KjQFmHPvCOFYSO3buvuw-1; Thu, 01 Feb 2024 12:51:16 -0500
X-MC-Unique: 11KjQFmHPvCOFYSO3buvuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3295185A781;
	Thu,  1 Feb 2024 17:51:15 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A6832026D66;
	Thu,  1 Feb 2024 17:51:15 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id A7A664053ECA3; Thu,  1 Feb 2024 13:05:38 -0300 (-03)
Date: Thu, 1 Feb 2024 13:05:38 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: "Newman, Chuck" <chuck.newman@hpe.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: oslat should use MHz, not Mhz
Message-ID: <ZbvBUmLef6FabeUa@tpad>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


Usage of Mhz, in oslat, is incorrect:

From https://www.nist.gov/pml/owm/writing-si-metric-system-units#:~:text=NOT%20250%20mms.-,Capitalization,the%20beginning%20of%20the%20sentence:

"When the unit is derived from the name of a person, the symbol or the first letter of the symbol is an uppercase letter (W for the unit "watt" or Pa for the unit "pascal")."

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Reported-by: Chuck Newman <chuck.newman@hpe.com>

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 4bdca64..e398f20 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -501,7 +501,7 @@ static void write_summary(struct thread *t)
 	calculate(t);
 
 	putfield("Core", t[i].core_i, "d", "");
-	putfield("Counter Freq", t[i].counter_mhz, "u", " (Mhz)");
+	putfield("Counter Freq", t[i].counter_mhz, "u", " (MHz)");
 
 	for (j = 0; j < g.bucket_size; j++) {
 		if (j < g.bucket_size-1 && g.output_omit_zero_buckets) {

