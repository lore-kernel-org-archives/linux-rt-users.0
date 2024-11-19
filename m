Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6D1D0B9E
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Nov 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046078; cv=none; b=GJ1eVx1lTxcaC35JiOz90LQoibI/Kq55jFkd6CpF+hmYdNxpnAnd6JtDPla4K8Mlw2fC69vCKLvj9GO5iZd0vvRUOzQDpZ6KEYwfag3CCLivGikzHM9OTJdhZBy2hPTyIYivazBL4drOTQ7M59Sv+jWWOFzAqfvjWmw1eU1STkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046078; c=relaxed/simple;
	bh=R5gP1IEO3v9CBdI4OD768GnHs+Ecgs32Nv/Js9B9/WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL0AQ8ggXRBMW+ABHQf4R6E6EILNaArF2ZsMC43uchtPMqcy3Y7iEGV7obcwe3dXV7+DPMUY7Iqgsnv6AszTQhNbIHx+dIC1mqpHysiziP9mt2kYGf4HjWGIjHdy2XPuq3LdqXs4oorda5GUoLNBC+Jl6PqAJn2aemw8nKfZjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSEhSD0D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSEhSD0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732046075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDRUuZgRgtQvzigIdmidmAlB6dF8Obbk4wz5OjkVU6w=;
	b=jSEhSD0D/S+lpgOC5+W6BhqkUa4IvGHcFlbpvtwWmsWjmzElHpfuEKU1GPmbVIifwkJroY
	8dCzAuHDzfgTe098Bfh9EB7qf1Uj4qjpZcIWz0NWD5fU+d3y5tLVELYE0rEikgqPDzpeNY
	+hvn9DSTJDWiPX1hUvoadVKP5xq+vKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-rCWToVlFP9Cw3g3biEBkAw-1; Tue,
 19 Nov 2024 14:54:32 -0500
X-MC-Unique: rCWToVlFP9Cw3g3biEBkAw-1
X-Mimecast-MFC-AGG-ID: rCWToVlFP9Cw3g3biEBkAw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF0091955E9F;
	Tue, 19 Nov 2024 19:54:30 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DE9A1956054;
	Tue, 19 Nov 2024 19:54:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 7B02A409D89BF; Tue, 19 Nov 2024 16:49:30 -0300 (-03)
Date: Tue, 19 Nov 2024 16:49:30 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: ende.tan@starfivetech.com
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com, jkacur@redhat.com,
	leyfoon.tan@starfivetech.com
Subject: Re: [1/1] rt-tests: determine_maximum_mpps.sh: Get frequency from
 timebase-frequency if cpuinfo fails
Message-ID: <Zzzrykji7Cvs2mg9@tpad>
References: <20241111014953.11604-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111014953.11604-1-ende.tan@starfivetech.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Nov 11, 2024 at 09:49:53AM +0800, ende.tan@starfivetech.com wrote:
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

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

