Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83284D02
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406874; cv=none; b=DDNR+rtoCEqYvNnetIP5JLHz5uC6/DVVqJNo1vZ9j05l16k+ieYqBW3TWDhZmmGhu5qGnkWOVnxaboiwZ33x070od8cy0q7zYOz3FmpEA5N9PwW5DlxL9cPxyJIJwPuXbslEW4in5YQ+NlZOKsIE+K0W3DqAR/NjvtBcl1k8l5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406874; c=relaxed/simple;
	bh=gUYyP2v1cdm6dsgnwJStY7Iif1xcQj5HGZ4URqvgotY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DuTuQrVKe7IMgX4OOIFWseBUD4up9hc64092pf3f0ymfLGotP2ZW1d/TFyNg3iDu4p7IwC+kTTH3iyinNVc6HlwW45Jm31hyzIvqwFnhqiEJmTHJdsIYpmrMOUF4UDnmWpWdTaWjCJdjPeVydNliaVkvJMb8tr22AhDuYshLY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQMRHFCC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQMRHFCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714406871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tzh9Y4Lt4P9EsCz98McqJjwX2TK01+uC0+l0zyDQj4I=;
	b=GQMRHFCCeupELK7RMDWBwfT3J/uhUiAK7M2e871wxuPFKIkJRTEepRu5GLnEyS7PuV1bKZ
	oHErX8d56M8powS+g5cgoN2mhhpJ8SRSZfTSl4X1aNlRta4o0+0hTTCtlIVQbR1krhIA1F
	mcKs5outRPU8x9u5ZJo/RhXWKUvt09M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-N_NCM7EVNdiFZqqgRxXESg-1; Mon, 29 Apr 2024 12:07:50 -0400
X-MC-Unique: N_NCM7EVNdiFZqqgRxXESg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a0c1aff9f5so27454556d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 09:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406869; x=1715011669;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzh9Y4Lt4P9EsCz98McqJjwX2TK01+uC0+l0zyDQj4I=;
        b=tO9yFO1EsnP30ACB79uwQzqBJh79qmC9fbf0nYTDwpf4DeFvFt8z5IdgGOLtVPy3+v
         1aTCUSV/VdIzhSMfU8yZM9LA5YLJj6ZzjjzNej9WvU+6d7W9HZDwYoRRiUqLxMq1xiU9
         WwuPtFKg4wLPTXEa8ItPGzMzEbbt9f8Uo95bxLwQbZmePRy6Xtd8nJdjR/S5JxwYRUom
         hyzKr1q/1eTih6vssHboG+nVr4NmIEuWWtD4PelkG1/sPfE9G8xEXdIenpGDKDpHHrJb
         1wIcIznKYg8NWou3FZxQAvX6A6SSM3kvKyNtmWE+I+eg3jqGsuoCYD3aDVyIyRstlN1X
         Q+HQ==
X-Gm-Message-State: AOJu0YzmS0G/4jTaSORzsC4lYOF02y8amzW3wzF8HVDJDPG7Zh6gRcYd
	ONcOCgmTIFYu5b60ikg/Oeh0ZmqF+0iFcSTrgN3SPCUGEr+yAKYlGInrTW54/03EWwrKkclVsq+
	5mJ87obb7TXKFO2vc7+3NOpwKeLz9scObK9dq5xRXyC73xvvmRkUbCyJvVDYAbtoa4NTpyg3y
X-Received: by 2002:a05:6214:258b:b0:6a0:c8c3:7e2e with SMTP id fq11-20020a056214258b00b006a0c8c37e2emr23877qvb.1.1714406869429;
        Mon, 29 Apr 2024 09:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXfRuFKRK/gtOjj6OQmFL2yAvw5bbHkEAlNYESfqTbsGNJfzd4r85pBbaY7k/GsccRaK2VyQ==
X-Received: by 2002:a05:6214:258b:b0:6a0:c8c3:7e2e with SMTP id fq11-20020a056214258b00b006a0c8c37e2emr23850qvb.1.1714406869025;
        Mon, 29 Apr 2024 09:07:49 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id w2-20020a0cb542000000b00698f01a958asm10659181qvd.77.2024.04.29.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:07:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:07:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Make output work with new dmiinfo format
In-Reply-To: <20240429084720.126511-1-tglozar@redhat.com>
Message-ID: <a0cf5b78-037a-c071-4889-723c164af40f@redhat.com>
References: <20240429084720.126511-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 29 Apr 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Commit 43c45ba7 ("rteval: Implement initial dmidecode support")
> re-introduced DMI information into rteval XML summary, but in a
> different format, which is not correctly picked up in rteval_text.xsl
> for formatting BIOS and vendor information into rteval text output.
> 
> This lead to the information not being displayed correctly:
>    Model:         -
>    BIOS version:  (ver: , rev :, release date: )
> 
> Modify the relevant section of rteval_text.xsl to make it understand the
> new format. Also, adjust the incorrect spacing around "rev".
> 
> New output (in QEMU VM):
>    Model:        QEMU - Standard PC (Q35 + ICH9, 2009)
>    BIOS version: SeaBIOS (ver: 1.16.3-1.fc39, rev: 0.0, release date: 04/01/2014)
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/rteval_text.xsl | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index 1e9c0f0..2f03bda 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -39,18 +39,18 @@
>      <xsl:text>&#10;</xsl:text>
>  
>      <xsl:text>   Model:        </xsl:text>
> -    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/GeneralInfo/Manufacturer|HardwareInfo/GeneralInfo/ProductName"/>
> -    <xsl:text> - </xsl:text><xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/GeneralInfo/ProductName|HardwareInfo/GeneralInfo/ProductName"/>
> +    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='System Information']/Field[@Name='Manufacturer']"/>
> +    <xsl:text> - </xsl:text><xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='System Information']/Field[@Name='Product Name']"/>
>      <xsl:text>&#10;</xsl:text>
>  
>      <xsl:text>   BIOS version: </xsl:text>
> -    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS|HardwareInfo/BIOS"/>
> +    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Vendor']"/>
>      <xsl:text> (ver: </xsl:text>
> -    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@Version|HardwareInfo/BIOS/@Version"/>
> -    <xsl:text>, rev :</xsl:text>
> -    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@BIOSrevision|HardwareInfo/BIOS/@BIOSrevision"/>
> +    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Version']"/>
> +    <xsl:text>, rev: </xsl:text>
> +    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='BIOS Revision']"/>
>      <xsl:text>, release date: </xsl:text>
> -    <xsl:value-of select="SystemInfo/DMIinfo/HardwareInfo/BIOS/@ReleaseDate|HardwareInfo/BIOS/@ReleaseDate"/>
> +    <xsl:value-of select="SystemInfo/DMIinfo/Handle[@name='BIOS Information']/Field[@Name='Release Date']"/>
>      <xsl:text>)</xsl:text>
>      <xsl:text>&#10;&#10;</xsl:text>
>  
> -- 

Thanks
Signed-off-by: John Kacur <jkacur@redhat.com>

