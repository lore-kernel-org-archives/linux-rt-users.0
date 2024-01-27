Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F48C09
	for <linux-rt-users@vger.kernel.org>; Sat, 27 Jan 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330322; cv=none; b=Z63DuS3h8j4A55i7sfh8uEVc4VJ2BEjYHMZUpGlRkKhIyHTcspmR/ksQeKa2tmo/9PU2YXtyHrHXs/o7XvXhfKmVLoQLov+Rj7edk62Lf/ttxDcZESdvY1CXOrNjwvAzvPn0wlcz0LZuDf4E2wJqPx3VmLqNgQU03PbXm2NyEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330322; c=relaxed/simple;
	bh=EAL3ZmAtoQfyTmOm8rElCoDDKGHXK0LJQYlCK7t67O4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pb3rIn7NaWM8RV+kFL606NSah/gYlZDN57ZyI8WG9zSHT8/oaHTuI5bvrx57kewx9Dc5EJP3kiDhx+hMDgGUdILFCLEoUhjbxzc/ySWMfjvK5YXOhX6rZ41yLkJSPsUVE/7GKIsm5DQv/QZG91xEB8+bGjpbptWiYx74+CsedQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=YieAo5OA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="YieAo5OA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706330306; x=1706935106; i=efault@gmx.de;
	bh=EAL3ZmAtoQfyTmOm8rElCoDDKGHXK0LJQYlCK7t67O4=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=YieAo5OAoNjrg28osxfPrTVvKDxrzg6tGkVbqu/WtBy4XlSANjyrdsuBwXdC6VaD
	 WJepN9fnRAfVGkRDVuO4HEnbUmCAZDuvhAHkqZcv7GzGnFI9pUEoyd384IxMxHPzt
	 3JjEn3OtqlhiUK15dHc3/m9wVjgrnT7ozO2JqdqnyoE6mbsZZm4dYxjSNE/k6ZBNm
	 HdDTDOVk5HZkyDNez8RXP64Xq3ATRNpyjT+MyiHvvzAaQgUW0qEUrSQttUuPpX+46
	 e9cTIOop4WIktHzFx2+tP7ULiPVkpi9qs9k77qv50DDGQv+iK3FfaxoHLJVsDzFYU
	 7C6d+clqNisy7ieN5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1rUxVX2QBB-003c2q; Sat, 27
 Jan 2024 05:38:26 +0100
Message-ID: <c6aae9bc01baa058c2e572a8b27b44f0e6ec7ae3.camel@gmx.de>
Subject: Re: [ANNOUNCE] v6.8-rc1-rt2
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Date: Sat, 27 Jan 2024 05:38:25 +0100
In-Reply-To: <20240126163725.kQgJktTk@linutronix.de>
References: <20240126163725.kQgJktTk@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mh2IuQTzZDfLUwVTr0oaWozpwlyMocH0mOmPfYDjJdrZjsJVZvc
 d9ta3NIcL4e+qBLkKUR9LN4W2BkuX56QNNepW+djfJtwdYT6hz7cEE8HZsNfbyFVpPgpDRj
 6NbfPqsmBS9Njkc8vPBYz2WzNBfiuU3vYWzeyWTpeRcVJFmLuqQliRa5NG2DhSmCkMxvgxA
 sUOqOi+2jPNvBOnat8zGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:69tgKHL27Jk=;K3HBz/lUWO+GzRC0f/XB+6hHu3G
 g+E8R5QlQ+hThBvLZbZHaxjyXg+7d3Jtun7ILvB1XbAxHOTfq0g2rpNg4Jh8FAdmqFo83BP96
 /6eNXUJ3plilfk7Lh0tpBrmemVYS0jwUTjuxHZLd4SPkZ4j2fPDFp+OEXK/Z+6pL7nVpYw3o2
 eHPxhgbMLpamNEOsIN2v01eu2SNP0XRE9PfBMxY4nEbYFJP1ERZl92UOofcBp1N2HhSVc7ERH
 xsqg9+VGm6CD2wP94TcYGwAcFpKcUiZfjQIxC0t3nsDtgJ6q07U9lEi6mIYGY/srj06f0HFL2
 1WkpqXKPrUZhuQMXZaXWseqxrPAsXF+B0WCogJRyLftt/BsJOoqoEZJq8kSxL1/VyPA69uQn8
 31Vk6c8k7bXiMfQTDi/gWaJCxHLuDY3sVPCfrQ/Nw//culnv6HyyjXEInlEELeFcE04DHrI45
 noPvDGl2OdmEj/qJnSKhBRA0B7rby7TohNbanK5NK+J8Etff6C56b83+4IkSFyPTC/R1ZFur3
 YjDUS3TuIj6T8IR+eB21aj02M/dUc+ibGUfSriUGtS6f+Hn8tRMnQ/CWZ+sMq3toYl5TAuT+C
 pNdcSFjq+6wMcFyuQbHulMsc4AqM4nnJn6moLPjFJiXwFJvQUfAWSSY82vqsty4L5FL4Vpo9+
 HPkiUOPVafKlVu1E2QHoi/s/Hc4Hvsg3xKFm+3h+hYV8DZ3OGVat5tofM+iLJPDdTrNx8yWoJ
 CyR5caaa1E2cGB+8T8QYbqvaVDGMAAf1EudB8KjbQ9XPsGgb/Yna1EHKeHp+JViGDmKSyZ0hj
 6FvytBhXuycjufQXbpVtEd8oVElYcv5On8NiDUgy0ipT/Qfc9ksguedZWmWgQJ8CdVwDo5xvp
 PqFBtpFttLreFpAA/VySO/g4wVOstauoKpgyRisO7iwObA6UNrdvG/e6QyO9CqaA5n6xKcrHr
 FwJwdNE+gizvsJRv3xbzVw2orG0=

On Fri, 2024-01-26 at 17:37 +0100, Sebastian Andrzej Siewior wrote:
>
> You can get this release via the git tree at:
>
> =C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/rt/li=
nux-rt-devel.git=C2=A0v6.8-rc1-rt2

tic-tock-tic-tock..

git@homer:..git/linux-2.6> git remote update
...
git@homer:..git/linux-2.6> git describe linux-rt-devel/linux-6.8.y-rt
v6.8-rc1-rt1

Hm, git.kernel.org must be doing its nails or something.

	-Mike
