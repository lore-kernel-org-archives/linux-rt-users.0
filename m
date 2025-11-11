Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FC36CDF7
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878574; cv=none; b=nJ32Je5FdG9q6IoobIxhWKWLZeQz7Tus4gP0qq+Isg1jlFjVaerhxDEtm+E2ogoA7pkWmKJPRW856Hix9wp00S9NSssxazUTBf9COlwepcuQfZ7/ckhtjlkGUEnFDHaOCgXE9cZSdml2bxWPIlh5AQmQfg6ujGL8eJh9AfMZP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878574; c=relaxed/simple;
	bh=a91/CUDwRER9w0rtk9QzKfIijDlAVxTl6fNiouoqa88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaaJsrGkAVRQi9ueztCeMFxF6Y0tVNCbIkZYJMDMXKYaW09E6dITyLuCXd56AWVQbUfe6+yeUDeSnwfl705+V4r+9HlG0HowbUmXAqwz9dN+x/thsOHm7d2EBOwCJd/MvPR1lt0aquDAJlHut1lnLu7dDm61cM2SYod7eAhTrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVMAjlYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVMAjlYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762878571;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=FK7mhgLR9i6vRUG4vpCbi040lpuKceFGc64EeFiR3Tg=;
	b=eVMAjlYGB+/hmPYKAEvDIwpsvNUNo5kylOXkovt1NEpA6YiMzxpeEnDq/Xrs90xEJz3xcK
	bobMLowYOcCoCebmViSGKH/DYDE4EAyh1iZZTGidzR+jEScbbsRi5ngAO98z4CS0Qw7imt
	j3TpCBR3Lz/MK/AgWILXxABj7rSbyx8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-3KKGs_ddMNKJY18r8O-L0A-1; Tue,
 11 Nov 2025 11:29:28 -0500
X-MC-Unique: 3KKGs_ddMNKJY18r8O-L0A-1
X-Mimecast-MFC-AGG-ID: 3KKGs_ddMNKJY18r8O-L0A_1762878566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD786180034A;
	Tue, 11 Nov 2025 16:29:19 +0000 (UTC)
Received: from localhost (unknown [10.22.80.141])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B42151956046;
	Tue, 11 Nov 2025 16:29:18 +0000 (UTC)
Date: Tue, 11 Nov 2025 11:29:17 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Wander Lairson Costa <wander@redhat.com>, williams@redhat.com, 
	linux-rt-users@vger.kernel.org, crwood@redhat.com
Subject: Re: [PATCH 0/3] Improve Makefile robustness and explicitness
Message-ID: <lufi4xb6bbpllszjdfsasor3ehkn3lyynpnmtogegm2l65eop2@4j64xkvwlw4g>
Reply-To: debarbos@redhat.com
References: <20251107161729.320087-1-wander@redhat.com>
 <20251111145020.C7DI111V@linutronix.de>
 <dgm5dmxmq56rtcorzcapb6ibzlch73xwqfavwtbzrbpi6ukfgv@h32wjmfahkfm>
 <20251111155032.r8XNNyFU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111155032.r8XNNyFU@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Nov 11, 2025 at 04:50:32PM +0100, Sebastian Andrzej Siewior wrote:
> If the package maintainer decides to add a certain flag, such as
> -fcf-protection, despite not working on all architectures then he can
> keep the pieces.

Tagging Crystal as she has weighed in on this topic in previous threads.

> In my opinion the package should not fiddle with what the upper layer
> (build system) specified/ requested. It may have a default set of flags
> (such as -O2 -g) which will be overwritten once the user supplied
> something.

Agreed. We've already stripped out a lot of the RHEL-styled options of the
makefile with this logic.

Wander & Clark, any thoughts?

> The default set should not be something that is not required
> and is not always provided by the compiler specified as minimum.

With this tidbit in mind, what else do you propose we strip out and leave to the
packagers? Is it worth retaining some of the debug & hardening flags, and
leaving the rest to them?

Cheers,

> 
> Sebastian
> 

-- 
Derek <debarbos@redhat.com>

