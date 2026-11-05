Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906915;
	b=BUzGTk+rMyGvPTPgw9EXtMRaFF9w6xDde9xwfmInSG8Fw1gFgrZAWYFoEkbt89THAaUe
	 1FEEInoU7C6RNd4ZecFgUFBjIa6mjJdV1fa4TLejMKWueHFmdCfUkUlBFZRG/LQIglh7d
	 jAGuC4Jdu3KFCmA1QotDf4L+t/KHa//1lmns7xMbN5kvRAPB/PWw2g+i0TzJJ7Zr97J6p
	 wlJweh/KJzMlM3bG06DgUsGf29f7+oQo3oPhLLu2ys2vFB6nBfEoXuyYpwN2UcCKch5yn
	 jMf4DGmDEcZ+P3RE37sPIp2+3fb6+RD9mHbEq6FUV+RJMie8bksXDvbjpRrMMjgL4BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906915;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=iE12xid6OPg+wbKJdaXmqZSnSKLeHDsAdgGp/QIchmg=;
	b=1aCIqOJHdycnTpAu44ZM2Kql41z7gvF2NdvuV9SESyJJwig4Q3Su11jw+wFgfMHNL0lG
	 TLOG+OVdO7nyrss+2zzMGD6g+Bbl1tB584rBuXcMcJ4X7+oP8pft6DPB9Ttp3eRZHNiPP
	 vnAU4Re4Pn3ZzcVWnv7eLdefCCD9oiBn0aydfIWy6iEVDRgyrFQAPejzoldDhp1eBWDTi
	 /J9mRTnCx+xH8TRwRIKjJklWp2GOBgynQeTdfqmS682ANEc8mdSjYn+29tGapuEcRHlOY
	 YNDAC+RumbSgRptz2XNmvyY+udlc/EkQk/hZ4uK2kyagFjdPbcvoTm0QWjvGGzu2kFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9Xeez7M;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILvwNpoZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467E606A326
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Nov 2026 19:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1467E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9Xeez7M;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILvwNpoZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793906913;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=iE12xid6OPg+wbKJdaXmqZSnSKLeHDsAdgGp/QIchmg=;
	b=b9Xeez7MM9ZPRGe0PVQzj+MLenCQA2W7jEBmhFWkifoVpHn6zmvHW5hT7DoZi9tjCWusRv
	aMrAyshpZc0EfgERceoRS3FZrBsMVaaDDgzPrV2XgW/JISJ6LQ0Dh2sz68BnEhV3QXMoyL
	4f0BFHR6rVU3z65B5FflIGdO4AkD+lc=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-gLrU64juNHqCQ7uNuYx_3A-1; Thu, 05 Nov 2026 14:28:31 -0500
X-MC-Unique: gLrU64juNHqCQ7uNuYx_3A-1
X-Mimecast-MFC-AGG-ID: gLrU64juNHqCQ7uNuYx_3A_1793906911
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67be4f2f42eso3585357d50.0
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2026 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793906911; x=1794511711; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iE12xid6OPg+wbKJdaXmqZSnSKLeHDsAdgGp/QIchmg=;
        b=ILvwNpoZjUMc73U2rWSCTVQ3iuBuv+sz+0D2s4Q/shCRdJsKG4RY17tcg0mh1udxCa
         ZHKr/+FvVeQb4u4+ckEZutOvRygiTINjwdAB0eUEPL/FXuyJY/5fqpbO1tmEuH1aC1Md
         6S2tVrS7e0S7rNFwGUBgfhZtZZqC7rUGSijdZep+J6MRDBQ8HxTVApNltq/zxdRDQm67
         LCRYLgAqfEVnAaqu6Zj4VI0Pfv408KUlr17gjX6xF1/xoHRuH5iQJd3xjgnSgwnTnE/b
         mrM0eGlZOmGFTNhCY+vLOMNDkp+tI21DQ25P64bTCkDavnMVHbztaHXR3nxMvKfM+GDU
         Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906911; x=1794511711;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iE12xid6OPg+wbKJdaXmqZSnSKLeHDsAdgGp/QIchmg=;
        b=tzlAoKRxqY3DJbEe11la+HAjBl2h7J03uPYneVIkYIGeBExEvvP1XzoY5TIOFz4eAC
         Cf1UTKhE4mvjPaFhX8IwR/27ePfyK5CEeNqGhqYZfLSm099xC5bVtTuGUC5/PN1WEtgo
         kWWJ+4Hs9CdBfLnP/QueWAfC3DBK32ho0yVAA6XRlhZdHfCQQWFFVIUlQcggP98dzhUS
         9LqCElZ8Y3XmAqsapH57pQ1JieIxhDXK0lr1OgoALAVKaliTca1iCUderRhnER9AOXcw
         TB03AadU6Oszue4xq1MByVfEdcvzAaDkFM1aJcTL2ZeWU2v6LB0Nn3GEqZgNxXdKmq+t
         BjVQ==
