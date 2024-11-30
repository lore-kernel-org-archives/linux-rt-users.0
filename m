Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1712B93;
	Sat, 30 Nov 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961790; cv=pass; b=rpzJYF6RRYb69lo9ObCIfz5wWVvejQyNrLHhVWAJd1ZW4S+6z6R/iMsldtsYpQfesY+g2NmWqDSByrpiiIYf5x3YhkIDzfaQI9cnjRWDQKjbRnLVAWVGKVDjiW0pwh8w7ODWea1Jckyix7yuO7IpPezU5adbqft5V5sUt8IJDNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961790; c=relaxed/simple;
	bh=7sbs/p8Pz/OHFacId2voIkBn7Y7ddx73PHjXXLD5N1I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oWPXMqW+QooHtAM3wkmYPRqMujeR0I3RiA+r5NxXRa0y1BqWYgaBh9jA40wTM82Ny6s41Cf9t80gIwlT2q5XYYxEj1jUyh/sUmelL45fcq7rAIkzVhkNfESPD/gdDLr9P5IpWTrlxHooymQ40n/uw76IVEPzxq7YgZweP6yyQt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=C44Jafx+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="C44Jafx+"
ARC-Seal: i=1; a=rsa-sha256; t=1732961784; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YS0+MLEVkvwO5QuWf8EZ8L7kIjpr15rAgGoV3WOJKVd0DzFDM/ukY3+jERcsXM7Xq9UslLPWMrWD57hpoC8f9g7TiyHIyLL0GN644Ju4kHDcmiFPtZ2SqdSzqzXckH4m3WyJCJ+4UpcLXCcR1FsAhXVnJzw5/9h/z8DaNx7rvns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732961784; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ePiELv7O15kU1sBettE+Li1B8u2wIQ+pHE03ejNfpMU=; 
	b=cIgoG4nabxvK0FMz2i0RS8S5BGA9UuciHsMADwibQbXSdEADihLDgXZI/jlstT7Jr/8eh4RoQeDqdPAQMHJjJhJanfWNyxrAJp6H8iFAh10aogl0j43oYWTED+EsVaXydSwI5TTGE+wBVDvJuGS4p7RwF1W4Vj7MHdAi4qW0SEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732961784;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ePiELv7O15kU1sBettE+Li1B8u2wIQ+pHE03ejNfpMU=;
	b=C44Jafx+ll3KaLXjut1wtRYN6rxb4T6HGax3TYyZf0g3aXZwpfFpQeXlcyo8BPay
	BB+sDGruY1HfzTprPQV1PhPXRiGuSDIEimwor61eG9VUn3tFz8N+Sll+bk76XHHrPjJ
	ZGbc+bWaSS+j4+SuOQJpwikaYOEbPH9fcsobQhgw=
Received: by mx.zohomail.com with SMTPS id 1732961783457975.6191002667166;
	Sat, 30 Nov 2024 02:16:23 -0800 (PST)
Message-ID: <e7f0b8ba-a4d5-42d0-a113-7fc77bb9548c@collabora.com>
Date: Sat, 30 Nov 2024 15:16:26 +0500
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Jeny Sadadia <jeny.sadadia@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Helen Mae Koike Fornazier <helen.koike@collabora.com>
Subject: Re: KernelCI report for stable-rt: v5.10-rt-next@v5.10.229-rt122-rc1
To: kernelci-results-staging@groups.io, stable-rt
 <stable-rt@vger.kernel.org>, Daniel Wagner <wagi@monom.org>,
 RT <linux-rt-users@vger.kernel.org>
References: <673c953a.050a0220.2a2b4e.3468@mx.google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <673c953a.050a0220.2a2b4e.3468@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On 11/19/24 6:40 PM, staging.kernelci.org bot wrote:
> OVERVIEW
>=20
>         Builds: 10 passed, 0 failed
>=20
>     Boot tests: 75 passed, 30 failed
>=20
>       RT tests: 1218 passed, 6 failed
The rt-migrate fails intermittently. Please have a look at it.

