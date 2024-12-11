Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585E2594A3
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945114; cv=none; b=bZtLEG6D1GMV/pftDgl+z74jqM6nNzJ4M0RLNJfMaZuhoK9B+1wEk1FYTE4NjwsYdcdCSigTUpCU9au5DYIvXP3zgyDGtgijXVaH7hASOZAZ2VCq8hItTLW/wtU5lqHisTO95uO1JXJW4xNYgjVtFfMpQ9cKPgvj43x//QON1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945114; c=relaxed/simple;
	bh=q5r5RZQVNspF38wqD5kv+Ru1c2DcB2DtKYfvQBU9+eo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SpqO2C16FXW48eKMNBfkO63mC1GtuDCnQyZCYHl72YydPDay2b6KJQQL0Pzo8Q2+ghwzN/au1l+TzT21KwslIYV0/r0GFUQ5h7pR5boeiDyX9qbW6a1/Cufa/am65YDe7Gu1bREQx6xrMIbXhxdndz3lx5GZGOg7KlsJDle1NJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSUHmIHD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSUHmIHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733945110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uccH8jdppBGMsuOdg+HwCK+z/bgAAWJehY1Oi3sMaqM=;
	b=dSUHmIHDb6Fglfy43cSuSSe1q71a/LX6qNboyZcQQamW1E1a3Ps9EE75dMcUocrIXnqiO4
	fRk9SIR0rjtUx1El9BfY6RaUmooQlF0nVavA7hvkH9JDAyNQgFIrabp3l39c61BEjcqBnC
	o1TJaocwxrcSvF1Y/KEqj7s15xcXKvU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-SQifD8ixPC6rCCYWI5GUBw-1; Wed, 11 Dec 2024 14:25:09 -0500
X-MC-Unique: SQifD8ixPC6rCCYWI5GUBw-1
X-Mimecast-MFC-AGG-ID: SQifD8ixPC6rCCYWI5GUBw
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6d2ae6bc0so661237885a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 11:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733945109; x=1734549909;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uccH8jdppBGMsuOdg+HwCK+z/bgAAWJehY1Oi3sMaqM=;
        b=lwGuzBnA3qV9UA9/V8tW3FsKfpSOPNUg/gwabI0ZCHdQ6PcwF/niMnv6aJyYON9cVT
         FuZAhlKrCkIld95Rq+pTVZXbYsH6DdtCU+9koSH8yHlSU2gXMxkiRLw/1QjaC6Fz3hAZ
         eIH0BPTqruTrrBU0p76CTIftUcN9OBmslQMDph0QxBwW0zilS3i/WtrcP6P7S2UCsO6K
         ZjwY7LEgQnoe8haX2R/kgGhw77hisWvqHpzyA0yvJ0qfqp0uq9khaj6YpD7Xod87gIhw
         y0Cq4XKc2xKjsr/80KCG4bxA5bLmkyf1Z73bIFlLmnYm4HsMA6GBc5JEVjDlULKakf0u
         oxpw==
X-Gm-Message-State: AOJu0Yw1VFL8gU8jNCDepr7CKSZxl6A1u/Vx+m6Ecs4RsP4WRyE0jP3G
	QdyrtbHM6WgsAPbC2hdFdUlshAwR/X9ScarOa9Nr4y2Cz+ZRgkZTjKqhP5K0WdtxFrdFPnzjxvS
	Wn1y2rVFnOioRX5fqqXTxvhiJPISbUzz8Pld/Wh3r5J+G2cROE4IGzXO6GpvNhTrO
X-Gm-Gg: ASbGnctexf4STt2gv3fwcdtg45YQa/tgENLgpn3lKWlOJ2RGH6veQ1a0Q465O3Acwx9
	lKmQ3A0cGS23/MAS12DyW7OTLbvYWYdN3kilpKhdN8+i5qd4SNSyLvMUmZ/Yp3rOMyJ3yB22UGy
	UQqP01nL1WoC7FGKZQ3ZJK05Y75+yBpUyrFvJQqbFIQQzEfMnIZlREuAH9ZZfXtA3ahmOKPRdha
	5Wla4p9jFvGgTXSR/p6XRtz3yCF5aoa9On7qNcxLOFX
X-Received: by 2002:a05:620a:4454:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7b6f2543fe5mr86388285a.17.1733945109161;
        Wed, 11 Dec 2024 11:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyB3sd1m1Fh1JT/rqSPqib+9lw9rek+OaQkgB+zujvQMhMhxBc2hbe8CjJrKzkMIksrdk9vQ==
