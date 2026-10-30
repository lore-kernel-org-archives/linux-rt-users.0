Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369235;
	b=XKTkHIBTxr6XpafOdLMKIObAhio57owYaTjLiZZoOfXfHmJvkFHmpw4BiGGrZXWmeDZl
	 D/wMsgJQiMwE5L94SKZncjBp7XaePizi+kNUz0IR9rvzVVZNVQ2Rl5Zh94FJMjMRONkip
	 j45QuTSIc0dBerg9H+cid0C6+HX1ZglXClAhqOyxI42H2KkVBcyMysexGEj48V+6WeZoY
	 o+qdYIx8kevRn3OL0EdqzcFnRld4uxRdaAC5F2CZ1fsEZ7YZ5WewTqDRitlDVwtubECtW
	 M5msL0SgArDR4VQEARlgJz/xj8DmBquEWQO1CBxM6wyTSuawxrxY/R/OCmUR1cVkiFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369235;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=zoM4R8L0NsgNZ74J7hgL7qbPEkh6Tseal3fZTFzp1ug=;
	b=V/Gz++1cH1ViGOknL4IkHHoXimWgaeInCg5HlJE3Lm1aEbf2UiUWNCc+CHycefa2yZKj
	 BM2jcCKPiTuw6ojcqy2W+j2TZiLQNK0ey23P6hIolVu9go2MHFIoDAbIxTgOWYNSrZNzS
	 Hcx+hIT1DnjnoV4It7CJZ9/1nGbWTkXI00pXL1MdhlEKxQ60F7JCYlYS76uEBAnFbdUQV
	 1/Keo7+tE65gti4mjuU1WblHKD3RGsh4Fp3l6CwYyU+iJh5GseSbnAIVtKb6fff4icuxy
	 pLJFYSfGuXRkTy2ZBgI5Sq2AGlcYjIp61IqyA1YTHnGg8MYwfrH0IZ5di7GFIrcCgPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BFJKA9MF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LHtEADy2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91727606A31C
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 14:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91727606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BFJKA9MF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LHtEADy2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793369233;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=zoM4R8L0NsgNZ74J7hgL7qbPEkh6Tseal3fZTFzp1ug=;
	b=BFJKA9MF7QhojwqyuN95J2JV/K0VjItHWJGTZYgb/cHUH9Hu5JDSMAwLAdD0LNmD+winYI
	OrbnGQjYEssw6RCSDbKoPqRylI07Oy+E8VIZ4KJY+u6Zr5uM8SD8xZpFiYZBH2BzRkV4f9
	fscgv4FDQ9Fq0hm8OOTljW8PjimTpqE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-KBJY8hLWMGuWVYvcXiNybg-1; Fri, 30 Oct 2026 10:07:12 -0400
X-MC-Unique: KBJY8hLWMGuWVYvcXiNybg-1
X-Mimecast-MFC-AGG-ID: KBJY8hLWMGuWVYvcXiNybg_1793369231
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-536778a8137so13331591cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793369231; x=1793974031; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zoM4R8L0NsgNZ74J7hgL7qbPEkh6Tseal3fZTFzp1ug=;
        b=LHtEADy2yE2Tut6eXV39d83FGBExXo/nBj6MYNcjx1NuKZYr1wrttshtt13Cwk+m2y
         AGbsXAyYuhRmx47cjl6PoPdCNNUAlk9RKcXrSEfxTQX68HTEfFdjC2W10dNPa24XhrDy
         JhpHSQXNtUMGYBJ9MlF2WjcrVOLxqXxKt7w++OyetvWDeCK3OE52Dj1aYtLXUsM9e3OF
         r+tJprzngZVVAvS5vZ2wuascCycV1UZrXEwFOp7hAIhlVk10l9Iz8ALU7/z4fc8jjY5l
         xoXdmk2NBJY9d0PqvqYB9llPxrR1Qxl86yQiuVOx1XpDBfJ0N+Qg072VlN3XLzMHf+ve
         2cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369231; x=1793974031;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zoM4R8L0NsgNZ74J7hgL7qbPEkh6Tseal3fZTFzp1ug=;
        b=g0pkTOuQDAELANbiD25wr/fLLuSbhI5ZHHGHpRRgzP6cFMVtrAblq4cRpL2/jQnfhj
         YoYAij9VVvU3DDjkOJQJcdfnQmjV1R6nn0RotMecssax2lV522VIF1btPCTsxdBNbu+M
         cAPAUPOebMyB0pVxddtaEoKa30zNrBFUWWCpAXHKgdqce6yjP/pmPUbocIXBLWaPuwjf
         asErNaRv17rqNzMo4LEQK4PbjwGBMbiim5owzW1cqjRL1dXNDgCJGHqUpae3C2cJq4XA
         +eIHg1SVKu2acBWlzEZjcPhiky2FTNWSyqA5dGRe4DHTF/BKQokewekePNHGkyIa07wX
         H+9Q==
X-Gm-Message-State: AFq9FYKW4zzjmrlqXPeInLjA+O5iR+Q6/qEBiKUdDwfZMV3B+Ig5bB94
	YTgi/nHHMz3LfEQ7BF0zmZPLlawFhkwE9CbfG9oIkaw/qPNYAQRrytuxxXidjEYsI8t5ExklPcQ
	qaviHBwUf1qVETzQN+EeahnvIeDJk4RskidacjJEgQyvNGZkaA1ynyuWcKZmqbn4xtDRYPcsig0
	T7ZNwOHJ9JjXn8OgLh2WwR63YatB3MdNa1OO7esXXs93RyXt1tSZI85D8=
X-Gm-Gg: AYBFou1YwkLhb8Iv2+uO5cq5in8Wv2G2a9yQO219yEQst6/VBtfURVLjer1HluEA6fk
	4LZnHESOJVjkvtkOBT83tIZKKqeCIvhnOt90slxSotSOvJGX9QWKcQjB09A3+YKCwEEQh6SF86R
	GL9BlgRga+NC2Y1E61O8Zdx4LuMfRjLuMkylumP3ctmWTGjwAhnF6Gu4R3Geeu/EqxIXd53bv9U
	h0EdevvWMYZCskEBC08hZBdCCVOT4vuOJ8RiMW3pM5NpOC9iHEvdzySsVr0jU5Cal1kQ7/DOSDx
	3+p28L+My9IUKAk0rhucay0NN5DCq56jVlo2skocetMUzskvnFtVhZIpz+ibgzb/Dr12XIVxxef
	jiBc8vYGHa0wXxK5TzsEBXvZciyXGyijAloysBFawHgvQerYFcTGIO0Ye78ux7MJsNJnFTfRmOX
	v+CYNLvBg=
X-Received: by 2002:ac8:5a47:0:b0:535:2447:3d03 with SMTP id d75a77b69052e-542b7144d3emr32268231cf.35.1793369231248;
        Fri, 30 Oct 2026 07:07:11 -0700 (PDT)
X-Received: by 2002:ac8:5a47:0:b0:535:2447:3d03 with SMTP id d75a77b69052e-542b7144d3emr32267351cf.35.1793369230462;
        Fri, 30 Oct 2026 07:07:10 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5431199514bsm14271581cf.5.2026.10.30.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:07:09 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:07:05 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Edited documentation for multistressor support
Message-ID: <auSkiUhcFJAO2-_Y@fedora>
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

Edited docs/rteval.8 to agree with recent code changes in stress-ng load
module. This is specfically focused on the multistressor support
changes.

Assisted-by: Claude Opus 4.8
Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
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
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

