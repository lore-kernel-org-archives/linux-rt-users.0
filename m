Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CF11CBA
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Apr 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474050; cv=none; b=tY2CnyNOs9seSYx2h0iRkmUUwQrWmwEiUHle1i3v33IPAGlqry65SamLXwQCdZQDRUmorEmVWTsaPXrxu/MN7WbrD4gv9RHEIAFIM68p8OzecbtULVPezHZkfHPgXRxpIXPh1CraSTtsbPt/6VFi7CCGjildXgUfpCeVeb3K9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474050; c=relaxed/simple;
	bh=2z/WtIopwaFvQL1UEDYXl1VOuUi1PlP0EPARC7uealc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtQb61qbsi6gLpif/LcqJnJkuIGOW9YFpD2iMQkZTu7l9BttuASPAwyy944ARfL0YrADh/n3xD96zMPSfdwmXjyGuTLtjpP03II+dIY6gjLy4v09rSAWK3hwUFmqPYk7MmQtdqgDn5WHKnH72ksw5rab3RAjvDfIMnMoIv5G6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3CFFm7t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYtZVfSL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3CFFm7t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYtZVfSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777474046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2z/WtIopwaFvQL1UEDYXl1VOuUi1PlP0EPARC7uealc=;
	b=R3CFFm7tD5ZlDjLwHyozhXeUuLP+jIr0G72gBitxYE7RKWj7ikvJ3j2VTo7zw1G1Wo0oNb
	F9wQlgQurrlwnVWZv5i6pmpe59u/COa0bOX0fX1PHJ7ZRUP+TspB5aER/f++3Bz35UEvDq
	RjaGaYy9Bi9oTe1yaEBVyyBM88j4Seg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6RSVt5V2P2myrZ2coIt4ig-1; Wed, 29 Apr 2026 10:47:25 -0400
X-MC-Unique: 6RSVt5V2P2myrZ2coIt4ig-1
X-Mimecast-MFC-AGG-ID: 6RSVt5V2P2myrZ2coIt4ig_1777474044
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fba8d8c40so18964911cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Apr 2026 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777474044; x=1778078844; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z/WtIopwaFvQL1UEDYXl1VOuUi1PlP0EPARC7uealc=;
        b=cYtZVfSL7i9qEA0yLjSg7NNDRdGHj1Jsfg3I8e35DvkYPX3SJOFfZ4rhjxuWiLSCVq
         rMZFto4I4K0Le5lHpOa/hCsPAG3YC98i4A5jhsI8t9QziLLrkjuAtdQ5tHL2dxVqu/n0
         1XviivSaQssuDAVu80SSsGMLQ0uenP7tVxR5nalEh/j8aIziOkF54RXuTmKwnw0QFFkE
         4lbTHuaHKt4u21sv52pApFBbYr4zc1LwoBNpQF9NXt8QivAj7/Qzav0DLdyQTSMJY54H
         QqLqhdLx7kOKel3A/cui74Gi+DB+sq1toGAA8/uSi3jp75T+qCs+Wbq0dNjaPWnwMut4
         FAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474044; x=1778078844;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z/WtIopwaFvQL1UEDYXl1VOuUi1PlP0EPARC7uealc=;
        b=pHECo4C90szs3LqQwiE8kOZNkBpm6tEejcGOQzLKrFPuQRQCwtw8RPHpuLdDTsVc6q
         sw6tRwmH52j1e/ubJmFLWm4kdwIJ4J1UscuiE7mRa2/N/bE0rHUP61PtdiTnJW5/M+en
         ExAWt+OPeTIYmiRwiU6bnKE9Xo6Ur1+Tb+7CCjmGVEUS/LrUqGW9zhIxhSIH2dNfWQ+q
         RZM1khCdBcjKyYiAJ4BwvIO5UnUjzto/+Pi2JldCtwMyMUylWqx1CtrEs3ERMACUMztB
         EoUTj73g91RfrqY05qhUtNmPn8qI7kRyhhYsx9hXJZqCmjfWmwJppbPvehcerjF8Y2FQ
         VmVA==
