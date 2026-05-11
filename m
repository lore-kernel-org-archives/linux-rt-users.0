Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492540148F
	for <linux-rt-users@vger.kernel.org>; Mon, 11 May 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513539; cv=none; b=j5063P3p1PLVaw80hRhqqEr9YUJlQj5arpCd/qWLLc6Z9h1wOSSFnSqF5ZUmWIz86z5uALS1H2VdniYCWlfafp0cMWSxZuYGIPsIRjQRkmnHWu+0a9r7rxCMY60VZQqJLNBCDq8npor5oIJJQ7KQdCXGwC3zLvNdXj051OCSCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513539; c=relaxed/simple;
	bh=+rct+vmVC8M2hnqxpm8TSOirIXZPIl6O/29pZZbtZD8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snG4H4nExUIcA+rpxCtX7N7o9cs9krnrU8n8M9QIWrwfYWSy7A0rUBwsRsM0vQHykLQGanVJ3bgL0Rhs5b/gms0QCZHR1uEdk3Qzf7Pe1xtoCAOcDOWyAUuZnnrQ3NoV+c4/wGbs+9Lsh9BRuwzHA822jvoaJ2t26p007/8+R2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwFGgLeg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Upci8HtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwFGgLeg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upci8HtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778513535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=drWyFR8xnXB3cjN95XAU9/1Dyd33+46Fr6KwmjcBb60=;
	b=VwFGgLego8J7cH45xpw/2rmG5ce21Wpa0OgbmPPlFc88Hct7f/WtzZRsH6uvwFk2aV5KxA
	u95eyR0osmKx79u92RkXaniqLZ2z8b58oWpL8nSAI0k8hQM6sEHBGJz/bdfXI5+gAZWZm1
	1FYRLPalgrzXZmbo6qnAIc0mHd4BEa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-hninVhcwM0Ke6wSG2h9DcA-1; Mon, 11 May 2026 11:32:12 -0400
X-MC-Unique: hninVhcwM0Ke6wSG2h9DcA-1
X-Mimecast-MFC-AGG-ID: hninVhcwM0Ke6wSG2h9DcA_1778513531
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d83e45febso4378301f8f.0
        for <linux-rt-users@vger.kernel.org>; Mon, 11 May 2026 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778513531; x=1779118331; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drWyFR8xnXB3cjN95XAU9/1Dyd33+46Fr6KwmjcBb60=;
        b=Upci8HtDif30gJa+oak0KaiedUd7eObJsnfjhYd7bSe3sV1I/KYlB4xjp1WR/BMJk9
         iFHNwrV2eqpJSIfkWnDHxyJ8mMPhfjyHf4I3wVmgaqNbr60a/RRTpaY0BC8gb67wj7ov
         pl4qTpek2uYq3yjcCX9M7wdmbiLcIPijERuM3/GONijFTFffCrYce80u27scVrRs2CTh
         lIYVcsHuGUxci6R3VwpXn59h4ugFw52KrnvgH8q1JhXag0n1qQJAjaebnHbAAL5HYcK/
         M/VRx6cTzQeR1mCF6NOpEe5NBm88Tw61DbPfyJKhWh8AJ4aqwlvRpWCrXBS/ReCWJdHD
         +mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513531; x=1779118331;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drWyFR8xnXB3cjN95XAU9/1Dyd33+46Fr6KwmjcBb60=;
        b=MFBVzKTrxNv9Ugv20zzVNH/KB49HcmeAObavN5Dgj5SCmvoI1BqlLvuDud4Uctaofd
         Oq09O9vlZbSlprhsqdWPKZ4JMdsnWYcJBCJPGYqRHoDmw1Ot5NYFbsLVuPWMm9TDyzvD
         4oQ9JPLdOIEjfg1XbeqfF/LThezxkg6Y7YCMnLptk9z4RQZMgD+pABRyiBE3VmruqW+Z
         0Uitm3aoSgWV+6q4DPES5WiH8N+w30r4hDPZ5sktAi0krqmA7luSZSAoGGZCmuO9htjL
         3IwNnoR7HbXz3T/j7N86NTV8iR0MZDy18XgxbJHavYNPOxo7SQRci9GhLxR5t7q+qTkN
         fI3w==
