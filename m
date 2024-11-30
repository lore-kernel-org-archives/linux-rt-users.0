Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B312B93;
	Sat, 30 Nov 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961740; cv=pass; b=P25mbOoLSIEWIlUtt38lObV9dCO4uq0avZu82Bc2/G2AWXIzk6xYZIUhG6ROiQjxMtjp0/dEYKy6PMi7VG30LjTG8rCg6wBwO1qDJ4BhtXjMvP7NIDkDNXbbyTmeTs+S4qE2xGMpCoA3RA+BE+GLnM6C0waSq6kd5rjxN3QE7Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961740; c=relaxed/simple;
	bh=J6IXHadQiU1XOStuWEAX6jAL0rL+/b2dcziZ3tRr0Ac=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nn95dHA7cNvdqYXz7TM4r/EDI4bfD2SferBppnDFuHTWGWEVWK9GeLq8c1qfEDzpjcnNEXpxE54bZYdfg8GX0vGSuVlG2/dC4CfYIk1zJfh/gWMKdG7ITl5qBTJSrP7MuIOLIcruVpE68Pa3zwdgtLqaqF1fta4kVAMRUXrOP3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=edGTzW2q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="edGTzW2q"
ARC-Seal: i=1; a=rsa-sha256; t=1732961732; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LiDAPJ2nGYXkTX+sbSaz/ijspu1mPbtYsQIjDksKWQwayIkEhh+5wUBBi/WFpVTtD2TaMiO6QmRESHX81XqLVMav385CgqfklqlH/M51SZ3MfJdizpn1GeSy7eXJ00nWaz3Fxhh6tgjChZf7EAca81IypS/URVlgWc0gwRhMNR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732961732; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9M4tSzNNiA3/TxDYTXjBJcoxN/Ltx/XARz1nYxuU7vU=; 
	b=BJ512ar2MFaW+Hj40bbbnnxLBhAaM5p4qDukCjrw4yfjqUl/FEINu03lFYp4P7HsnrCzafsDY0TIOhoFGu7J+PG+D3t/mWIJw4VxrshUA6990utMTG6hY1g+AjduPbrO+TfDZhoEQMQV0Hxsvpoo6aqqHhzhahqqzHCuOhKL+78=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732961732;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9M4tSzNNiA3/TxDYTXjBJcoxN/Ltx/XARz1nYxuU7vU=;
	b=edGTzW2qNOLAqCzLDja1ZlDJy29n3SHBQR4l2y7KgSjPGo3jCgb8mdUDW/4d7sGr
	OiG6zKrdQ55Edbx1wQ5W2wX37iO1LbQKMPI89Cq/mH6JSyoIAM1jFOlBcJgVKXxxEMU
	dN2AzmJBBZHIwvyvSAMNRbfZzu7S8JYP+ff8NBbw=
Received: by mx.zohomail.com with SMTPS id 1732961731423856.8165148452375;
	Sat, 30 Nov 2024 02:15:31 -0800 (PST)
Message-ID: <6fa5d605-8a9a-4875-b15e-b236bd74a15c@collabora.com>
Date: Sat, 30 Nov 2024 15:15:29 +0500
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Jeny Sadadia <jeny.sadadia@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Helen Mae Koike Fornazier <helen.koike@collabora.com>,
 kernelci-results-staging@groups.io
Subject: Re: KernelCI report for stable-rt: v4.19-rt-next@v4.19.324-rt139-rc1
To: RT <linux-rt-users@vger.kernel.org>, stable-rt
 <stable-rt@vger.kernel.org>, Daniel Wagner <wagi@monom.org>
References: <6743da2b.050a0220.118402.0d9a@mx.google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <6743da2b.050a0220.118402.0d9a@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On 11/25/24 7:00 AM, staging.kernelci.org bot wrote:
> OVERVIEW
>=20
>         Builds: 17 passed, 1 failed
>=20
>     Boot tests: 298 passed, 49 failed
>=20
>       RT tests: 768 passed, 2 failed
The rt-migrate fails intermittently. Please have a look at it.