X-Forwarded-Encrypted: i=1; AFNElJ95sQzMorbsDL6NjCI6cuK4orfgq+kiE/yMYgd5BIvajOaHanqh6mxqT3gvmzAo3WZuaBDBe8QsEkC+D/kugA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxql1CJGLOXChGp6P9/UzvdfqNXT2KGM7KSGePlu/+OPjzs3Uml
	N4OZxe3fgS07+9JJZkZo1RQ7awTVlcqEyHSJtUUMJuF0yRvlZe7nxdDhkxxdF4fFaqlfHInHAlC
	Gi4LTMMXwFhIahdc5x3Cg3SMxpveFRRhlN+uV9fUqR+eLeYUZat6o1FFKsb9UDQ8Vo2xd
X-Gm-Gg: AeBDiestXu2h/+5tLC5Uj1wkHGXepuRvYweELQml3hW6MQ1pxrIgcwy4TuDWWamwPGW
	dqcqGpmaGfhS5ELdfgLn85mNnwia4jP/u1An+DsHlZju6qFwe37BQ568h0fZxzEVmzIcdm5dfqC
	rkiA1duNy2WfrPj31hf0teaMAiiqqHGZoS+rJyuugZ82fpZ1tiSVI74AAsEzO2BvtuukuN+ZkXt
	kBruWOlxVzWgDUl9SP6Z2sJcYunUZIwCtGb2RPIf1C7OkD6C7iIdD0UYClcHo6t2ckr6hu45Kai
	UgYtNrn1KW+4FsYF3kMuUs1CamL2gIhHV+bdwN8uCPi+OUlr3rgxJ+Kofut8soJ0ic0g51H5hmR
	dnN9zv5N/yxMpvuoZE7NO0CovUj51HOk4IiXB
X-Received: by 2002:a05:622a:5908:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-5100e0f46dbmr115421171cf.10.1777474043914;
        Wed, 29 Apr 2026 07:47:23 -0700 (PDT)
X-Received: by 2002:a05:622a:5908:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-5100e0f46dbmr115420641cf.10.1777474043267;
        Wed, 29 Apr 2026 07:47:23 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101aca01ddsm18139061cf.3.2026.04.29.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:47:22 -0700 (PDT)
Message-ID: <d93c4b5e7dfb1ea784d8f0f7851f37f7bee2cacf.camel@redhat.com>
Subject: Re: Question about SCHED_DEADLINE and cgroupv2/cpuset interaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Jakobi <tobias.jakobi.lr@gmail.com>, 
	linux-rt-users@vger.kernel.org
Date: Wed, 29 Apr 2026 16:47:21 +0200
In-Reply-To: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
References: <ceba9f1b-0694-44ec-bdc9-a443d2127102@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tobias,

giving my 2 cents here.

On Tue, 2026-04-28 at 15:52 +0200, Tobias Jakobi wrote:
> For the RT work we have these slices.
>=20
> root@cm4-fat:/etc/systemd/system# cat workload.slice
> [Slice]
> AllowedCPUs=3D2-3
>=20
> root@cm4-fat:/etc/systemd/system# cat workload-core2.slice
> [Slice]
> AllowedCPUs=3D2
>=20

Applying the configuration above, I get both slices as member
partitions (not root):

head /sys/fs/cgroup/workload.slice/{,*/}cpuset.cpus.partition=20
=3D=3D> /sys/fs/cgroup/workload.slice/cpuset.cpus.partition <=3D=3D
member

=3D=3D> /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset.cpus.part=
ition <=3D=3D
member

Running your example in either slice doesn't work in my case.
That's because in the admission control we "Don't allow tasks with an
affinity mask smaller than the entire root_domain to become
SCHED_DEADLINE" [1].

In short that's to make the admission control able to give guarantees.

Setting the partition as root:=20

echo root > /sys/fs/cgroup/workload.slice/cpuset.cpus.partition
echo root > /sys/fs/cgroup/workload.slice/workload-core2.slice/cpuset.cpus.=
partition

Fixes the issue in my case.
I don't really know how to specify that in systemd and I'm assuming
your version/configuration of systemd was somehow setting workload-
slice as root automatically, that's likely why it was working.

