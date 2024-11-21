Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263515B13B
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Nov 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214960; cv=none; b=qGTuxbUPCulQ8ZKWLwM6uuszBv6vXAVLl0uhPKpS36hG29C3KYgVqHoC5QqFth74akHDCl5wfNtoH5iIzN+dZcg/gE9E35EevLw3cyMc2A3KEMi1nuWLODEBIKLlQfGjD6QFrfl0l35ro21HuWmczcbScEskIdW9uo0sZ4WEghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214960; c=relaxed/simple;
	bh=mkClHzIvVInIKbLTiCEse3o9w9LtpMbT9OIPWOcKzpA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eLhTA8a+5w+zZCGgFA1rYqctnJzuHfTeHugj6D2X/rP1h3zUhtbIoJqlMnEx5KNwWWPAGFTuJf/BSvoKV7V6Yh8YdSfUdsU9RPT/mFglhSB6g1aLjHaNENRC81sahKvDE5/zlp2M4robgGXr0snG7mhfpcaaeI6DPrms8DQv28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOW2WRed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOW2WRed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732214957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIqhp/hniPgDjhr82za5XUitLe3uQKcxyPo5QnVuBjw=;
	b=iOW2WRed/9XY/b6Xylgwj2lNtbwGN+8gUaD+PUygMLk1F3waLdEZsUURe0CMYbv/T0/nUD
	s0s4yJUo4M+ik2fvuVtdbXo+1SR3DpEQGq2BeqJ+4htRUkc3CexQ4Fn3Xfnlg0g/YwtJ2X
	BOZ8O011cs6Xndk1rgDgIwP3hncRLLY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-kDNmIrLtP-y9rYYiue_7iA-1; Thu, 21 Nov 2024 13:49:16 -0500
X-MC-Unique: kDNmIrLtP-y9rYYiue_7iA-1
X-Mimecast-MFC-AGG-ID: kDNmIrLtP-y9rYYiue_7iA
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6ee7856bcf2so21086297b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Nov 2024 10:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214956; x=1732819756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIqhp/hniPgDjhr82za5XUitLe3uQKcxyPo5QnVuBjw=;
        b=fH9x6q1h3PHS4kFden/oeMaYEA3uT+aviAX6DQEpokmRfjZlO4VUFFnLpNzDrlQlKh
         JCNhrxVf6u4LT8iycDCxeVO6X3DwSsM0vd/07HGJFmHLoAv9QK9iC+KZNfnymoGH9htB
         aJCmil9LIv0L9R3bYeEsIInaTAAFgCHMA/zt9SebOo+z+swMznyGOwHmcM/Wf4EkppRO
         HEwWK22ew+1ZinomxN/aa+BncXRWRcEI13ZrKb+ywqcs4NbM6XEURRKfvcDULgd24ivL
         5uPtXIEkYtZy2E1OgBkoxp/sDC2Z9K+rkCuYjiOhS7jdlr9m3XDoeS7EjaI/V9L9c/bT
         vrAA==
X-Gm-Message-State: AOJu0Yw9c6MYbfVK8eg5kzL3JXZ1EbQ/1pfAkVtAJJMwVdq8P7jc1J6T
	cCDnCi1buHHasGKgFh1RZC02W/eFqbrQa4eVcK1BpFtgvGjttKD9Ivz7WkBg+IfBQZidGHGdAsU
	u+BQSCx1mtC18u/2o+dXe39fTfokaovPYvzxYF9zD1DWNZCsszI8H4Z7zl32lIkex
X-Gm-Gg: ASbGncvCEVlAh/FZihJbaEGSHkey8NkxYLhh6TFGG3v8JrLxt7oSXmq3DOpJB77M+rq
	tw3YksGTbK7M7b2+lc9lsBeshfpVoC6O532HfUzGMW5S1eTB8K9fSDCzQKpJPxww2lS0A98U2LH
	yGNW7sEcSJNcjMGQg5ZfmmyIEVLrodYBW4TYGC4wJo/f/PpmAjrfAjY2nKQql9uInm3fw0cvIPD
	V/W/Gv/EI9YJAXwweolRrq758mDAR/tYFkJqnrc
X-Received: by 2002:a05:690c:7084:b0:6ee:3f37:919c with SMTP id 00721157ae682-6eee08d3f6dmr3638927b3.14.1732214955823;
        Thu, 21 Nov 2024 10:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0fdRxPIqWSVZEev8iuulAiKasPLYvsxRDvZ/MeYERu7crH69dPS9Ly2mUtI4rOYHeWu0nmg==
X-Received: by 2002:a05:690c:7084:b0:6ee:3f37:919c with SMTP id 00721157ae682-6eee08d3f6dmr3638737b3.14.1732214955593;
        Thu, 21 Nov 2024 10:49:15 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a831edsm544546d6.10.2024.11.21.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:49:14 -0800 (PST)
Date: Thu, 21 Nov 2024 13:49:13 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tan En De <ende.tan@starfivetech.com>
cc: linux-rt-users@vger.kernel.org, mtosatti@redhat.com, williams@redhat.com, 
    leyfoon.tan@starfivetech.com
Subject: Re: [1/1] rt-tests: determine_maximum_mpps.sh: Get frequency from
 timebase-frequency if cpuinfo fails
In-Reply-To: <20241111014953.11604-1-ende.tan@starfivetech.com>
Message-ID: <ef7eb9ef-4c54-0422-ec3b-e09e43f0e02f@redhat.com>
References: <20241111014953.11604-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 11 Nov 2024, ende.tan@starfivetech.com wrote:

> From: Tan En De <ende.tan@starfivetech.com>
> 
> If cpu MHz is not listed in /proc/cpuinfo (as in RISC-V Linux), get the
> frequency from /sys/firmware/devicetree/base/cpus/timebase-frequency.
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/queuelat/determine_maximum_mpps.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
> index 733b6b2..adfd809 100755
> --- a/src/queuelat/determine_maximum_mpps.sh
> +++ b/src/queuelat/determine_maximum_mpps.sh
> @@ -42,7 +42,15 @@ usage()
>  
>  get_cpuinfo_mhz()
>  {
> -	grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1
> +	# Try to determine MHz from /proc/cpuinfo
> +	FREQ_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
> +
> +	# Try to determine MHz from /sys/firmware/devicetree/base/cpus/timebase-frequency
> +	if [ -z $FREQ_MHZ ]; then
> +		FREQ_MHZ=$(($((16#$(hexdump -e '1/1 "%02X"' /sys/firmware/devicetree/base/cpus/timebase-frequency)))/1000000))
> +	fi
> +
> +	echo "$FREQ_MHZ"
>  }
>  
>  # Check that the scheduling policy hasn't already been set
> -- 
> 2.34.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

