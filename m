Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DB2737E7
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801904; cv=none; b=VbBGCPcWyxi0IBWa1rqb+V4YXproZK3MLCHj0RjIspQrBnOumrpPK0czl4p5c9U23d28fhvIjxm1EzA+tXs69T5WDikJFPQI2csgN8H9vVHc/9RJyCcQP/Lp3H7JUd+r2BIvE5dCUsup1W04YokO4UQM3SvizZs7wgDKiVTnGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801904; c=relaxed/simple;
	bh=KoSBxg8EDbvoQRq/lW09ixy0jbmY+zoKx0wVaQG8BnY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tkz19l2ovsQyNeCAyX5KxmAGui9QjNKjzezfgJkJhJqeMYRhs3tSYABG7k+57aO86GdJ877sXRWvob8ad90/rhc7EuVAZFoTiVhLwuo54XQiw2GGz2sDGx5uzV4G/6zroaLMpPOsl11BOAlCujlKH6WgSUc5+QJih/tO4jk1q9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyQLm6xQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRbalFTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyQLm6xQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRbalFTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762801901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pZhRLKy5aKjNeARrJNqNFvWXIjvQWF3l6YwRWLH3FCA=;
	b=XyQLm6xQVamLbViB9sP1/keLUJbYD7n5dd9TUbFKgcFOrpnuvuuRqp8uCPZP1pLRQVf6lf
	o9r0Y14YbsiiDWgULBvSRE+0hVZZcYZsRcQDofmEvsRO2Zw5j2tM5xsZjKyIRnlgdTGwUZ
	bKbVUb+Y5ea9F/6bWRz0xxOKIwfRBus=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-G7nFRYXPMmWS_10yQUW_3A-1; Mon, 10 Nov 2025 14:11:40 -0500
X-MC-Unique: G7nFRYXPMmWS_10yQUW_3A-1
X-Mimecast-MFC-AGG-ID: G7nFRYXPMmWS_10yQUW_3A_1762801900
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b225760181so414509485a.2
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 11:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762801900; x=1763406700; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZhRLKy5aKjNeARrJNqNFvWXIjvQWF3l6YwRWLH3FCA=;
        b=QRbalFTuJc20Gw82aFxViIqSRhjEoWNL96A22ZYjKoHs7N/XNNsqxeJfCqvaXU8IjA
         O81ohrernSRztsvyX1SfjShIcCK7wldIXBwMdmWGm3rJMO/aeY3ZG6GbvLasEgNwPlj8
         6iZtP/ZJI+Wc1mEpz6NyEnyLVYdFQMG4tCuj08u/xhyT4zCSDAKofVJBL/aw2siMRC9E
         OLHqSyhpErCBM4+bXrzZ02fgT9Dnpc9VZF3d9SKYSmffjSUrQcHUHMAczzpIhiN3JUxi
         NTogj7qMurAikEX2Wvdm5haXKqWXCKmonNlPHXmfDF6ea75qJS98ye8oOkruEX0ZJAch
         aFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801900; x=1763406700;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZhRLKy5aKjNeARrJNqNFvWXIjvQWF3l6YwRWLH3FCA=;
        b=lKsYhDUQOp5CQ4OWoK0SpTSGZRFPm7gHvvhZv7+JNVenIDSx9pqqa82T+Sk0N4Dd2+
         zuNKIqFc0ZeiwDDSsdLVE7igWJrVwaySclIsuB17r5096AY+uGsg6urxqzKL5O6AEgb8
         5ezOq1zlJsVfuaS2NORjozS22kiDbYK7SxcI5PXBSFF+zlgXe8SIx2HKca7+zd1S0Hyx
         8NaxDqVxIdBzDgZssm92NDxFY4kKGFqzH+szggBYsIg5H9MkNwVuSKsLsobBD4DUSn51
         /t9FZLNhahy464kFGe3GucY8PxRYIPKa+hEy1vv3Vid8cy1n8sfzqpVyC7b/1xIuU9Sz
         Kg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgsgWWX/0bQCfQ40Tyih5z0B1HtYI9ybUKfKrOwgv3Boxxh15Jvpv0SLV9/a3tn1b0SvqJ/5AVVr6YiVq2Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1o3CwLGzj/rXVAzYu0L2TRytBB8ZLo8q47YOyqOd8OEfyDuH
	Detd747XDCwfp5144Q6bF25DBbyK7++hMribFMz9d355hkTR5Gnna9yqm4BIQ9DR+smtHTI+NRF
	gSmc+khdRz/HeeN7w2MWiL2lZ2QAPe8Oda8nUDPp1y1CnfCflRpV8bzDtSK7pMiXPOFtY
X-Gm-Gg: ASbGncsx4ov9SenCQ+GLcGhdfDZPw+kdaMuusNdnOEfUKeg3gP0NbnAaQ37cEi86Kvl
	RJnq0D6zD14t3d9XhkfGlPnZ0gwx04a7a+QDcbXjHDu4zfwqUBPxl3sJh+X05KNn6T1si7ZtLEb
	NcgjrglTaNBmMfzkK38pcnR2vvFjw30xnFSyhHiv3EUALYuzGuDZuM41OZ5ADEGThxhgyaHzxEk
	TMu2amuTzOKtJ6/nCSP68EEIxjLMyHNajSM/gWDKupMCkEeJqRIobwJNqnFI2XWq731Ky3FilnU
	Fqos4wgOeMEc0HZwx7w0YBxi5k2ZV3V7EVEZ2sIU3l6sIoI/I6MMqTdIlcJG2Q==
X-Received: by 2002:a05:620a:40ca:b0:88f:5dd0:9a93 with SMTP id af79cd13be357-8b257f50d27mr1179592585a.48.1762801899825;
        Mon, 10 Nov 2025 11:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqO39JUtjuyXdkMCqFHh2ojo8OjUyq6/T19kXGx9NE5rSj1XiFyFGKvMVcDiRkpa05q6bODA==
X-Received: by 2002:a05:620a:40ca:b0:88f:5dd0:9a93 with SMTP id af79cd13be357-8b257f50d27mr1179587485a.48.1762801899268;
        Mon, 10 Nov 2025 11:11:39 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580d364sm1058658985a.45.2025.11.10.11.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:11:38 -0800 (PST)
Date: Mon, 10 Nov 2025 14:11:27 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rteval: Move unittest.py to tests/
In-Reply-To: <20251107134749.257350-2-tglozar@redhat.com>
Message-ID: <2eb2aab4-eb87-f88b-e979-9d4cce2465eb@redhat.com>
References: <20251107134749.257350-1-tglozar@redhat.com> <20251107134749.257350-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 7 Nov 2025, Tomas Glozar wrote:

> We now have a tests/ folder. Move unittest.py there, and remove folder
> unit-tests.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  {unit-tests => tests}/unittest.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {unit-tests => tests}/unittest.py (100%)
> 
> diff --git a/unit-tests/unittest.py b/tests/unittest.py
> similarity index 100%
> rename from unit-tests/unittest.py
> rename to tests/unittest.py
> -- 
> 2.51.0

Nack

This one breaks make test.
this type of unittest is not widely used in rteval
and was written before and conflicts with the unittest in
the current python library.

In short, I'm thinking of removing the old unittest and 
might replace it with the built-in version.