Could you try this on your side?

Cheers,
Gabriele

[1] -
https://elixir.bootlin.com/linux/v7.0.1/source/kernel/sched/syscalls.c#L627

> Note that core2 is a child of workload, i.e. on the cgroup level it=20
> looks like this.
>=20
> root@cm4-fat:~# find /sys/fs/cgroup/ -name workload\*.slice
> /sys/fs/cgroup/workload.slice
> /sys/fs/cgroup/workload.slice/workload-core2.slice
>=20
> So what's exactly this problem I'm seeing? It's this here.
>=20
> root@cm4-fat:~# systemd-run --slice=3Dworkload-core2.slice --pty chrt=20
> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
> works
> Running as unit: run-p676-i976.service; invocation ID:=20
> d59dc443f66f46a6ba2dfd125e04f830
> Press ^] three times within 1s to disconnect TTY.
> chrt: failed to set pid 0's policy: Operation not permitted
>=20
> What works however is this here.
>=20
> root@cm4-fat:~# systemd-run --slice=3Dworkload.slice --pty chrt=20
> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
> works
> Running as unit: run-p670-i970.service
> Press ^] three times within 1s to disconnect TTY.
> this works
>=20
> I double checked the slice settings, and they apply.
>=20
> root@cm4-fat:~# systemd-run --slice=3Dworkload.slice --pty bash -c
> 'grep=20
> Cpus_allowed_list /proc/$BASHPID/status'
> Running as unit: run-p727-i1027.service
> Press ^] three times within 1s to disconnect TTY.
> Cpus_allowed_list:=C2=A0 =C2=A0 =C2=A0 2-3
>=20
> Once again for the core2 slice.
>=20
> root@cm4-fat:~# systemd-run --slice=3Dworkload-core2.slice --pty bash -
> c=20
> 'grep Cpus_allowed_list /proc/$BASHPID/status'
> Running as unit: run-p732-i1032.service
> Press ^] three times within 1s to disconnect TTY.
> Cpus_allowed_list:=C2=A0 =C2=A0 =C2=A0 2
>=20
> This really puzzled here. Why would this work for AllowedCPUs=3D2-3,
> but=20
> not for AllowedCPUs=3D2?
>=20
> I then dove in the documentation and the code, trying to understand=20
> where the -EPERM was coming from. I finally decided to disable the=20
> bandwidth check that the kernel performs.
>=20
> root@cm4-fat:~# echo -1 > /proc/sys/kernel/sched_rt_runtime_us
> root@cm4-fat:~# systemd-run --slice=3Dworkload-core2.slice --pty chrt=20
> --sched-runtime 100000 --sched-period 200000 --deadline 0 echo this
> works
> Running as unit: run-p760-i1060.service
> Press ^] three times within 1s to disconnect TTY.
> this works
>=20
> And voila, suddenly everything works. I fail to understand though why
> the bandwidth check fails here. I mean, 100000 / 200000, that's fifty
> percent, so the check should pass.
>=20
> And apparantly the ratio itself doesn't seem to have any effect. I=20
> enabled the check again and reduced the runtime so that the ratio is=20
> just 5%. Still the same.
>=20
> root@cm4-fat:~# echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
> root@cm4-fat:~# systemd-run --slice=3Dworkload-core2.slice --pty chrt=20
> --sched-runtime 1000 --sched-period 200000 --deadline 0 echo this
> works
> Running as unit: run-p838-i1138.service
> Press ^] three times within 1s to disconnect TTY.
> chrt: failed to set pid 0's policy: Operation not permitted
>=20
> I looked around some more, made sure that CONFIG_RT_GROUP_SCHED=3Dn,
> but=20
> the more I think about, the more I get the impression that I totally=20
> misunderstand how the bandwidth check works.
>=20
> To be explicit, by bandwidth check I mean the line that is found in=20
> section 4.1. here:=20
> https://www.kernel.org/doc/Documentation/scheduler/sched-deadline.rst
>=20
> Would be nice if someone could shed some light on this. Thanks in
> advance!
>=20
> With best wishes,
> Tobias Jakobi
>=20

