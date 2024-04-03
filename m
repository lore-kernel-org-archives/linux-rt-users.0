Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C97149C42
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156246; cv=none; b=jn1Puw0WV1ppGNlgyKMmCpF7dAbl9IXkInXP8n4bCXSa5leXG3W33XDHfZYkcH1Klhf8ixraTM+1zdZky3GGOuDDXZCyicR20fNNwu6L8w588JMnha6ksSWXgrPhpKsq9fif/NlSZUU8SZDuH4cSTvHO8ibaEZewtLNZuDlI7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156246; c=relaxed/simple;
	bh=SNJwcAVFRd8yMk827BDe0ruuCwuEKd6jHS4mUwWHEQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dlnNBieDPjHib2kTy0bIFfaiJ9FOE772yR6UqV1CY6hYlWzGFHKtUVBf+x0RW/aw8nwASK+WtWwVV+hQIA8CjKoxYDSb/aeT9dwbEijrA38fK4AEBkWCUkOConSI0+wJU6ipekTXwg/LjS8QZLdETYmHVmiGsYC5KmUxpuxQ71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXZf3VCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXZf3VCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712156244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz1AxF7kVTVN2el7994f6xzlckpKxTxGr5Oo+pCQCOo=;
	b=PXZf3VCVlLe5EzFFPWCTpstMWIq+Wlz0xcfVUnJJQ32X4pdnGYD5Qcm86+Ailv5E5PfIMh
	IEnblZEqxswxUp9MctyKdybJMswypjTX2QyAJTbVkNECQDeZX7OI+XC7EatCZSeKqocIAC
	scNOKt13K6cAQZfC41P/NROrgL/WLcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-4JKkLig3ORqou-REsxGpVg-1; Wed, 03 Apr 2024 10:57:22 -0400
X-MC-Unique: 4JKkLig3ORqou-REsxGpVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EFE489666A
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 14:57:22 +0000 (UTC)
Received: from [10.2.16.212] (unknown [10.2.16.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5A22166B31;
	Wed,  3 Apr 2024 14:57:22 +0000 (UTC)
Message-ID: <83e824439dee6fc794851620cdabc374affd8f1a.camel@redhat.com>
Subject: Re: [PATCH 3/5] rteval: kcompile: Skip mrproper, and re-extract if
 clean fails
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Date: Wed, 03 Apr 2024 09:57:17 -0500
In-Reply-To: <0f21e919-9bab-5abf-8844-d4ff8c84b82d@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com>
	 <20240304211655.20174-4-crwood@redhat.com>
	 <0f21e919-9bab-5abf-8844-d4ff8c84b82d@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, 2024-04-02 at 15:07 -0400, John Kacur wrote:
>=20
>=20
> On Mon, 4 Mar 2024, Crystal Wood wrote:
>=20
> > We only ever do out-of-tree builds, so the kernel directory should not
> > be
> > getting damaged except by incomplete extraction (which mrproper would
> > probably not fix) or external meddling.=C2=A0 So, skip the mrproper and
> > instead re-extract if a "make clean" fails.
> >=20
> > Also, add -j to cleancmd to further speed things up.=C2=A0 Startup spee=
d may
> > not seem all that important given how long rteval is typically run for,
> > but this helps make quick tests (e.g. while debugging things, or when
> > hunting a latency that shows up very quickly) less painful.
> >=20
> > On my 12-cpu laptop, this patch saves about 15 seconds of startup time.
> >=20
> > Signed-off-by: Crystal Wood <crwood@redhat.com>

> You would probably achieve close to the same or better by just using '-j'=
=20
> with make mrproper

Perhaps it would be almost as fast, depending on the system you're running
it on (and how many non-isolated cores it has).  But it really doesn't seem
necessary.

As for better, how?  We're going from mrproper *and* clean to just clean.=
=20
The re-extraction only happens if clean fails.


-Crystal

