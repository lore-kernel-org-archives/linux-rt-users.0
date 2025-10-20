Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A51EDA0B
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984305; cv=none; b=mXehqEFlVom7lL2X0KThH3t5d48Z/bYExpmgNPqznGvUtdo/YWhsn5yqwDQO+aCClkSP3XIoVZhP7AAutFM8JDV/JNFXL7k85VMI/ibOUOMlvclP0KVkPkG/sfzzuLS8CorsUvTB3iaVfQs6MY7KeY+hsY3iJOm3BFJoBj680rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984305; c=relaxed/simple;
	bh=grL35G02FGTsUg04Ju8hSq9IX0KIQ629tAFb/EgEeFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6q2yEMoJ694w/jiVMbEenWuRUxDvYH1Dd5zoFgM1k0sJyO4EsiHuV+MNIucE3gHBBFErJarODw45vZ5bZ+5Kosgm/i9mRTQlVLtTK0mxg3j48EJnwZrOVVRPPWytY8tMzJ36YMGVBZFXxsr16EkV1gXURRvyLVeCy2Uo82WT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEL9ROv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEL9ROv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760984302;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=kXJ+X+t9oKtCvI+ksaNY75MQjCoHnlbUFjvVppL3wYc=;
	b=OEL9ROv72tMdJy5IdRntfJZJ/xAa1lHApunhucSX/YBgE1NbQ5DEuL+m6+Ojv/pNUFZT1b
	YMjdCWRnbw5VMtGi7rsvpvxd0QxAzsu++jPtryaH15ZAWIfvix5XkcAZxjhO3Ssbp2FrwA
	P1bK8uJV6luHs+StW+uxK4OFloJovUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481--xJghm6APxWZn2KcE2fQow-1; Mon,
 20 Oct 2025 14:18:20 -0400
X-MC-Unique: -xJghm6APxWZn2KcE2fQow-1
X-Mimecast-MFC-AGG-ID: -xJghm6APxWZn2KcE2fQow_1760984299
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AA501956096;
	Mon, 20 Oct 2025 18:18:19 +0000 (UTC)
Received: from localhost (unknown [10.22.81.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D27430001BC;
	Mon, 20 Oct 2025 18:18:18 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:18:17 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>, linux-rt-users@vger.kernel.org, 
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <hcjrc3jpa6xvgwat3oic6cjndeoaxhqcyg5vs5iit4dqhnqq7g@aho75uuk65ds>
Reply-To: debarbos@redhat.com
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
 <aPJBkImjwb_Ze6dX@lysander>
 <8d049c27440410a0ac0922d5e48da7824af57db8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d049c27440410a0ac0922d5e48da7824af57db8.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Oct 20, 2025 at 11:54:28AM -0500, Crystal Wood wrote:
> On Fri, 2025-10-17 at 08:16 -0500, Clark Williams wrote:
> > On Wed, Oct 08, 2025 at 02:41:11PM -0400, Derek Barbosa wrote:
> > > 
> > > Of course, we could always go the direction of just dropping the functionality
> > > of parsing said "old" sched_debug files. Clark said that this may make some
> > > people upset though :P
> > > 
> > 
> > I agree that's the "easiest" path, but I think we may want to poll the
> > community to see if there's someone running an application on a 3.x or
> > earlier kernel and has a need for stalld. 
> > 
> > We can bump this around a bit and if no one raises their hand, we'll
> > drop the old format.
> 
> s/3.x/pre-4.14/
> 
> But is the task format really the issue here?  This patch is addressing
> issues with BPF and compiler flags.
> 

It would help fix a good amount of flag checks and cruft we carry in
sched_debug :)

> -Crystal
> 

-- 
Derek <debarbos@redhat.com>

