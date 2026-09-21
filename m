Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E8247280
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2026 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964555; cv=pass; b=Fs0o03IskkXoNB4OwrFSpfDpx+A+svPo+7BDpQQ0d8fKeZggXd2kJYEurHq5s3wxGX2xgu6AYUlMxxs7xbysyi1r0GokUvlmfXUoJ6bW9wEK068sBCJGLtTHYgJn94fwWr84iHGuvjWinY7znQEYGNV4141pFMV4Ul4AsS5f7e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964555; c=relaxed/simple;
	bh=V7dcKA19Vn4OLNirAI/fzi6nQvr1myU4q0y/JbpnLM0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U3JuOUtaafS7uIN1FWDUP1Sg+s5rdhKnQGltcvqzXFh67vVDirZWI13C0B+PJGk0JHNn6UGauxF3tJv7dLbzU0cc6iXX5qUi4lNUKnvUu5w5kLpgsDVxU8kiUFloJJRDmgZNR3xPp/CeMoV3KR+Uk753A5uJ7hnP/ffsKeM+rQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtMv7jyE; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtMv7jyE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2159447e87.0
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Sep 2026 21:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789964552; cv=none;
        d=google.com; s=arc-20260327;
        b=KJDjkKnWSIj8S2R8ATpy1zoAkvjX49yBnnFzV6iBR1Ym5WXZ9SUOKEfZiKTGciwJEX
         P7V6buVJjYODzvwfVwYj1qLJYOwLJOyHMcvEvNcnrhty7/4YzPDXb1tUJhSQOxF7CTXf
         8tyBetSW0jPZJ9lyUUrObi2KFfHEMW/bq8kBgr+E/pbtK5PLDFFMP6/UGMcvgJEnMCqV
         Lg2ZavJFU8kSQP9cc13qd4MvMDZ4esNOm8s2ApNJZIXq8ErD3HZzIvR9AqQr5GpC6RiA
         IV5l52fltsJ6hNAz8V/Bah7aNhOw1Jar88jUJNT/qVVCTYY6garf0C9m2IGO6ckDT3s4
         m2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=V7dcKA19Vn4OLNirAI/fzi6nQvr1myU4q0y/JbpnLM0=;
        fh=3byEJjXsHEe0LsUVc+7oI5ETe+uPw2m3X5rwolFG6l4=;
        b=Xm9+1P2LPjAU4kZuPOa4KbQSm29aeLSHi9bok7P6nZ8vWkuEoinlN8CekoDmRIbrEA
         lGan6CWRU6NFbF757Fu71I5InXGDwl2z+d2R3ir0qSDwzIuPusPLccWWESz8Ukkqcpy9
         H1OCrK5295wb2MWBwHu38cvQoWBaQs6nOXbtQK2tUy81LYP8mFca5jT7ARb0aPO1WqTd
         CuY5edj27kZmCshiJ1QzwyMezAQpVHCYykSwXBDESxIq8EDwKgJFLS5nXB3qS5HmkWUG
         C+jTqQ0REl40ig7tc8hWWYYPZ47lO2xCmEYaVMUO+sAWnhRJCbl+wzmBeiYy6vpdE38g
         m9sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964552; x=1790569352; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V7dcKA19Vn4OLNirAI/fzi6nQvr1myU4q0y/JbpnLM0=;
        b=rtMv7jyE7CL7yp87cBzwqgpSUgFsRfPHzJ3aa63uM2nOMDYSOXAS/KG3SlQTfbP9WE
         Xi3+wMmcinsDu8B9u9WhSqlgjdQnXl/GHJ1tN2H4W+8aqnnM/bJB/mFqt5OW75/vd+3f
         SRvsqc1oku1tRsF0xDNpYCzvM1s9vweoxRTIcrgop1v3GCxaauNxgBDqvnUWQKo52RP6
         511UXJlE7P3TwfV5naUFu2deY/+8s/C37pFqm3HGNV1X6YEEBJo3czjkLm+SRCBIwRCm
         jGVNwK0/eHsZXCQ1vOyVia+Odm60vayz1KPD0Hig9LXkttbzpFtSfaFCBjYtsZiKVO3F
         0TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964552; x=1790569352;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7dcKA19Vn4OLNirAI/fzi6nQvr1myU4q0y/JbpnLM0=;
        b=y6P0N352yvgvB5/kfsjumkshySumQ9HKVW+hJzqqEG3w/sWxl6k0CVfDvaXtuRpmhM
         5lJiExDi3MUUmqEfwf77MxB4YgqEJuFoQ5nTe3fj+Dj4ZPw+c8wUB/M8q5T5zz0O+vo5
         5h0x74Y0RLvdXQ/BKyZ66RAwV4/VARXxK4LfKra8Mh5sJZgUDBfU75hu5UMw9Rn6UBOk
         LF1qkLKD+xbGrfkoRuUcSIcixS6wJsdfigh6qcorOAdTnkAxpvouoIj0eo4RmX73uATN
         rqcn825l9hECQZJCEKOmpS5F1vcfeWpXGLxVzGFqV3GZ+vMmVgMHmHQQEmTRrbLugvwz
         AC/w==