>=20
>     CI systems: maestro
>=20
> REVISION
>=20
>     Commit
>         name: v5.10.229-rt122-rc1
>         hash: 27cbaf327469f5cf5bf5287cc902158ad88f4c25
>     Checked out from
>         https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable=
-rt.git <https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-=
rt.git> v5.10-rt-next
>=20
>=20
> BUILDS
>=20
>     No build failures found
>=20
> BOOT TESTS
>=20
>     Failures
>=20
>       arm:(multi_v7_defconfig)
>       -beaglebone-black
>       -odroid-xu3
>       -imx6dl-udoo
>       -imx6q-udoo
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf13e9420421370e6ee72 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf13e9420421370e6ee72>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf13b9420421370e6ee69 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf13b9420421370e6ee69>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf1ed9420421370e6f3b2 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf1ed9420421370e6f3b2>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf13f9420421370e6ee75 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf13f9420421370e6ee75>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf1409420421370e6ee78 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf1409420421370e6ee78>
>=20
>       CI system: maestro
>=20
>       arm64:(defconfig)
>       -rk3399-rock-pi-4b
>       -sun50i-h5-libretech-all-h3-cc
>       -meson-gxl-s905x-libretech-cc
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf1cf9420421370e6f2f4 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf1cf9420421370e6f2f4>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf2e39420421370e6f997 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf2e39420421370e6f997>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf1d59420421370e6f349 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf1d59420421370e6f349>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf2499420421370e6f6d3 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf2499420421370e6f6d3>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf1d39420421370e6f303 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf1d39420421370e6f303>
>=20
>       CI system: maestro
>=20
>       i386:(defconfig)
>       -hp-14-db0003na-grunt
>       -acer-chromebox-cxi4-puff
>       -dell-latitude-5300-8145U-arcada
>       -acer-cb317-1h-c3z6-dedede
>       -lenovo-TPad-C13-Yoga-zork
>       -acer-cp514-2h-1160g7-volteer
>       -dell-latitude-5400-8665U-sarien
>       -asus-CM1400CXA-dalboz
>       -acer-cp514-2h-1130g7-volteer
>       -hp-x360-14a-cb0001xx-zork
>       -acer-cbv514-1h-34uz-brya
>       -asus-C436FA-Flip-hatch
>       -dell-latitude-5400-4305U-sarien
>       -hp-14b-na0052xx-zork
>       -hp-x360-12b-ca0010nr-n4020-octopus
>       -acer-R721T-grunt
>       -acer-cp514-3wh-r0qs-guybrush
>       -hp-11A-G6-EE-grunt
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c09420421370e70356 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c09420421370e70356>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c39420421370e7036b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c39420421370e7036b>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c59420421370e70381 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c59420421370e70381>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c29420421370e70365 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c29420421370e70365>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c19420421370e70362 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c19420421370e70362>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c39420421370e70371 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c39420421370e70371>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c59420421370e70387 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c59420421370e70387>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4bf9420421370e70350 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4bf9420421370e70350>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c39420421370e7036e <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c39420421370e7036e>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c19420421370e7035f <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c19420421370e7035f>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c29420421370e70368 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c29420421370e70368>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c49420421370e7037b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c49420421370e7037b>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c59420421370e70384 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c59420421370e70384>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c19420421370e7035c <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c19420421370e7035c>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c69420421370e7038d <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c69420421370e7038d>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4be9420421370e70343 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4be9420421370e70343>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf53d9420421370e70725 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf53d9420421370e70725>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf9039420421370e73650 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf9039420421370e73650>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf4c09420421370e70359 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf4c09420421370e70359>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf7eb9420421370e71c9b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf7eb9420421370e71c9b>
>=20
>       CI system: maestro
>=20
> RT TESTS
>=20
>     Failures
>=20
>       rt-tests.rt-migrate-test:
>       arm64:(defconfig)
>       -meson-g12b-a311d-khadas-vim3
>       -rk3399-rock-pi-4b
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf2379420421370e6f65b <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf2379420421370e6f65b>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf3079420421370e6fa3d <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf3079420421370e6fa3d>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf2399420421370e6f661 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf2399420421370e6f661>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf6889420421370e71054 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf6889420421370e71054>
>=20
>       CI system: maestro
>=20
>       rt-tests.rt-migrate-test.rt-migrate-test:
>       arm64:(defconfig)
>       -meson-g12b-a311d-khadas-vim3
>       -rk3399-rock-pi-4b
>       Test details:
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf3079420421370e6fa3e <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf3079420421370e6fa3e>
>       - https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaest=
ro:673bf6889420421370e71055 <https://kcidb.kernelci.org/d/test/test?orgId=
=3D1&var-id=3Dmaestro:673bf6889420421370e71055>
>=20
>       CI system: maestro
>=20
> See complete and up-to-date report at:
>=20
>     https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_co=
mmit_hash=3D27cbaf327469f5cf5bf5287cc902158ad88f4c25&var-patchset_hash=3D=
 <https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_commit=
_hash=3D27cbaf327469f5cf5bf5287cc902158ad88f4c25&var-patchset_hash=3D>
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
> View/Reply Online (#74694) <https://groups.io/g/kernelci-results-stagin=
g/message/74694> | Reply to Group <mailto:kernelci-results-staging@groups=
=2Eio?subject=3DRe:%20KernelCI%20report%20for%20stable-rt%3A%20v5.10-rt-n=
ext%40v5.10.229-rt122-rc1> | Reply to Sender <mailto:bot@kernelci.org?sub=
ject=3DPrivate:%20Re:%20KernelCI%20report%20for%20stable-rt%3A%20v5.10-rt=
-next%40v5.10.229-rt122-rc1> | Mute This Topic <https://groups.io/mt/1096=
64171/6630336> | New Topic <https://groups.io/g/kernelci-results-staging/=
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