X-Forwarded-Encrypted: i=1; AFNElJ8/Icr+NxR1DiF7CtCy27kUuntXF9iUwkdh724ZyrKEYuPhOwrxrfQNDPAsP1Z04wkyRK79f3syJTh5RjYjnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcRH7Y0AGu2gRtAxPChHEff4UoIOaydLbaiD68wYM7aZa3sOv
	gijCAhrkZhR/kLPBatToflfoydaGzy9eG5ABrraxYJzjQYVDlG323b9s0Zq45JvBSnTE5n9Q33N
	SbEyOTdUDNRwz8VjfaYMIH8dOdT41KHlj8qhZHRRB0NIpm5dvr3rC3hMogxIQOwsx4bJL
X-Gm-Gg: Acq92OHKoNpEt2IigeBwWsBzZI1m+O/ljHVCs1A/dQN3XAhnCnZbHj50YXFFpobaZCn
	9uVAE55FnITyogM5itAWj+jZC/JwmD6IXer7bPD2YbGSmLYQUbdJ86BpIB8+8LezhaoOP3/701R
	/v+a1X0wsaAu0cDURw8EFATglDddN+DFXmz1q9A0HR/FVSLg8Z5FsCpveomSx6B7Dek7Qg+SUW7
	w93VxPRIT6ixS9h3MIpnhVT8QKz9Ihh7S6Uy5UTo1HRM5LkS97yo9IxOHZaMTsdgF5ybWOMFOO4
	INRmyBjJFjOIhdWoOB5NdmG9BeWZa6a/g4vUuTg18v81mfnbxVYigF/K4ZMrC9H+IEOs9EQOF+4
	Ko2aR9e+4gdARejZkpXmOKSfo7/8jf5KT+zFAPR9H87R+WxTziQfEtWQh05jzxTqIbEOWxBJOBz
	Go0adsIe/FojcBKRg=
X-Received: by 2002:a05:600c:3f0a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e8e208ec7mr113975e9.9.1778513530879;
        Mon, 11 May 2026 08:32:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e8e208ec7mr113255e9.9.1778513530120;
        Mon, 11 May 2026 08:32:10 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f48a8sm186784125e9.15.2026.05.11.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:32:09 -0700 (PDT)
Message-ID: <584683c4190d3bb716220b10b874c3464a2b3648.camel@redhat.com>
Subject: Re: Question about SCHED_DEADLINE and cgroupv2/cpuset interaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Jakobi <tobias.jakobi.lr@gmail.com>, 
	linux-rt-users@vger.kernel.org
Date: Mon, 11 May 2026 17:32:08 +0200
In-Reply-To: <01786b03-87a4-4a7a-a5c0-9924c5d1a166@gmail.com>
References: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
		 <d93c4b5e7dfb1ea784d8f0f7851f37f7bee2cacf.camel@redhat.com>
		 <08b8969f-d79d-4c9b-8499-f3180fdd832f@gmail.com>
		 <97cbeb922ebc0e5d157ed541bd3c21749bb06bec.camel@redhat.com>
		 <01786b03-87a4-4a7a-a5c0-9924c5d1a166@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 09:56 +0200, Tobias Jakobi wrote:
> OK, so I've proceeded by ditching both isolcpus and nohz_full. Upon=20
> reading about the tradeoffs (overhead of kernel entry/exit) I decided=20
> that nohz_full is probably not really helping the team that writes our=
=20
> userspace application. An application that makes heavy use of=20
> socket-based IPC.

Yeah that's better, nohz_full is basically asking the kernel to be out of y=
our
way. It's useful mostly when you have a single userspace task per CPU and y=
ou
don't want interruptions.

I'd say unless you have a benchmark proving nohz_full behaves better with y=
our
workload, just live without it.

