Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88465158845
	for <linux-rt-users@vger.kernel.org>; Thu,  2 May 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680695; cv=none; b=L7aadeT4OYIP1++X3lljjpimQyNUfgMB2x/ypsEro0XA/iUsfvzkSQ9hneX0VmPnRxJ5K5oZrH/g5Ke3IC7tR9Tuo7nOl0toJpT93eoXRmkJQZC9VQa0h5QjGEW8vgbdwQ2M1SQH0A3HtK41TQkXW784mc0LpuLCmBjP+qyV09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680695; c=relaxed/simple;
	bh=/HWHsqk6OZqXxsMYfb8FX926r9T+cXpUwXfgNSgxArg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUv7kNL9E5q4TrF5r0DWXpnm0RcsOAVjot2Va5qGyLF1eDB+cdRocSloQPyIIGEtqpTwjAyOZeAMO6Y7lvfszRJL7XxPnHhvTcYP2ei6/r0orI+Fn95VKIUXloSd4wFxNRh+qNUKZQbmKJY4LZJhzs8YtZt32DKnTFKXaMnCGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUZbJeAF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUZbJeAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714680692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3bdLVyjptrKtAq5/d2flla6cDs9/BxRZratrcglyw4=;
	b=iUZbJeAFKeHQCAkAbimF/pxjqInGfcyz1Q62MWkT+EgdcvXAtQWaM45PTjTdOqu98GjGdJ
	NHMIHGZI07Q1utQ8bX5EM7NHwBTmagI7nCRLeJjZ9/Z5oJCrngfTW4SWIkhrSryXgEMRee
	1qiBz7RVKeBUHGDwyB7iso1CKpmrQnw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444--uqLnDLlNMuvspGy8wf-FA-1; Thu,
 02 May 2024 16:11:31 -0400
X-MC-Unique: -uqLnDLlNMuvspGy8wf-FA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A4A29AA2C9
	for <linux-rt-users@vger.kernel.org>; Thu,  2 May 2024 20:11:30 +0000 (UTC)
Received: from [10.2.16.177] (unknown [10.2.16.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7342E492BC6;
	Thu,  2 May 2024 20:11:30 +0000 (UTC)
Message-ID: <da44edf2d10659ccfea2b8a646f8431cd3dcd168.camel@redhat.com>
Subject: Re: [PATCH] rt-tests: cyclics: Omit empty histogram buckets
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Date: Thu, 02 May 2024 15:11:30 -0500
In-Reply-To: <974cd5d9-f027-5e51-e6ba-fd50e4759d4b@redhat.com>
References: <20240501204944.228386-1-crwood@redhat.com>
	 <974cd5d9-f027-5e51-e6ba-fd50e4759d4b@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Thu, 2024-05-02 at 15:13 -0400, John Kacur wrote:
>=20
>=20
> On Wed, 1 May 2024, Crystal Wood wrote:
>=20
> > This makes the output more palatable for human readers, at the expense
> > of requiring other consumers of the data to be able to handle the
> > missing
> > lines.
> >=20
> > Signed-off-by: Crystal Wood <crwood@redhat.com>
> > ---
> > Don't apply until the below patch has been merged in rteval:
> > https://lore.kernel.org/linux-rt-users/20240501200922.226347-1-crwood@r=
edhat.com/
> > ---
> > =C2=A0src/cyclictest/cyclictest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
> > =C2=A0src/include/histogram.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0src/lib/histogram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++---
> > =C2=A0src/sched_deadline/cyclicdeadline.c |=C2=A0 7 +++----
> > =C2=A04 files changed, 20 insertions(+), 12 deletions(-)
> >=20
> > =20
> Fixed title to say: rt-tests: cyclictest: Omit empty histogram buckets
> Signed-off-by: John Kacur <jkacur@redhat.com>
>=20

How is that a fix?  I said "cyclics" because it's both cyclictest and
cyclicdeadline.

-Crystal

