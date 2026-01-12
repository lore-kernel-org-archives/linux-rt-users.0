Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC93261B8D;
	Mon, 12 Jan 2026 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245485; cv=none; b=csgAVYZg0bfEHi7tvcqsSG7VkdnS2czQ9McAjx/nbfEI4QDFeq2mhtgP1TUtL7PJXnfmnNpXXwJEeD56mDA7ZV/eE6zJpNZNBYE+HSxaI2NIK4QldAek7gar28reSaWoLKJ/1vDfFjtTWdIIzyqv+c61bDvX7N+pRaepWjIF5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245485; c=relaxed/simple;
	bh=szPNtxIENXi3HfnoaYoY1gU+I5eTB+PubSA9enfgAQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBnlCi9CKXzuekle6P670fBnhdtGlcvhELjAlUJQmVTroeF8tftnZtJw+x8AE6PO4ihziEs/l0g+Dl4yXpwvR6BdPZXsA8pxse5yqqCo+MHhqLGG0tJbOML3tZOgZ0PYH6uqy40qDf2AXkwkJ80hX1QU601asY8v7WdSvuJtvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcjHft2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcjHft2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FEBC116D0;
	Mon, 12 Jan 2026 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768245485;
	bh=szPNtxIENXi3HfnoaYoY1gU+I5eTB+PubSA9enfgAQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gcjHft2T6tO8OJkzs8F+KvOr6a5rCBcj5reKovk1q+rCk9yj/Je8MfMi/vlqVH24V
	 A/q4/Rs7Tl8ljoThZsF8JEwpK3vkzxg8MBkqDp7Z2PPGIGJPyLxovUU10NJlC+cDfL
	 vtbKMtlO3js++jK1LVnv2lwhg8Kx+Gd5zpKqiCcdh/hj9L296p5IruSxLvRUlXrI2Q
	 Ypt+abOUOnOXNZiQ7dcY9X7pGTSSGRENKZ5vLo/NfMumGJgtIleQX854erDk4gRdoE
	 EiiJTnR7cSEQ7d2pgNsqscoS0GY2lscOYMx3E4bNHqsv8mG7n4O/qT5s55YjWVlB4F
	 BNBTL7wibF5Qg==
Message-ID: <75d6218e50af3be8963b4a3a505dc6df086c0a98.camel@kernel.org>
Subject: Re: [ANNOUNCE] 5.4.302-rt104 (EOL)
From: Tom Zanussi <zanussi@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>
Date: Mon, 12 Jan 2026 13:18:03 -0600
In-Reply-To: <20260112155255.hF_ym_Eh@linutronix.de>
References: <6c6f82df4569575b1da86c29504c5840d2c63ec5.camel@kernel.org>
	 <20260112155255.hF_ym_Eh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-12 at 16:52 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-12-19 16:41:50 [-0600], Tom Zanussi wrote:
> > Hello RT Folks!
> >=20
> > I'm pleased to announce the 5.4.302-rt104 stable release.
> >=20
> > This release is just an update to the new stable 5.4.302
> > version and no RT specific changes have been made.
> >=20
> > NOTE: This is the final 5.4 stable-rt kernel. Because the upstream
> > 5.4
> > stable kernel has reached end-of-life, so now has the 5.4 stable-rt
> > kernel, as expected.
>=20
> I updated the wiki. Thank you for work.
>=20
> Sebastian

Thanks, Sebastian!

Tom