> Anyway, with these two parameters removed I can setup the partition as ro=
ot.
>=20
> I have moved things around a bit, and this is how it currently looks like=
.
>=20
> root@cm5-slim:/sys/fs/cgroup/workload.slice# grep . cpuset.*
> cpuset.cpus:2-3
> cpuset.cpus.exclusive.effective:2-3
> cpuset.cpus.partition:root
> cpuset.mems.effective:0-7
> root@cm5-slim:/sys/fs/cgroup/workload.slice# cd workload-group0.slice
> root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group0.slice# grep=
=20
> . cpuset.*
> cpuset.cpus:2
> cpuset.cpus.effective:2
> cpuset.cpus.exclusive.effective:2
> cpuset.cpus.partition:root
> cpuset.mems.effective:0-7
> root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group0.slice# cd=20
> ../workload-group1.slice
> root@cm5-slim:/sys/fs/cgroup/workload.slice/workload-group1.slice# grep=
=20
> . cpuset.*
> cpuset.cpus:3
> cpuset.cpus.effective:3
> cpuset.cpus.exclusive.effective:3
> cpuset.cpus.partition:root
> cpuset.mems.effective:0-7
>=20
> sched_rt_runtime_us has its default value and I can spawn processes with=
=20
> SCHED_DEADLINE in both workload-group0.slice and workload-group1.slice.=
=20
> So far, so good!
>=20

Great!

> >=20
> > > I then remembered reading something in the systemd documentation abou=
t
> > > cgroup delegation and that changing anything cgroup related right und=
er
> > > systemd's nose was asking for trouble. I guess this is what "partitio=
n
> > > config conflicts with housekeeping setup" is supposed to tell me here=
?
> > I don't think systemd is to blame here (it seems not to care about part=
ition
> > types at all). But since it doesn't seem to support those it may be a g=
ood
> > idea
> > to find alternatives (e.g. plain cgroup).
>=20
> Hmm, I'm not sure if going for plain cgroup is feasible for us. The=20
> system I'm currently testing on is not the final thing. That's going to=
=20
> be some bigger AMD Epyc where each CCD becomes one of the group slices.=
=20
> With a lot of processes running inside the slices. The current=20
> architecture design intends to let systemd do the heavy lifting here.
>=20
> I think I'm going to at least ask the systemd folks if I'm looking for=
=20
> trouble here. At the moment I'm using a small helper service unit that=
=20
> sets up the slice/cgroup.

I had a look at the systemd code and I don't see any reason why doing=20

  ExecStart=3D/bin/sh -c 'echo root > /sys/fs/cgroup/cpuset/<name>.slice/cp=
uset.partition'

would cause any trouble.

I opened a PR to systemd to add an official way to do it though [1], anyway=
 do
ask the systemd folks, they surely know better than I do ;)

[1] - https://github.com/systemd/systemd/pull/42013
>=20
> root@cm5-slim:~# systemctl cat workload-compute0.service
> # /etc/systemd/system/workload-compute0.service
> [Unit]
> Description=3DSpawn compute workload on group 0
> Requires=3Dsetup-workload-slice@workload-group0.service
> After=3Dsetup-workload-slice@workload-group0.service
>=20
> [Service]
> Slice=3Dworkload-group0.slice
> ExecStart=3D/usr/bin/chrt --sched-runtime 80000 --sched-period 200000=20
> --deadline 0 /usr/bin/dd if=3D/dev/urandom of=3D/dev/zero bs=3D1M
>=20
> That is not exactly beautiful, but also not terribly ugly. Also all=20
> workload service units are auto-generated from a template anyway, so=20
> it's just a matter of adding something to the template.
>=20

Yeah, that's quite a pity systemd doesn't support the deadline scheduler..

>=20
> >=20
> > > After I wasn't getting anywhere here I focused on the bandwidth check=
.
> > > And since the whole thing worked after disabling the check, I
> > > disregarded the root_domain/partition idea.
> > Of course also disabling the bandwidth check (like you did initially) w=
orks,
> > but
> > you don't really want that.
> >=20
> > > But I guess the real cause is the root_domain then?
> > >=20
> > > With best wishes,
> > > Tobias
> > I hope I didn't make it more confusing than it actually is!
>=20
> Not at all! I agree though that it's not easy to wrap you around all=20
> this the first time around. :-D
>=20
> With best wishes,
> Tobias

Happy to help.
Cheers,
Gabriele

