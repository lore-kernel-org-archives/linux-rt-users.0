Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC671456
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Dec 2023 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ru/tr8bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702930520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEveEsE7CpNLNztkyksFaxWMBmH2vDgIzS5CyRvoB9Q=;
	b=Ru/tr8bxT7wx//4Zy/mUwEK5EiB9ZDKZrvXN3IJiIQRWt+aO308t8MgMXGHIHdKekgcCuk
	URepQ91oY2HiZwqUEWUMU9yNVzLUW9h2oL4/Ie60JI1K7wnbDNb33A58XcXMcnZhf3sile
	TNMdLV6NYvmLVKsry5YK0NIRlBsjyyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-rr7VorTBOG-YKbjPRFoFIg-1; Mon, 18 Dec 2023 15:15:19 -0500
X-MC-Unique: rr7VorTBOG-YKbjPRFoFIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3B2084A294
	for <linux-rt-users@vger.kernel.org>; Mon, 18 Dec 2023 20:15:18 +0000 (UTC)
Received: from [10.2.16.229] (unknown [10.2.16.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80B77492BF0;
	Mon, 18 Dec 2023 20:15:18 +0000 (UTC)
Message-ID: <767629d0eec7fa2203d4e6502da9a0d52ae993a2.camel@redhat.com>
Subject: Re: [PATCH 1/4] rt-tests: Fix warnings
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Date: Mon, 18 Dec 2023 14:15:18 -0600
In-Reply-To: <0b4a2f01-2978-9409-7f2b-fa8ed9c18a9e@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com>
	 <20231206205508.17148-2-crwood@redhat.com>
	 <0b4a2f01-2978-9409-7f2b-fa8ed9c18a9e@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Thu, 2023-12-14 at 10:48 -0500, John Kacur wrote:
>=20
> I tested this with rteval, and it works fine
> checkpatch in the linux kernel flags a few minor things.
> Would you mind fixing those up before I apply the patch?
>=20
> WARNING: Improper SPDX comment style for 'src/include/histogram.h', pleas=
e
> use '/*' instead
> #227: FILE: src/include/histogram.h:1:
> +// SPDX-License-Identifier: GPL-2.0-or-later
>=20
> (Yes, I know there are other files in rt-tests that also aren't using
> the recommended commenting style, you probably copied from there.)

This confused me for quite a bit, until I saw in
Documentation/process/license-rules.rst that *sources* get // but *headers*
get /*.  The rationale seems to be based on the behavior of old toolchains
when processing assembly code, linker scripts, etc.  Doesn't seem terribly
relevant to non-kernel projects...

I can still "fix" it if you want.


>=20
> ERROR: trailing whitespace
> #338: FILE: src/lib/histogram.c:64:
> +^I^I$

One of these days I need to teach the joe editor not to do this...

-Crystal

