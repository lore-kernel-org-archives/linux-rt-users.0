Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096B1F8690
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124685; cv=none; b=JtXrsjnxccUQiWoN2q6REexSGy43GxQt5zW6JqPLAqCEVmeUtRwune/Q1tRCKRu46FyD3hoFXXeJMX8SLv3weD1sthbK2tCcq7RClnZ1DssBmAQP4KteAW+VF0XBJ5EAKHbCjHKPIdQQ7r8GKuEKUcVSYaRZ2f20z+E9StmQgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124685; c=relaxed/simple;
	bh=IKfw27RbojebdCRYvLKRM0C2I9qjSgibhoKoSDP3x7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pTc5ZS06qGJZZgNpc6BnTd+wSnNTW94U9/TcZ4VSwKxwEq1Yc3GS9am5pTj7uHra6wD6R1NuwHCqnjRPS9i6qMcbLpVTN/NX1xrfK7SIkomEAxP7AmvfSb2pkC+W43N1gg/sd68GrxwaaceUhFek4pFNX4rsITuGVmR71EcWuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlIzCG0T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlIzCG0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753124681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay/0bDBXk/ChHJH9MV+1uZTSc+1Cnasqr1r98Y2eD2k=;
	b=BlIzCG0Tfnlg4MIhDTmgh60pWZwwBidyI543Q0+i+KJWNiRchkvuKVl4tal8ohN73qj4LF
	6PqPyYH5ku7n7su5YgMF13bJo7YNrgvbT7KQyx++34vicDOgj0VuTeA03wMhATlzy6Hr2s
	kRpNlDlOPDxqc/aTyuIj877pva87Tac=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-sByS-HJ5Na2Tc8GOqRcMlg-1; Mon, 21 Jul 2025 15:04:38 -0400
X-MC-Unique: sByS-HJ5Na2Tc8GOqRcMlg-1
X-Mimecast-MFC-AGG-ID: sByS-HJ5Na2Tc8GOqRcMlg_1753124678
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e190b977b9so701360385a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124678; x=1753729478;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay/0bDBXk/ChHJH9MV+1uZTSc+1Cnasqr1r98Y2eD2k=;
        b=HHzBUrRRJw6H6PjlmFtfyAw/EAc/6IFX9GyiXcP3+KxDISzGysbuaVHu87mOTokZKl
         eQVqeib3/DeWFsEPJbBPvwtaO8bXPzcQA/FtLcjYVGcP3nTkkEk7n7HAq8B6qSJsBU2q
         unTX0hDRJK+1J5gLuGs4KJpoFRlohrrIAP7lmb+DA3D2lzsywHu2TQcCAwBqzNPQMkfH
         sA1C+Po495EjbrEmetIXI1GIPTVqVYf6ZI6BSho5T6DJOktpnBZCTqWU7HZ4E4i2CiL2
         RyaurJbotY52ijasrEpHeR7YQxlOBRXlERKKA/tabNRZHrgWxGqQ+9s8V35PFBHPirXX
         r5NA==
X-Gm-Message-State: AOJu0YylvXxqJcWJu5E8exV6WONsT6DFFlA5yPkAxLNPrn3dAXnYKaU8
	SdPyueuufi9dhqKef5np3iEh5VDHvTxGTN1Y17GTlifvTuE6qraBIsoUyUoNjBNS4k6AjMdSIYM
	5RWwRWdhSsTwvs2RkaITWV5HyQKPD70Y/YDQSXI5ix1PBpqfQRJTGbIC7R5pYXMX2CoIjVGZ9CQ
	WI
X-Gm-Gg: ASbGnctUiO1IrX1oGIaVqVLGcEoUz0Gqcl2oyY4Mgcsn2Zcc5aQQOiNGIHHx+SIByUK
	phK0ZpIf40YmdDFOS1rRuwwIL+RxtzYuiKmXY+145iKBB7LNg19c9ckyJwTgoCoaiwv5NQEFC7q
	BN4x2zI7Hsui7/vJOM9cb8Uoom/qalnVmmdGb1ts3yTvp8qOlDYzhuQn0HgRgRfL64T0KVdo6WJ
	tCOMuoll+EtbN3XHoednWretutn+13l6Y2/NhXTG/IlMkemXxR+AFFsHlfw98/xffa3QvZuzIzX
	PLO+zzWyCgFJFUmP9QruCZzO96T50Q==
X-Received: by 2002:a05:622a:229c:b0:4ab:591a:7d97 with SMTP id d75a77b69052e-4ae5b72b410mr11202581cf.1.1753124677507;
        Mon, 21 Jul 2025 12:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCp8AAhVzJVdXcT64sbKM8JT6MNBl5YwFGwm7NRFuqsSpWvkAr/n8Cn32ZkGZ8YaDeS0hd3A==
X-Received: by 2002:a05:622a:229c:b0:4ab:591a:7d97 with SMTP id d75a77b69052e-4ae5b72b410mr11202131cf.1.1753124677012;
        Mon, 21 Jul 2025 12:04:37 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90d3cbsm42765336d6.43.2025.07.21.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:04:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:04:35 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 05/28] cyclictest.8: Synopsis: Remove -h flag
In-Reply-To: <20250704132721.13325-6-darwi@linutronix.de>
Message-ID: <4c9d6022-26d7-d7d5-13dc-75d952ce68d3@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Per commit 79ad2eca9abe ("COPYING file and cyclictest's man page added"),
> "-h" as a flag is an invalid left-over from the template the manpage was
> based on.
> 
> Remove it from the cyclictest's flags list, as "-h" is actually a
> shorthand for "--histogram", which is already documented.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 76b10f3..c1a7b29 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -17,7 +17,7 @@
>  cyclictest \- High resolution test program
>  .SH SYNOPSIS
>  .SY cyclictest
> -.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
> +.RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
>  [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
>  
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

(it kind of works anyway, since we get a usage message when histogram 
doesn't have a value)

