Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZu6C6RW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215DEF7
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702484320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnYakNvJrqtKCb9Zhu6ZaQ/GIVEKx0hgxDrkpijR9yg=;
	b=bZu6C6RWFAHOHP4+4k3wU6xVNHsMePo1f3D5D2sfsILqsIUlV7YHlAkIZf4c5fU57CieuK
	XMoqON6eRFv8nT/WYnr0IoiAsoorZnmJizlJr0E1Stb/jjqwDzw6ePpZNhfpVLETWDsGBX
	Fe8DPvxwZ7nvPU0GrQWVDEVPqZR8Q/U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-2Sx3Z9dBMw25DceD9Qr2BQ-1; Wed,
 13 Dec 2023 11:18:38 -0500
X-MC-Unique: 2Sx3Z9dBMw25DceD9Qr2BQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6B503811F38
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 16:18:37 +0000 (UTC)
Received: from [10.2.16.196] (unknown [10.2.16.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94645492BE6;
	Wed, 13 Dec 2023 16:18:37 +0000 (UTC)
Message-ID: <f98e018476a20d75edfc9e87228ca7aba9a637a7.camel@redhat.com>
Subject: Re: [PATCH 2/4] rt-tests: cyclictest: Remove histogram totals
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Date: Wed, 13 Dec 2023 10:18:37 -0600
In-Reply-To: <20231206205508.17148-3-crwood@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com>
	 <20231206205508.17148-3-crwood@redhat.com>
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

On Wed, 2023-12-06 at 14:55 -0600, Crystal Wood wrote:
> The Total: line does not seem to contribute much value, as it should just
> be the number of buckets minus the number of overflows.=C2=A0 Unless some=
one
> complains, remove it to simplify moving to common histogram code.

Eh, that should be "number of cycles", not "number of buckets". :-P

-Crystal

