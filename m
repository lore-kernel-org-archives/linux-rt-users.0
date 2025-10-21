Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CBA346793
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063416; cv=none; b=o7L1NN73LJPN4ISScHyIFSTci5kgFAWMwg/MJTGgDyTwRsNBHRvGw6eqx0KgzH3aBig8x2HLSkowedXEUN65JFqxuCGk2AirJv9i1qw8002+K/Ip/wVXRAXMaZSbBl0o5+DUYhH/gby2X8wQtvWSEJ2YabcCK8mYsfhSrJfio1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063416; c=relaxed/simple;
	bh=HM0H/J3vgZWXWQ7Xlk+bI9SUAC9VN2IN4tAxuTLgPu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbfT+Y915F0b7Lc2HqLZPEOA2JukVx+CSPnq3PmMBq57rlZvnzYvRJIw6DjW4XMQaNHJZIB3dOW3408D2RbGdYVnsPF7gmfswjsJrwOIG+c9tOyYN5VNo/i5SjOr6jDrtO4BoD3VAaOOaI6i6amGIwi/Q8GtPyep9fH1bGi3KUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv6sgbEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv6sgbEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761063412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rmn0Saf0/KbWO2NGLIYqERCNHP+oZWwexaECch9jMW4=;
	b=Mv6sgbEk6z45NrZQhcXr5xZu4stEfUWc/e0vRecOG3P0IlSxKYJXUZDzTpGr0qhY82ZmJ9
	29zmpskx1i0lMKMHJfr5rxZZWQ1NXjwuR3jmxEDQrg8VI5wx9W3u8ihpq2kcYlb3QPXhG3
	qLAgujNCssfnSGjU9OqbNS0gyK0tEIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-Od6F5BMTPO2x2kfhmHi6ew-1; Tue,
 21 Oct 2025 12:16:48 -0400
X-MC-Unique: Od6F5BMTPO2x2kfhmHi6ew-1
X-Mimecast-MFC-AGG-ID: Od6F5BMTPO2x2kfhmHi6ew_1761063407
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79A351800657;
	Tue, 21 Oct 2025 16:16:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CD5381956056;
	Tue, 21 Oct 2025 16:16:43 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:16:41 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	debarbos@redhat.com, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 06/12] stalld.c: get rid of misleading print about
 DL-Server
Message-ID: <rfqypwgibmrecnfc5i6vrcwzzf3pe5rfba4glb4jf4gwfleo6f@mgznycr3uv3g>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-6-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-6-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 16, 2025 at 09:24:38PM -0500, Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> Get rid of the assertion that stalld was forced into log-only mode
> 
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/stalld.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/stalld.c b/src/stalld.c
> index 6cd4bf68d04a..6adc3e9a8cea 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -1149,7 +1149,7 @@ int main(int argc, char **argv)
>  		set_cpu_affinity(config_affinity_cpus);
>  
>  	if (!check_dl_server_dir_exists())
> -		log_msg("DL-server detected. Operating in log-only mode.\n");
> +		log_msg("DL-server detected.\n");
>  
>  	/*
>  	 * Check RT throttling:
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