X-Gm-Message-State: APuU4Z+YW2h4G9t/8zPSRloNrxtWCPv12b9W64VnT1GI7XMksDZLXLw9
	ue0iyH8aNEyUddnSlmg1R4WsAtqlfkkZIrI+TWZcOuahWI9KFC5A4CEyjepcqKwcxpGYu5Jr4lo
	/kbTwndr2D2ztCJ84VTiij12GDd4TO46WHta3KjkPRQ4CIWBt8qpu01Fh6QuYnoHLSOwflsbj8H
	bejcJjrTBQKSXZyEo1X+X2l3VSSVvU7uFQtPDch/jWgPND8JV0XJwwarI=
X-Gm-Gg: AYBFou1WrkPvBvBgK2zDaOBsw1/kAi1sIyoQEi7Vc0AFGzk2wbtFg0pIsxHd2fu0qb2
	1sfHkQoiU35cM+mkc3jlVb2NCYYtNqtQxucMfMGvJOt13Zhl+9IfGUzrVPz6eL8CTlCdu6zYpWw
	4Oio3rrWMxvql5Qmq463Pcuz6nod6mOutREpvpatkIHOraTe9+9q4zOD0OwtE0bfDtgk1izSL7x
	nlZwJfoATCM/tuaw2PknnT+s/J12sb9nbEL9Kuu0+IfpUnBr1vjxE+y/A4bLDb8BvcyHDl1wixi
	O+V04kP8RrBkcr0p/mW6iHrhDjRUVIhyzOnQO6gLmVzadJz+aXO837NFJlNO1NMCu8xdcvqP5Kh
	0ol+a1Lq5DH+xZqxNGcMQUayRcgBywg81tbwFIynGztRljg90+pgvjZnqGMDh4KlYZeaN72PW0G
	SR8LrI6g==
X-Received: by 2002:a53:df87:0:b0:67b:fd46:ef9b with SMTP id 956f58d0204a3-67c143c852bmr111548d50.47.1793906910949;
        Thu, 05 Nov 2026 11:28:30 -0800 (PST)
X-Received: by 2002:a53:df87:0:b0:67b:fd46:ef9b with SMTP id 956f58d0204a3-67c143c852bmr111530d50.47.1793906910108;
        Thu, 05 Nov 2026 11:28:30 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f884790sm2433467b3.41.2026.11.05.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:28:29 -0800 (PST)
Date: Thu, 5 Nov 2026 14:28:28 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v2] rteval: Edited documentation for multistressor support
Message-ID: <auzY3JabpPCiiV1c@sansshar-thinkpadp1gen4i.boston.csb>
Reply-To: sansshar@redhat.com
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Edited doc/rteval.8 to agree with recent code changes in stress-ng load
module. This is specifically focused on the multistressor support
changes.

Assisted-by: Claude Opus 4.8
Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
Fixed typos in v1

doc/rteval.8 | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/doc/rteval.8 b/doc/rteval.8
index 370bad9..660a0d0 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -160,12 +160,21 @@ Source tar ball (default: linux-6.17.7.tar.xz).
 Number of working threads per core (default: 2).
 
 .SS Stress-ng Load Module Options
+The stress-ng load module only runs when at least one stressor is specified via
+\fB\-\-stressng\-stressor\fR or \fB\-\-stressng\-stressors\fR. When it runs, it
+takes over as the exclusive load module (other load modules are not run).
+Stressor names are validated against the output of \fBstress\-ng \-\-stressors\fR.
 .TP
-.B \-\-stressng\-option \fIOPTION\fR
-Stressor specific option.
+.B \-\-stressng\-stressor \fINAME\fR
+Stressor to run. Repeat the flag to run several stressors in parallel
+(e.g., \fB\-\-stressng\-stressor cpu \-\-stressng\-stressor vm\fR).
 .TP
-.B \-\-stressng\-arg \fIARG\fR
-Stressor specific arg.
+.B \-\-stressng\-stressors \fILIST\fR
+Comma-separated list of stressors to run in parallel (e.g., \fIcpu,vm,io\fR).
+.TP
+.B \-\-stressng\-workers \fIN\fR
+Number of workers to start per stressor (default: 0, which starts one worker per
+available CPU).
 .TP
 .B \-\-stressng\-timeout \fIT\fR
 Timeout after T seconds.
@@ -238,6 +247,24 @@ sudo rteval -d 1800 --measurement-module timerlat \\
 .RE
 .fi
 
+.SS Multiple Stress-ng Stressors
+Run several stress-ng stressors in parallel as the system load:
+.PP
+.nf
+.RS
+sudo rteval -d 3600 \\
+       --stressng-stressor cpu --stressng-stressor vm
+.RE
+.fi
+.PP
+The same set of stressors can be given as a comma-separated list:
+.PP
+.nf
+.RS
+sudo rteval -d 3600 --stressng-stressors cpu,vm,io
+.RE
+.fi
+
 .SS Analyze Existing Reports
 Summarize multiple existing XML reports:
 .PP
-- 
2.55.0