X-Received: by 2002:a05:620a:4454:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7b6f2543fe5mr86385685a.17.1733945108852;
        Wed, 11 Dec 2024 11:25:08 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d990baf2sm274733385a.113.2024.12.11.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:25:08 -0800 (PST)
Date: Wed, 11 Dec 2024 14:25:07 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tan En De <ende.tan@starfivetech.com>
cc: linux-rt-users@vger.kernel.org, mtosatti@redhat.com, williams@redhat.com, 
    leyfoon.tan@starfivetech.com, endeneer@gmail.com
Subject: Re: [1/1] rt-tests: determine_maximum_mpps.sh: Introduce '-F' option
 to specify CPU frequency
In-Reply-To: <20241211171158.1344674-1-ende.tan@starfivetech.com>
Message-ID: <dd8872e6-2278-b77b-7b98-2c69fbc7270e@redhat.com>
References: <20241211171158.1344674-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 12 Dec 2024, ende.tan@starfivetech.com wrote:

> From: Tan En De <ende.tan@starfivetech.com>
> 
> For platform that doesn't show cpu MHz in /proc/cpuinfo, introduce '-F'
> option for user to specify the CPU frequency in MHz.
>

Are there other places to get this information, for example
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

 
> This corrects previous commit that mistakenly used timer frequency
> (timebase-frequency) instead of CPU frequency.
> 
> Fixes: fab7d9057887 ("rt-tests: determine_maximum_mpps.sh: Get frequency from timebase-frequency if cpuinfo fails")
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/queuelat/determine_maximum_mpps.8  |  3 +++
>  src/queuelat/determine_maximum_mpps.sh | 17 +++++++++--------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/src/queuelat/determine_maximum_mpps.8 b/src/queuelat/determine_maximum_mpps.8
> index ba2cc2a..bcd3078 100644
> --- a/src/queuelat/determine_maximum_mpps.8
> +++ b/src/queuelat/determine_maximum_mpps.8
> @@ -56,6 +56,9 @@ default priority = 1. Valid numbers are from 1 to 99
>  .TP
>  .B \-h
>  help
> +.TP
> +.B \-F cpu_mhz
> +CPU frequency in MHz. This is required for platform that does not show cpu MHz in /proc/cpuinfo.
>  .LP
>  .SH AUTHOR
>  determine_maximum_mpps was written by
> diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
> index adfd809..6a90ca0 100755
> --- a/src/queuelat/determine_maximum_mpps.sh
> +++ b/src/queuelat/determine_maximum_mpps.sh
> @@ -37,20 +37,20 @@ usage()
>  	echo "-h"
>  	echo "	help"
>  	echo "	print this help message and exit"
> +	echo "-F cpu_mhz"
> +	echo "	CPU frequency in MHz. This is required for platform that does not show cpu MHz in /proc/cpuinfo"
>  	exit
>  }
>  
>  get_cpuinfo_mhz()
>  {
> -	# Try to determine MHz from /proc/cpuinfo
> -	FREQ_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
> -
> -	# Try to determine MHz from /sys/firmware/devicetree/base/cpus/timebase-frequency
> -	if [ -z $FREQ_MHZ ]; then
> -		FREQ_MHZ=$(($((16#$(hexdump -e '1/1 "%02X"' /sys/firmware/devicetree/base/cpus/timebase-frequency)))/1000000))
> +	# If user does not specify -F CPU_MHZ
> +	if [ -z $CPU_MHZ ]; then
> +		# Try to determine MHz from /proc/cpuinfo
> +		CPU_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
>  	fi
>  
> -	echo "$FREQ_MHZ"
> +	echo "$CPU_MHZ"
>  }
>  
>  # Check that the scheduling policy hasn't already been set
> @@ -64,7 +64,7 @@ check_sched()
>  }
>  
>  # Process command line options
> -while getopts ":a:frp:m:n:h" opt; do
> +while getopts ":a:frp:m:n:hF:" opt; do
>  	case ${opt} in
>  		a ) CPULIST="${OPTARG}" ;;
>  		m ) MAXLAT="${OPTARG}" ;;
> @@ -73,6 +73,7 @@ while getopts ":a:frp:m:n:h" opt; do
>  		r ) check_sched; SCHED="-r" ;;
>  		p ) PRIO="${OPTARG}" ;;
>  		h ) usage ;;
> +		F ) CPU_MHZ="${OPTARG}" ;;
>  		* ) echo "no such option"; usage ;;
>  	esac
>  done
> -- 
> 2.34.1
> 
> 
> 