>=20
>     CI systems: maestro
>=20
> REVISION
>=20
>     Commit
>         name: v4.19.324-rt139-rc1
>         hash: b33e0cf394c4dfb11c91395dd25ccfc2a9fd2789
>     Checked out from
>         https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable=
-rt.git <https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-=
rt.git> v4.19-rt-next
>=20
>=20
> BUILDS
>=20
>     Failures
>       -riscv (defconfig)
>       Build detail: https://kcidb.kernelci.org/d/build/build?orgId=3D1&=
var-id=3Dmaestro:67437f69923416c0c9942fd4 <https://kcidb.kernelci.org/d/b=
uild/build?orgId=3D1&var-id=3Dmaestro:67437f69923416c0c9942fd4>
>       Build error: make: *** No rule to make target 'Image'.  Stop.
>       CI system: maestro
>=20
>=20
> BOOT TESTS
>=20
>     Failures
>=20
>       arm:(multi_v7_defconfig)
>       -beaglebone-black
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674382ae923416c0c99438c1 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674382ae923416c0c99438c1>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438317923416c0c994394a <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438317923416c0c994394a>
>=20
>       CI system: maestro
>=20
>       arm64:(defconfig)
>       -meson-gxl-s905x-libretech-cc
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438251923416c0c994367b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438251923416c0c994367b>
>=20
>       CI system: maestro
>=20
>       i386:(defconfig)
>       -acer-chromebox-cxi4-puff
>       -acer-cp514-2h-1130g7-volteer
>       -asus-C433TA-AJ0005-rammus
>       -hp-x360-14a-cb0001xx-zork
>       -asus-CM1400CXA-dalboz
>       -asus-C523NA-A20057-coral
>       -acer-cp514-2h-1160g7-volteer
>       -acer-cp514-3wh-r0qs-guybrush
>       -dell-latitude-5300-8145U-arcada
>       -lenovo-TPad-C13-Yoga-zork
>       -dell-latitude-3445-7520c-skyrim
>       -hp-14-db0003na-grunt
>       -acer-R721T-grunt
>       -acer-cbv514-1h-34uz-brya
>       -dell-latitude-5400-4305U-sarien
>       -dell-latitude-5400-8665U-sarien
>       -hp-x360-14-G1-sona
>       -acer-cb317-1h-c3z6-dedede
>       -asus-C436FA-Flip-hatch
>       -hp-x360-12b-ca0010nr-n4020-octopus
>       -hp-11A-G6-EE-grunt
>       -hp-14b-na0052xx-zork
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c3923416c0c9943351 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c3923416c0c9943351>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c4923416c0c9943354 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c4923416c0c9943354>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c5923416c0c994335a <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c5923416c0c994335a>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c2923416c0c9943345 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c2923416c0c9943345>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c0923416c0c9943336 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c0923416c0c9943336>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c5923416c0c9943370 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c5923416c0c9943370>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c4923416c0c9943357 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c4923416c0c9943357>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c0923416c0c9943329 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c0923416c0c9943329>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c6923416c0c9943373 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c6923416c0c9943373>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c2923416c0c9943348 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c2923416c0c9943348>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c1923416c0c9943339 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c1923416c0c9943339>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c1923416c0c994333c <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c1923416c0c994333c>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381bf923416c0c994331e <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381bf923416c0c994331e>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c3923416c0c994334e <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c3923416c0c994334e>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c6923416c0c9943376 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c6923416c0c9943376>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c7923416c0c9943381 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c7923416c0c9943381>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c7923416c0c9943384 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c7923416c0c9943384>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c3923416c0c994334b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c3923416c0c994334b>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c5923416c0c9943365 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c5923416c0c9943365>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c7923416c0c9943387 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c7923416c0c9943387>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c1923416c0c994333f <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c1923416c0c994333f>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381c2923416c0c9943342 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381c2923416c0c9943342>
>=20
>       CI system: maestro
>=20
>       x86_64:(x86_64_defconfig,
>               cros://chromeos-4.19/x86_64/chromeos-intel-pineview.flavo=
ur.config)
>       -asus-C436FA-Flip-hatch
>       -acer-chromebox-cxi4-puff
>       -acer-cbv514-1h-34uz-brya
>       -acer-cp514-2h-1160g7-volteer
>       -acer-cp514-2h-1130g7-volteer
>       -acer-cb317-1h-c3z6-dedede
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438170923416c0c9943086 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438170923416c0c9943086>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743816e923416c0c994307a <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743816e923416c0c994307a>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743816e923416c0c9943077 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743816e923416c0c9943077>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743816f923416c0c9943080 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743816f923416c0c9943080>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438168923416c0c994303e <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438168923416c0c994303e>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438167923416c0c9943038 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438167923416c0c9943038>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438167923416c0c994303b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438167923416c0c994303b>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743816e923416c0c9943074 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743816e923416c0c9943074>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438167923416c0c9943035 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438167923416c0c9943035>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438168923416c0c9943044 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438168923416c0c9943044>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438166923416c0c9943032 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438166923416c0c9943032>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743816f923416c0c994307d <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743816f923416c0c994307d>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438205923416c0c9943503 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438205923416c0c9943503>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743820b923416c0c9943530 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743820b923416c0c9943530>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438205923416c0c9943506 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438205923416c0c9943506>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438206923416c0c9943509 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438206923416c0c9943509>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743820b923416c0c994352d <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743820b923416c0c994352d>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743820a923416c0c994352a <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743820a923416c0c994352a>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438205923416c0c9943500 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438205923416c0c9943500>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743820a923416c0c9943527 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743820a923416c0c9943527>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438204923416c0c99434fd <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438204923416c0c99434fd>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438209923416c0c9943524 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438209923416c0c9943524>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438207923416c0c994350f <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438207923416c0c994350f>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:6743820c923416c0c9943536 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:6743820c923416c0c9943536>
>=20
>       CI system: maestro
>=20
> RT TESTS
>=20
>     Failures
>=20
>       rt-tests.rt-migrate-test:
>       x86_64:(defconfig)
>       -hp-14b-na0052xx-zork
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:674381ad923416c0c9943289 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:674381ad923416c0c9943289>
>=20
>       CI system: maestro
>=20
>       rt-tests.rt-migrate-test.rt-migrate-test:
>       x86_64:(defconfig)
>       -hp-14b-na0052xx-zork
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:67438599923416c0c9943d3a <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:67438599923416c0c9943d3a>
>=20
>       CI system: maestro
>=20
> See complete and up-to-date report at:
>=20
>     https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_co=
mmit_hash=3Db33e0cf394c4dfb11c91395dd25ccfc2a9fd2789&var-patchset_hash=3D=
 <https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_commit=
