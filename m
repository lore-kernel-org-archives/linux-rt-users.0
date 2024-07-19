Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B1474AD
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413502; cv=none; b=WBtVmA4NBYRK82bZB3OeRlCgJpYZo/Ma07+ohXs4yRdTJNQv8hF2cSuQe72ddUDSz03yX5bo+ksdZWqpoPxDTh05Rn7lqBn5+Cypdv6bI1pk53WBfNxcfCBhii6i3/CuJBtlQXQgP490nR905mK0yFwGFs9RgsqKkbVjP8MjmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413502; c=relaxed/simple;
	bh=8w9MwjwQ0Lik9YBeNRIRptOhSAivvAR3HG/3RixazOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zd+BrHqFsB0kunaIZVTtx3Jiri+vnBrD84Lau8CubKfB3TuhU0ewaqvkC1nTKfe7gB8vcZgTA3C/ISZafRld8qgoW24lM50M5/coO4THFk5Zos6EG5J5pjfHPQzeLW08qfV+NPxpfScMWvQwmyJNZA6vNAVuiU1XsCcBoOPP/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzJCmmQ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzJCmmQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721413499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8w9MwjwQ0Lik9YBeNRIRptOhSAivvAR3HG/3RixazOs=;
	b=KzJCmmQ4RXNu7Y/wsKRNdzg/uJj8VvZD7jR1rtcrzmaIvYB3KaejDcXuu0sn+qRKhKzVQx
	MPkqm4t2uWt7Z586ujX8ORJy+N9r/rIhD7q6KiJ4fkvJIruu0FfQFh84CC+uKNPP2vO6QK
	9ypYdsb4OucjpFa5BrVYsT9xHCch9TY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-bqKAI9ytOJa-1E9YDNWh2A-1; Fri,
 19 Jul 2024 14:24:57 -0400
X-MC-Unique: bqKAI9ytOJa-1E9YDNWh2A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE8EB1955D55
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 18:24:56 +0000 (UTC)
Received: from [10.2.16.233] (unknown [10.2.16.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 962201955F40;
	Fri, 19 Jul 2024 18:24:55 +0000 (UTC)
Message-ID: <ea4b1b3d7e0d71f6a38a460955696660de2b175b.camel@redhat.com>
Subject: Re: [PATCH v2] rteval: Add --noload option
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Date: Fri, 19 Jul 2024 13:24:54 -0500
In-Reply-To: <521af844-9710-a58b-56e1-d68d955c21fc@redhat.com>
References: <20240708194822.221496-1-crwood@redhat.com>
	 <521af844-9710-a58b-56e1-d68d955c21fc@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, 2024-07-18 at 16:23 -0400, John Kacur wrote:
>=20
>=20
> On Mon, 8 Jul 2024, Crystal Wood wrote:
>=20
> > This option allows measurement to be done without any loads.
> >=20
> > Signed-off-by: Crystal Wood <crwood@redhat.com>
> > ---
> > v2: I forgot to update the man page
> >=20
> > This patch is on top of the "rteval: Remove measurement profiles and
> > make latency mods exclusive" patchset I previously sent.
> >=20
> > =C2=A0doc/rteval.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0rteval-cmd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++++
> > =C2=A0rteval/__init__.py=C2=A0=C2=A0=C2=A0=C2=A0 | 54 +++++++++++++++++=
+++++--------------------
> > =C2=A0rteval/rtevalReport.py |=C2=A0 3 ++-
> > =C2=A04 files changed, 42 insertions(+), 27 deletions(-)
> >=20
>=20
> When I run with loads, I the report says something like,
> =C2=A0"Loads:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 loads run on co=
res 0-11"
>=20
> When I run with your --noload option, it says:
> "Loads:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loads run on core=
s"
>=20
> It should probably say, 0 loads, run on 0 cores

Which means now I get to learn how to actually do stuff in xml rather than
just changing pathnames and such :-P

-Crystal

