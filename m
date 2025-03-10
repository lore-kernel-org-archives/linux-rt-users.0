Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6E22257E
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Mar 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607963; cv=none; b=oaFwz+BpQ+PtHjgps5uj7buRngM8MfJkfy79cstTvikCHJRBzXFwQJmNqRmQ6CofJG+2I4rrucO5P52Q39nYlJ4UDxbmO/rKWPcp/LQ0F3yUmf9gwLRZpwrE2BHDdkDAiYpqo/GMnejn4qZVhrmI2KV6/l0KXg2pToxA7AI7sCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607963; c=relaxed/simple;
	bh=f6ntYTkDpD8qBRUZqGvw3lOb4FYYeZlruRHEvOrILcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIxZXNtsygrGbINZnYBxrZN+570E/jUEsA3I70E8udjh5CkWiM2C/idkKB7bcUFfPRt4cSH5RZU3t/XKJ7bqoqzNg0Mf9PKUKRsgbR1wCAC8L6GOyPnMMM6cxq6/JWI7Fq3aZ4wvgvTE03K+miwCku6+q6MxyKbfGgHK43FraQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3WNF+Yf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3WNF+Yf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741607960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3rAY921NpQxwzc4meg/T7UySYRye9nPrv2GKBjYHuo=;
	b=R3WNF+Yf4KLweJCptxh3Map7OTSMc4QLqJDbPTzCAS/UHkYYTpkm+bifooGIn/3RHDX7du
	ocqeFyjIXnBbG8G3uxmlIR6FJIlLe4iOksOrO2OOAKi1FLGjDMnrKNNtCtLkX6RnrrGNwp
	jZR0vgndwTnJlvj7yCcm1ol2Baw5L6Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-WDbPTB8WMsqiEcjo6gLY_g-1; Mon,
 10 Mar 2025 07:59:17 -0400
X-MC-Unique: WDbPTB8WMsqiEcjo6gLY_g-1
X-Mimecast-MFC-AGG-ID: WDbPTB8WMsqiEcjo6gLY_g_1741607956
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E42B819560BB;
	Mon, 10 Mar 2025 11:59:15 +0000 (UTC)
Received: from localhost (unknown [10.22.88.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4548B1800945;
	Mon, 10 Mar 2025 11:59:15 +0000 (UTC)
Date: Mon, 10 Mar 2025 08:59:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: 6.12: i915 not allowed in combination with RT
Message-ID: <Z87TiLETDC8LlG5S@uudg.org>
References: <a3444741784adda2b9ff462ca5d92d343ef700ba.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3444741784adda2b9ff462ca5d92d343ef700ba.camel@siemens.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 10, 2025 at 12:31:21PM +0100, Florian Bezdeka wrote:
> Hi all,
> 
> the following commit (taken from 6.6-rt branch) resides in all stable-
> rt branches but is not part of mainline 6.12 and above, which makes it
> impossible to use i915 in combination with PREEMPT_RT enabled.
> 
> Is that by intention? Are there any known issues that makes it
> necessary to disable i915 in combination with RT in current releases?

There is a set of changes that were not merged along with the PREEMPT_RT
bits that are required to have i915 behaving properly (or as well as
possible) wrt PREEMPT_RT. While those changes are not carried by the driver
(i915) itself, they are available here:

* git tree:
    https://web.git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches?h=linux-6.12.y-rt-patches&id=b7402ed929a05397b5c02802bdfaae40df4f2fc8

* patches:
    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/

Best regards,
Luis

> Best regards,
> Florian
> 
> commit f532acfe5c63d53756c86e3d3fb1a51b02d29762
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Mon Feb 21 17:59:14 2022 +0100
> 
>     Revert "drm/i915: Depend on !PREEMPT_RT."
>     
>     Once the known issues are addressed, it should be safe to enable the
>     driver.
>     
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 3efce05d7b57..392d51703096 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -3,7 +3,6 @@ config DRM_I915
> 	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
> 	depends on DRM
> 	depends on X86 && PCI
> -	depends on !PREEMPT_RT
> 	select INTEL_GTT if X86
> 	select INTERVAL_TREE
> 	# we need shmfs for the swappable backing store, and in particular
> 
---end quoted text---