_hash=3Db33e0cf394c4dfb11c91395dd25ccfc2a9fd2789&var-patchset_hash=3D>
>=20
>=20
> Tested-by: kernelci.org bot <bot@kernelci.org>
>=20
> Thanks,
> KernelCI team
>=20
> _._,_._,_
> -----------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------
> Groups.io Links:
>=20
> You receive all messages sent to this group.
>=20
> View/Reply Online (#74789) <https://groups.io/g/kernelci-results-stagin=
g/message/74789> | Reply to Group <mailto:kernelci-results-staging@groups=
=2Eio?subject=3DRe:%20KernelCI%20report%20for%20stable-rt%3A%20v4.19-rt-n=
ext%40v4.19.324-rt139-rc1> | Reply to Sender <mailto:bot@kernelci.org?sub=
ject=3DPrivate:%20Re:%20KernelCI%20report%20for%20stable-rt%3A%20v4.19-rt=
-next%40v4.19.324-rt139-rc1> | Mute This Topic <https://groups.io/mt/1097=
64951/6630336> | New Topic <https://groups.io/g/kernelci-results-staging/=
post>
> Your Subscription <https://groups.io/g/kernelci-results-staging/editsub=
/6630336> | Contact Group Owner <mailto:kernelci-results-staging+owner@gr=
oups.io> | Unsubscribe <https://groups.io/g/kernelci-results-staging/leav=
e/13729535/6630336/1522968245/xyzzy> [usama.anjum@collabora.com]
>=20
> _._,_._,_


--=20
BR,
Muhammad Usama Anjum
