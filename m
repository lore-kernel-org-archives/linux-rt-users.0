Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A015B57B
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720404; cv=none; b=jcfp8af5gYur6XWaDTtRSYThtzOlmjs93lRTU+bn64S5xmye/QZPZbSAxY3LiuwhKLOmvYLU6rIAfMxM1uBOGcL+dxSmm1FomwZQcbhZa/xJ5MAH/B5DO4Rbi0T3fu6NNyDbJGoQw+k+WoQhiCyKKhMtW3ub45aGSfdXh2+M7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720404; c=relaxed/simple;
	bh=DDxVmhN8UoFoBnJqStWtyIi8BvlT07w9H+nZA8TqXEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mItA0/46QQYEU2q4sjb5F+WBu9SbT3tDsIjt8Ii4rh9VlJVinAtMFq/6RdV1ExMH/3tnvEbd3j51sGNP/Gzqan+TDo4dOskomnyCu2y+4FYIZzFSZh7dzUNuo9S3aIQII5uHTeFLOvMlv1PE6LyzJYyr2SmEqJbL64dIq4NE4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIVt8vRe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yjo5sal6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIVt8vRe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yjo5sal6"
From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718720399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDxVmhN8UoFoBnJqStWtyIi8BvlT07w9H+nZA8TqXEw=;
	b=wIVt8vReK4n+FR1FQ6rub3JOIa5EYme4vK6JdaLZlWmmNgRk6PQuaioXsfunH2AUcBUtXb
	l0FIz26m10hColg+lZ745g6nWrKKfVtqW/+nXtGxybIUAdwA9cBQGXz7QUM2NkX1RV679b
	c2pBPGDn/c4V3Fm9RWOUKPIQFQ5igh0YMUZT/6RigLyxj3A6kKvGVqI3QwFzT9MZEKnYKk
	qWGq+bWulkOsCvGrcqjlCe3WuArlD9okVO5EohIpRwXUImiOq+C3lLi48Ic9jWNHlVk3fs
	NDnBund2Opk8+UBIaPdZ6ZHvy7/vobVlzVdKoILVE2upwLxHIajGN08rsZHt6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718720399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDxVmhN8UoFoBnJqStWtyIi8BvlT07w9H+nZA8TqXEw=;
	b=yjo5sal6usOL7qqxm8Ukqgwkbe9BtIKiRKm3EnQjsu+4qTNXgjYpH3sglDqUGcFETDfWsW
	Zl8GwUdbSp4v5AAg==
To: Riccardo Laiolo <laiolo@leaff.it>, linux-rt-users@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel instability using Marvell mv88e6xxx DSA
In-Reply-To: <e0fda694-ed7e-4f88-980b-f8a955ede802@leaff.it>
References: <e0fda694-ed7e-4f88-980b-f8a955ede802@leaff.it>
Date: Tue, 18 Jun 2024 16:19:57 +0200
Message-ID: <875xu6fi42.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Riccardo,

On Tue Jun 18 2024, Riccardo Laiolo wrote:
> Hi all,
>
> I'm working on a custom board with an NXP iMX8MP cpu (linux 6.1.55-rt16=20
> from NXP's yocto repository).
>
> The hardware is similar to the NXP evk. The main difference is the dsa=20
> switch (marvell MV88E6390).
>
> If I enable the marvell's DT node the system becomes unstable. I have=20
> random kernel panics.

Hm. I've never observed any issues with this switch driver or DSA and
PREEMPT_RT in general.

>
> The error trace is not helpful, it looks like a stack overflow or a=20
> stack corruption. Sometimes it's a NULL (or random unallocated address)=20
> pointer dereference, but sometimes the error is different, I've seen an=20
> error about killing the idle task a couple of times. What seems constant=
=20
> is that the error occurs during the scheduler context switch after an=20
> hard interrupt.
>
> How can I troubleshoot this kind of issues?
>

Can you enable CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_PROVE_LOCKING and see
if anything unusual comes up?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJSBAEBCgA8FiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmZxl40eHGt1cnQua2Fu
emVuYmFjaEBsaW51dHJvbml4LmRlAAoJEMGT0fKqRnOC6KIP/1XnjZao1G6aswew
Gk/REWFVc7Kzkf0fxRuC7uXXw7kwQQcRAG3G9emYFXGcRY1jNBCiokPdJoP147Z2
6++Hw0GIJlq0VXBhAt8DVt8HB5Mijg+HoTlHuUdXnWD4YzKusAeNLft6WCZcT9aq
M5PFzxUEgm8MxWhKQimQjAwAvudvDvRM6SWqLcxh8PDD1ze3VEeaRYq6U6aVOv26
ZBChMtY1DssXKdrVNfWxniENUxCGs1nQJSS9tQ8NEMt8bJeKqx9GJVq7R667q6QC
K8g9Q6SWRt4MUjnGI8NiFDVl8eniaVxjYPf31JKAY/fTgq1ZSr0Ac25dx6+Mno/a
Ysprv4KFQi+OiRPCdfCZrdzvhuicj5CSqkZf3XA8UyFuAdQY2xqKMZH5w6Ty9kvB
8X7yfKU7Lg14T+mA0cW3cDbzgcNElAraAOOcIxDkWYkjcjbRRfEymEPjUOYHsU3D
7htJXlRoJ0MzDPrXoiUkoii7qXbvW6v5x35s5NcgySfUHrbF3wg4dbi92wXdAadl
KmxZAD7H6IY1CNBYBcNYwmpFcR51mqzLQLQvrupN7OGPvbGF8P2F1CLjQoo9pc6/
LsRtZ+fQ9QuwOBlW0gyOr7VLMjI6Ue2H1OQFU02bSTkCn3RiYg3aLSDXu00E+Zqj
8AIeHQIkQzqbEhRECDDfKY3oytBf
=xmFQ
-----END PGP SIGNATURE-----
--=-=-=--
