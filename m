Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87062A02
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398287; cv=none; b=Y3GT1einZ5NM1ZsHd0TFQky4Cb+rQMZefFBEnNJiEwooG3TCzTcG2VeNrt42sUN+iZLMDk3S2icA6+DFcdacoqpdNPXcoZumGcDJPhKh97OiyCkPd4bp2cq0b6oIOTucfmcGKqsmwLph5xa18LSzrujrWXZjF4DMQ58aQbAivds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398287; c=relaxed/simple;
	bh=/LPSy6gnnO9sP7KTodHcMVfbkoR8uhkZtII0gfiVZ68=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4z8nFhmQQ02aM01eXJd0fYjISvSgO7fRALkFRdUgdJBud0t8GmBT8q4fiwDbmezNpEflqxwC8O2PWGQ7Bax7GTxegSvsOzxvHzOWkDf64oJFW/dsVrMDHCrvktdhlxUJDJIQFdgfTbjho2XNV/iFyMl4So5OejslJCBFV1FCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5ofQX6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5ofQX6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716398284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY4EoMCHiayAF9jZKkOCqTpUblFPkHrNUZZ1Ker/OE4=;
	b=N5ofQX6t6wh8rjXo43xT95NmfRWAVC4Yvs7hj30UDPq2PJIeiz/H9Ik25z46AmGaHqc1Ee
	uxiK8ExdPO8CN1dYtFiKHCLvlm1ubEsoWvjh+q06TUexDU5wjZ+oOIVQamR5DIfK0P3CtJ
	BRJgRKFFIk+rqb4gaTQYsl/x6syiELk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-0B3n3IHQMeOeWC0HwDDdKA-1; Wed, 22 May 2024 13:18:02 -0400
X-MC-Unique: 0B3n3IHQMeOeWC0HwDDdKA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-df4e78db619so1247471276.2
        for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 10:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398282; x=1717003082;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY4EoMCHiayAF9jZKkOCqTpUblFPkHrNUZZ1Ker/OE4=;
        b=IPijZEEPLvIpykXKPMeDFOb2xFONSEqZaV662tQRYRlmhcHoHz7xIdLCUOZhb7ymC5
         MDi96LhJivihkc1sHD7J3+rmfEA5zc+eq9SsdUZpq1qw+bSjR/LRBx0NKcO4MOz2VoUm
         AmQmLMZVLow3mAotI71StgU6f0FM1UQY+bn40znL1LeI+FJzr4qYCGmgSxHvZTptfRwJ
         vLHK8L630RE3RLxnChWVv9C6aPU/0wQEz8Y2sQDjj3Nbf/YklwrJOlVgCjWLS+D01OZ/
         cM6lRok0VJ5NHXKW1mdf35J0+6yi09KwFA5dKDr6vxRdn2h6cm6J+XU1u2sqs6S/sqMb
         PLKw==
X-Gm-Message-State: AOJu0YwLCCqCHa6yCKUVNHwhcSUeXS8OVewN+9Js4CNilczlA+2iGeXD
	JBcUKNwU66fIipyRzr7LSmEn/hmOpgwN6jKyvt29CdCRK9GuTevRRu5xP1rJWJ762arp2wXrn/a
	7DLTlq3U7jiIMHaT2JMaIWo7O8V+mwoBAmrNkZ5zqX385nsrkKlZYO5rv4eC3Y/VC
X-Received: by 2002:a05:6902:1c2:b0:deb:3b69:c675 with SMTP id 3f1490d57ef6-df4e0dd7aadmr2598967276.48.1716398282365;
        Wed, 22 May 2024 10:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcquziMvBLN3EYV1yW98BLbsQLtp+zdxHL0dtwl0SZcGKp8yM+63Mof7d0rmQtoCg0gfW+3A==
X-Received: by 2002:a05:6902:1c2:b0:deb:3b69:c675 with SMTP id 3f1490d57ef6-df4e0dd7aadmr2598950276.48.1716398282035;
        Wed, 22 May 2024 10:18:02 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1798f4sm135223596d6.1.2024.05.22.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:18:01 -0700 (PDT)
Date: Wed, 22 May 2024 13:17:50 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v2 1/2] rt-tests: hackbench: removed extra use of
 optind
In-Reply-To: <20240522144347.13281-1-ashelat@redhat.com>
Message-ID: <b55f25cc-f919-b717-e85e-e917c7a25c5a@redhat.com>
References: <20240522144347.13281-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 22 May 2024, Anubhav Shelat wrote:

> Currently, using the -s option displays the usage message, even if the
> option is properly used.
> 
> This is because Commit 778a02b7c519 ("rt-tests: hackbench: drop incorrect
> and unnecessary usage of optind") forgot to drop a use of optind when
> processing option 's' which was fixed in this commit.
> 
> Now the -s option works correctly with the proper arguments.
> 
> Note: The next commit in this patchset fixes "ERROR: do not use
> assignment in if condition" on line 459.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  src/hackbench/hackbench.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index d4924b3cc129..fec8357bef81 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -456,7 +456,7 @@ static void process_options(int argc, char *argv[])
>  			use_inet = 1;
>  			break;
>  		case 's':
> -			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
> +			if ((datasize = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

