Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5710E9
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jul 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201375; cv=none; b=Z8sLgFyWsholS0GkE6x1ToAq71lb+jWcVIwDmJdJKMAhOHyC4KcBx6cfwjpbnxXI4sdxXkktvIUkjcjnUQo1Gr3YDBNec1Ug1DIj2tb609IDs5CloMfa+D1T5CRObSlFy/17oPoyN3vMGWoL8LwKtDq0MFoGHa/whDbJ6UfGBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201375; c=relaxed/simple;
	bh=ZtWnYSsMu0TLaAtpWRAe36itLoEhYjNQYSDLfActCDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fs9mY1Xvl6jhBwW/3APjBl30w1qlnvifS+/HccHc1vEet7wLVGPokyY5IMVNTJ4HrBGhMHjw1tCg4auO3O9VMcFyaWRah8tV+0i+0NzBI7KQ1+pElo6jN9NUMBlE3ZX/OnKBuetEM30YpBvYkR3ljbud0taH53mR8nUT/FatEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=oKaTqWb5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="oKaTqWb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752201371; x=1752806171; i=efault@gmx.de;
	bh=AS5LF7FXkZcNVT5ii5sVZHRlbxXuRD6RP+Kz5Tb9dRc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oKaTqWb58gH9IxwA67oVc+UrCBjWd30w0flOBVBVdoQqN4NK16RNinzInbRhDKvV
	 ZAD6UGj1MoOzWYLGurTLGPIDBX51Q7/ag9sP/stDPeCq5YWJvh5OPPpjpDnOvY4Pt
	 4CEL2FFlmfQzH2z4dIIiR0Yecth3ugzUhPQ8uAcBrFfamkTxZtqdpuBVpEuxH54Ts
	 tMwAtKLrXaMno9IZTSQoOo9mf2NpxTfy8yCeH69Qua4HqnuDzr3N1+iYjO1RJP1oq
	 L2sgP+DHC9T1M+EJix5F0HZuH5lNiyc7Bs5PNDwLfPMEOgXMxteQfmp1+n+KCOzhY
	 maKEMZ1ysnkvH2hZOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1umSk20X5p-011Nmd; Fri, 11
 Jul 2025 04:36:11 +0200
Message-ID: <641d3228244517fd1cfb4a103339e86a222cae2b.camel@gmx.de>
Subject: Re: PREEMPT_RT vs i915
From: Mike Galbraith <efault@gmx.de>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ben Hutchings
	 <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Debian kernel maintainers
	 <debian-kernel@lists.debian.org>
Date: Fri, 11 Jul 2025 04:36:08 +0200
In-Reply-To: <aG_hNb-c_m0yfVE4@intel.com>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
	 <aG6nMhimN1lWKAEP@intel.com> <20250709194443.lkevdn6m@linutronix.de>
	 <aG7MckLkTuzZ5LBe@intel.com>
	 <da51a963b04f0a1b628e80a2c5df72a1609960d1.camel@gmx.de>
	 <aG_hNb-c_m0yfVE4@intel.com>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:o4zZTVGqpxGlbgWb5nQeJpjFfUYfOZx48GFFoM78Fr3Zz0lbOn7
 eWlqjJLqNicsf5wGjQjIT98tqjQ2/sAGaqKiBsEexTT9PvNSZeGo56fwz9TBB7bQGDNGeh3
 VEwnwnqmDLjpqTxhLXYp34FBw3hu95g3lnYRZvfGwVvs/K74H6qmKoHhwI1CdgSm1uYuGHU
 2Gd1Dnk33KxOlSwMPXizQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mULwm0AIuwY=;ebvs87+OLjC/8r6Qa+aq6GwBgfO
 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
 ml5GBFfKuHQ==

On Thu, 2025-07-10 at 18:50 +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Jul 10, 2025 at 06:52:58AM +0200, Mike Galbraith wrote:
> > >=20
> > > Until someone actually does the work to confirm the thing is working
> > > reliably there's no point in posting anything.
> >=20
> > What does that entail?
>=20
> Basic testing would be something like this:
> - enable CONFIG_DRM_I915_DEBUG_VBLANK_EVADE
> - set i915.enable_dsb=3D0 to make sure everything takes the
> =C2=A0 mmio path

I can give that a go while tossing rocks to check for moaning..

> - stress the heck out of it and make sure the histogram
> =C2=A0 doesn't look significantly worse than on !RT
> =C2=A0 (kms_atomic_transition --extended might take care of the display
> =C2=A0 side here, but it should probably be accompanied with some
> =C2=A0 horrendous system loads which is a less well defined part)
> - ideally do that on a potato
> =C2=A0 (some VLV/CHV (Atom) thing would probably be a good candidate)
> - repeat with lockdep enabled to make everything even harder

..forwarding any performance goop emitted, but lockdep runs out of lock
counting fingers and turns itself off in short order with RT builds.

	-Mike