X-Gm-Message-State: AFuF++nCa9+lr0YXIp0gk0Vija4Zk9YVsm0q63xeOdJ9DG/3FpzGP+aN
	xghiNOtSuyKeYuWVEZ4U2kSM/aVXdkMMcsPb196SXdLasECo+jCS9bv13KPH44CnPKjs23t2vZ+
	X/9mE3R1u5lpGGYHsbN4KazjZ1a7Z6cpSM+Tj2m0=
X-Gm-Gg: AYBFou1NafPripXIlAcbo6MKo+YphiGHM4cyhlVjMoNFG6uLXkmPCRli0o0vxscILt3
	QBoKdQoG+Ea4jsoxyQpjideAjcdXXC1ibIrTAuHIE8d01A3cUgx9uzzCJLIx0n9lzWtAgp4uwdA
	GtVm6VtrZ74lS3y7ovQtxfiLgTSndOoECIdG9DnWjKhWou0+FgA1QtZdZmmVgznDgrBeJZ07YJK
	25fVpc1XS7xvlSoGi6WQ3j4GSPTjaZIQbROlJAwrGtRTQ58rhnedkXeYtokHicVnLRZG5IryDvJ
	9KnmjIEvq1iT4J4qS5HbLXcmY5MC8BtHCQxH7OshMBNSNvicstFmOZIY+ww5QR/Ovpyp25iSW+N
	1tiiad6IhI9fKow==
X-Received: by 2002:a05:6512:400f:b0:5b4:a798:2630 with SMTP id
 2adb3069b0e04-5b8ba5d19aamr3781919e87.3.1789964551679; Sun, 20 Sep 2026
 21:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aryan Sewa <aryansewa2004@gmail.com>
Date: Mon, 21 Sep 2026 09:51:42 +0530
X-Gm-Features: AcwNN1XfUrxWWYq403CDXdk_kdnvEJF8TK3jpgWET6Q_halylghxU2X0h8--AbM
Message-ID: <CAB05US=e0o2dm1DBxjHkraL+vDgA1M-ufSqrQbxG5RsbRfdjQA@mail.gmail.com>
Subject: Inquiry on PREEMPT_RT
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

warm greetings,

This is Aryan Sewa from Measurecal Instrumentation pvt. lmt. India.
I'm new to linux's kernel and i was looking for an RTOS for raspberry
pi 4 model B and STM32MP135D, i went through the linux kernel code and
i actually need some guidance on how to activate the PREEMPT_RT
feature of linux. If possible pls guide me through this, i don't mind
if there are any documents or videos I have to go through in order to
achieve this. Anything, please l;et me know.

Looking forward to your reply. Thank you !!

Warm regards,
Aryan Sewa,
Measurecal
