Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4734A789
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064436; cv=none; b=RNK/LM6cYa6ySODwqsU9mNwfItfHV2siwOttcHnSaiitrAiLs8bsDSMD3xQaVBGrxdNac8UWbxd+Vi5zqPmqEinsXC0MXVD508wk8bJ/+h+IoBjLWgq8g9t3wpx5ZZ8mI1GIaPm20X4lEJNzPvzLqqyhlVbQqwMYXB1OPgP4+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064436; c=relaxed/simple;
	bh=Kn5N3/W+7sPHn5aJWBGKNADcWsHSSmX1dT88eUS8FVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFbIcl2nqFw0lq0ff6jTH8oDOvO6MWrcfkZ3ILfJ6lUK/N0scz8FGomXKlAYPw/26NMB4rmJolERjIxIhyyzIXKAk7cUDipuTbXog1VXqI4BBcqWbJI0ECoZ0jKKx+6k2fTDVA7N7zg/sQKTdJTQjJnnzBMI/mDtZSpf+QsyISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV9410+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV9410+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761064433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LaJ3yf2DN9SiSQ0IqR7+Hoamcn53+rasZx8id1bQE4=;
	b=KV9410+P5B7umirk/cO0GG6uH43byYCePuuUNOaXl7zZOA3tQSEFUF7XhLkny6Qj1pCDkp
	BPKiM24o0o8V5xPX9xda0dZ7q+EWl1iAZaBUqUAFxtPCdawnae2s+OZEYwPTnGK4cepIS7
	uU9DYKekNsd10w/TLx59bdSRgzLNl1Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-PWWbETyaP8ucsfl_U0QpaA-1; Tue,
 21 Oct 2025 12:33:48 -0400
X-MC-Unique: PWWbETyaP8ucsfl_U0QpaA-1
X-Mimecast-MFC-AGG-ID: PWWbETyaP8ucsfl_U0QpaA_1761064427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A49D1956059;
	Tue, 21 Oct 2025 16:33:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5A8721955F22;
	Tue, 21 Oct 2025 16:33:42 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:33:40 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	Claude <noreply@anthropic.com>, debarbos@redhat.com, marco.chiappero@suse.com, 
	chris.friesen@windriver.com, luochunsheng@ustc.edu
Subject: Re: [PATCH 08/12] stalld: Add -N/--no_idle_detect flag to disable
 idle detection
Message-ID: <akknqsqj7xhctb3tecrvbe6m3debu2hjxyez4dn3dktem5adnk@ggxn4b4qqi7t>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-8-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-8-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 16, 2025 at 09:24:40PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> Idle detection is an optimization that skips parsing CPUs that have
> increasing idle time. However, this causes issues in controlled test
> environments where the starvation generator may not prevent CPUs from
> appearing idle.
> 
> The new flag allows disabling this optimization for:
> - Testing scenarios where CPUs need to be monitored regardless of idle state
> - Debugging starvation detection issues
> - Ensuring all CPUs are always checked
> 
> Usage: stalld -N or --no_idle_detect
> 
> Implementation:
> - Added -N option to getopt_long short options
> - Added no_idle_detect to long_options array
> - Sets config_idle_detection = 0 when specified
> - Added help text: "disable idle CPU detection optimization (for testing)"
> 
> The config_idle_detection variable already exists and is checked
> throughout the code, so no other changes are needed.
> 
> ???? Generated with [Claude Code](https://claude.com/claude-code)
> 
> Co-Authored-By: Claude <noreply@anthropic.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/utils.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/utils.c b/src/utils.c
> index 91c99c0a1270..8f1fe9266db9 100644
> --- a/src/utils.c
> +++ b/src/utils.c
> @@ -767,6 +767,7 @@ static void print_usage(void)
>  		"                               starving_threshold time, dispatch a specialized thread to monitor",
>  		"                               it.",
>  		"	   -O/--power_mode: works as a single threaded tool. Saves CPU, but loses precision.",
> +		"	   -N/--no_idle_detect: disable idle CPU detection optimization (for testing)",
>  		"	   -g/--granularity: set the granularity at which stalld checks for starving threads",
>  		"	   -R/--reservation: percentage of CPU time reserved to stalld using SCHED_DEADLINE.",
>  		"	   -a/--affinity: limit stalld's affinity",
> @@ -996,6 +997,7 @@ int parse_args(int argc, char **argv)
>  			{"aggressive_mode",	no_argument,	   0, 'A'},
>  			{"power_mode",		no_argument,	   0, 'O'},
>  			{"adaptive_mode",	no_argument,	   0, 'M'},
> +			{"no_idle_detect",	no_argument,	   0, 'N'},
>  			{"help",		no_argument,	   0, 'h'},
>  			{"boost_period",	required_argument, 0, 'p'},
>  			{"boost_runtime",	required_argument, 0, 'r'},
> @@ -1017,7 +1019,7 @@ int parse_args(int argc, char **argv)
>  		/* getopt_long stores the option index here. */
>  		int option_index = 0;
>  
> -		c = getopt_long(argc, argv, "lvkfAOMhsp:r:d:t:c:FVSg:i:I:R:b:a:",
> +		c = getopt_long(argc, argv, "lvkfAOMNhsp:r:d:t:c:FVSg:i:I:R:b:a:",
>  				 long_options, &option_index);
>  
>  		/* Detect the end of the options. */
> @@ -1138,6 +1140,10 @@ int parse_args(int argc, char **argv)
>  			config_single_threaded = 0;
>  			config_aggressive = 0;
>  			break;
> +		case 'N':
> +			config_idle_detection = 0;
> +			log_msg("idle detection disabled\n");
> +			break;
>  		case 'R':
>  			config_reservation = get_long_from_str(optarg);
>  			if (config_reservation < 10 || config_reservation > 90)
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

