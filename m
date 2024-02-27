Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CA13A259
	for <linux-rt-users@vger.kernel.org>; Tue, 27 Feb 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043036; cv=none; b=XveOeZZkRuOUBV00hFK7hHm9+xbHHKEWdWK/aL4ietK64/x5c9kj9DXPfy0Hz4OKOe9J0yChDY0wSdcHm4cRS39I/hEO2ErN41izheXoVmZcPwJl3itdcqLjGFJfbGilc/spJpqzFaJE5EBBHwQZrQZrANvyfnxYpQP6eaSug8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043036; c=relaxed/simple;
	bh=l9QXl1WpCY071A9eBQXSK8FpYP9fISxLzpMQtAzaEws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpxKI9496GI2C42B/TPUKG5grqJy0RcygKNwixe82T3HRuGK6Y+tTE2iLcAJ0OEjTklcS1F4DlzKxgzUiGJBYtWF6FlFU5dXgogtA0bIrXWIFcTC3RO4D4FpP6ymKID865DZE+JFac5RCHRr7wvLXcwHtd9h3BcDOiQVyhLGPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mRbM5Gg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vw8iS24m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mRbM5Gg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vw8iS24m"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709043027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eqPJT4XFjOkh3sjdhKCAoNnVEPaZrklqT+T4YxE3HWk=;
	b=mRbM5Gg/z3nqicJED6c+eJdo4EpOVAq0mfZV8CQv64x9cmpOGX/Qu5xYS9DT9oYsE2Aq1r
	s6robZOsA+KutXulYKd6NWeANr3/5POoOK4+uBVhMAh5Um//T+FjOvJsDkRfu17xOwCRJl
	EFYggEUpdBPGKlvZwGc9iuoQ6+DCjmZGTvTKwUytlIiSZ4ttvL9HmHc4EILP2V9SJNPdX4
	+ceR4cB5hZY4pDPOTjxEHcXVjFCyXSlrQsCUEA5y/MWddvZt8Rk5GM7JagVMCV5pI9jhKT
	g7mW3zUHXPouwg0ZMBLYeaItUy5mCmUmZbvQwJuIMBoa+dJlf6OgVTdfQO5usw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709043027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eqPJT4XFjOkh3sjdhKCAoNnVEPaZrklqT+T4YxE3HWk=;
	b=vw8iS24mtQtksxJoszvfo65ykt2/diXHQrYE8mZKlySgcongmCIpwRFzok8o4jPHm5bWDT
	BctMrcxP8omCbbCg==
To: rt-users <linux-rt-users@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Jan Kiszka <jan.kiszka@siemens.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, "Ong, Boon Leong"
 <boon.leong.ong@intel.com>
Subject: [ANNOUNCE] TSN-Testbench
Date: Tue, 27 Feb 2024 15:10:26 +0100
Message-ID: <874jduj8vh.fsf@kurt.kurt.home>
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

Hello RT-list!

I'm pleased to announce the TSN-Testbench.

The TSN-Testbench is a real time networking simulation (PROFINET RT/TSN, OPC/UA,
...)  and validation tool for Linux with PREEMPT_RT focused on strict cyclic
workloads. It leverages modern Linux networking technologies such as XDP, XDP/ZC
and busy polling in combination with precise time synchronization and scheduled
traffic.

It generates RT and non-RT traffic, mirrors traffic, performs consistency checks
and latency measurements. In a broader sense think of `cyclictest' over the
network.

It has been tested and used on NIC(s) such as i210, i225/i226 and stmmac.

You can get the code and documentation via the git tree at:

  https://github.com/Linutronix/TSN-Testbench

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXd7VITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpoeD/wPAEgihkimY3c5eQdIv1kN5v9+mvrX
QIESxk9WCWI+y4CjyRKmSf3rknvwLxI6xAZ5WgIUT8OkOhH1js87mfMfrHU2Bwk6
B7EpAksiJO8KZ7LW4rUW7JKDraxYOq/XPMqiruzut92TDjTJqtQBtzH5cUkbz5V8
Dlj1GdlLt7UX2JCIwhy3dpbHCVGePx2ojklvQ/VyigvEqbaat9Q8GpPH5nXbkjE3
9x2iAHWbO8RloKR/5KYYmGUE7zM9jN7kSPgtnnheHvSPP5nT+pMnwTaQG00bu3Ic
644YR9iCmsSEmP9ss+iD6qIIt21qXEisozqducBlWv5X3t3WyeTbXNQw9Weydckj
6NuNYEx5e3UObO7PSCSLwi4cZA+BllZzn3LgbQNgnuw7iLDBrlpOcARaOjN20Vin
PL6RNu+fIvcCRSx2evTIlU3KCHsWuRr5TbiYEnFkM25hRE7eegWuEzZ7Fa62vFwt
JwIkIi+60W4rba3dZXZzYPHbJWwu58wVOetkXOn2PSUWvw8LZl+fxDYlSnRQf54+
H087xdQ7T0bwPedIwSF730ISyTWzVpIrzOy0JorU4K25mXuh/W/QyDBGuilrcKVZ
lG+WJwIQGsj9Uyb3JYRZZAbnAle66ICELBCt/VlT5VRTusizd2svG9N0rTujK9eK
P/7puB7BP15pdw==
=8W5z
-----END PGP SIGNATURE-----
--=-=-=--
