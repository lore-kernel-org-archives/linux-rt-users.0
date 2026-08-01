Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196E22E3F0
	for <linux-rt-users@vger.kernel.org>; Sat,  1 Aug 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.206.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577086; cv=none; b=lveLrlewg9s2J1k3hsIAfjz8LiYOMRDwYHEQ7dPnTCG+bIaSLYpN7VUM2Ou4z5ujmt3uxbSMstpje9Majrr9V097lhtZm3gul5V91chvqIuLHzdZ3pZF8sEEERxSl7N09Eko5jXITHxX4b+Jz8lyIW77xM9NOZMdLsgIj7Yx9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577086; c=relaxed/simple;
	bh=oJVkqO4ugxwX2tGfOKUkDUfYtBIYU4Vndjnlc4diDpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOAec+H8ZOe2q6dnSGjz1KDxm4a7IxGD/MudO4NGTuXEotGDWzyN2Rjx1ACaC9guxdEAIpjGXyUt4mMK0jzCYqvbu622zXKf+VVm4n8NoKsrp81mj0WIwowBcZmeb0rDJfl8ghhJna00sGkgg3ZK3NXy3lH82cxIcWS+F4XhxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de; spf=pass smtp.mailfrom=sleepmap.de; dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b=a5SO5lXh; arc=none smtp.client-ip=85.10.206.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b="a5SO5lXh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sleepmap.de;
	s=RzV2MS86Cdvz; t=1785577081;
	bh=oJVkqO4ugxwX2tGfOKUkDUfYtBIYU4Vndjnlc4diDpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5SO5lXhw6qDZaKUQ1+2KAdA1LCC9A/I3sVw3YQqxV2xTLf+v/2qf9r4RRo/f/vE0
	 kldOn3Cw68wrLpYaLwIYjh0V5CKaevLVxNGq4ybdLQHELQwPoQdX+rnucD8WCPsqpr
	 CK9/Fapg/UksApMHRnTvBwOdWaIlp9jKdx0rXdnM=
Date: Sat, 1 Aug 2026 11:37:54 +0200
From: David Runge <dave@sleepmap.de>
To: John Kacur <jkacur@gmail.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] tuna v0.21 released
Message-ID: <am2-ct0Dwao_0Ul0@hmbx>
References: <20260728213631.285648-1-jkacur@redhat.com>
 <amxtfI7-b5L_5Grd@hmbx>
 <668a7fbb-ee05-2109-e2ee-c9455002fbff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5p0UGj+oNy4JoJOp"
Content-Disposition: inline
In-Reply-To: <668a7fbb-ee05-2109-e2ee-c9455002fbff@gmail.com>

--5p0UGj+oNy4JoJOp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 1 Aug 2026 11:37:54 +0200
From: David Runge <dave@sleepmap.de>
To: John Kacur <jkacur@gmail.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] tuna v0.21 released

On 2026-07-31 23:24:53 (-0400), John Kacur wrote:
>=20
>=20
> On Fri, 31 Jul 2026, David Runge wrote:
>=20
> > On 2026-07-28 17:36:31 (-0400), John Kacur wrote:
> > > Tag: v0.20
> >=20
> > Hi John,
> >=20
> > congrats on the new release!
> >=20
> > As tag v0.20 is from nine months ago, I guess you meant v0.21?
> > However, this tag does not exist yet. Did you forget to push it?
> >=20
>=20
> Yes, I forgot to push it. I did so now. Let me know if it works for you.

Thanks for pushing the tag!

I unfortunately now run into a build error, because with tuna 0.21 you have
introduced a circular dependency on tuna itself [1].

```bash
python -m build --wheel --no-isolation

* Getting build dependencies for wheel...
Traceback (most recent call last):
  File "/usr/lib/python3.14/site-packages/pyproject_hooks/_in_process/_in_p=
rocess.py", line 389, in <module>
    main()
    ~~~~^^
  File "/usr/lib/python3.14/site-packages/pyproject_hooks/_in_process/_in_p=
rocess.py", line 373, in main
    json_out["return_val"] =3D hook(**hook_input["kwargs"])
                             ~~~~^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.14/site-packages/pyproject_hooks/_in_process/_in_p=
rocess.py", line 143, in get_requires_for_build_wheel
    return hook(config_settings)
  File "/usr/lib/python3.14/site-packages/setuptools/build_meta.py", line 3=
33, in get_requires_for_build_wheel
    return self._get_build_requires(config_settings, requirements=3D[])
           ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.14/site-packages/setuptools/build_meta.py", line 3=
01, in _get_build_requires
    self.run_setup()
    ~~~~~~~~~~~~~~^^
  File "/usr/lib/python3.14/site-packages/setuptools/build_meta.py", line 3=
17, in run_setup
    exec(code, locals())
    ~~~~^^^^^^^^^^^^^^^^
  File "<string>", line 9, in <module>
ModuleNotFoundError: No module named 'tuna'

ERROR Backend subprocess exited when trying to invoke get_requires_for_buil=
d_wheel
```

Due to this recent change [1] the build process now has to include the curr=
ent
working directory in `$PYTHONPATH` to make this work:

```bash
PYTHONPATH=3D"$PWD" python -m build --wheel --no-isolation
```

This is a bit uncommon and I believe that it might be more worthwhile setti=
ng
the version differently, e.g. using setuptools-scm (see e.g. the pyproject.=
tom
example for setuptools [2]) or other PEP517 build backends.

Relatedly, maybe other build backends than setuptools might be an option,
to only rely on pyproject.toml going forward and have better versioning
integration?
(I think even with setuptools it is not really required to have a setup.py
anymore, but I'm not following that ecosystem too closely).

Best,
David

[1]: https://git.kernel.org/pub/scm/utils/tuna/tuna.git/commit/setup.py?id=
=3Dcb5593a2be9c26c8865f46bf29723c1ce93890aa
[2]: https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html

--5p0UGj+oNy4JoJOp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR8efy7g3Ll3lsX4JqQ1LlkHgkpcQUCam2+cgAKCRCQ1LlkHgkp
cfbkAP91xoDQyI4Oc/CXynMRoqQu75csE4E9l3f/aO5GnvOhiAD8Cdqs7kmPs4R/
vXszj8U83Nh3YPENjLsFCka2kynNqQ8=
=EspL
-----END PGP SIGNATURE-----

--5p0UGj+oNy4JoJOp--
