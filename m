Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2733D5
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 19:20:17 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FC199
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 12:20:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40537481094so136988005e9.0
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20230601.gappssmtp.com; s=20230601; t=1695928813; x=1696533613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U8+sdbOKl2XSv8vadzhff/InvaVugNI7SIBuCm0yQA=;
        b=z1CkPqH5A+iD5KYTH6BnrT97Qdl9SwfREEh1PtK2o6Ag4JupUvdSr7O0oTDlu3QxuK
         4V/D6MAx2Yu+ScAJkwhRMnMJG4rkf/hNoSbsq6RzYVeJfbBAtsrOhACnXvVyQMgRluqP
         vFSN2nCq5/2cZu1itHm/7fzC/kESmaKIlLCTs9xtJzXM2lbxRXFT+QN6DnKMZ0z6BDxB
         abYcORPmbnGnzAvV+oI20QJcE5pYDFkNTOhRvGV6yCsiOJkN1STLyXnZ09VnPuI8+Uz4
         U0tWuYlOzHCCYMMq3DebeqifXJjuOwFGwFLfYyg8HgyI+M6J49ZjGMCuKmi/+Y555X4u
         /3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928813; x=1696533613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U8+sdbOKl2XSv8vadzhff/InvaVugNI7SIBuCm0yQA=;
        b=JhAdA41O99lsglw0LfoWNFVZgqHOxv/bF8MGzLXgQlseBSRxVTrQcjoNEqppu3lnHY
         Po6RnvwNNaftI2YlaK5tHxmLdFk23sLgnB2YrYMBGN00e+js5qTDBwCNBCBcquFoRTHq
         WgKiTfrQOgK9VBeoRfZiZsApp1NU0VKvNlgi9DkMVnOMHP8GJetzANONT6f1PqIgXQJS
         MwZ5a071h4VzXTCP9Vtnux0h5klBMjMdKqxAp92qZDelktbY/6wGVgqVMm5mrede5t+/
         F8s2hJYcMSNcFSWnSJ9Dq9QVtMpZj4f5P3FEutAvtq/iUVRngv7S2oUYjSVSKQa1T+eC
         GsTg==
X-Gm-Message-State: AOJu0YysvJjsKIBf2IOsgVI8S4wra1Y6Q3A4tbf4X+v2o1/16fng5IcP
	en/gariYNwFgpMT7CTaCzSXJEtUE+s5JKrzSMQHGwg==
X-Google-Smtp-Source: AGHT+IGqQX6bilfD4xAJvlXjXGg820fV6IyMovOL1Pmwc9ekFUzMl22lBMux57J5VmatE18gMLDtjD9DocKKrVg82YI=
X-Received: by 2002:a5d:6505:0:b0:31c:70b0:426b with SMTP id
 x5-20020a5d6505000000b0031c70b0426bmr1927353wru.63.1695928813284; Thu, 28 Sep
 2023 12:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com> <20230928083909.KySJvo1d@linutronix.de>
In-Reply-To: <20230928083909.KySJvo1d@linutronix.de>
From: Rod Webster <rod@vmn.com.au>
Date: Fri, 29 Sep 2023 05:19:59 +1000
Message-ID: <CANV1gkdPJ=gqT2nUuGzN=ytOxHN92opoS1aGEDqy3FmTWTmusw@mail.gmail.com>
Subject: Re: Question Regarding isolcpus
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, linux-rt-users@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, EMC developers <emc-developers@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We in the linuxCNC community would not be in favour of removing isolcpus.
In our application there are only one or sometimes two RT threads, a
large user base deployed on a variety of platforms.
isolcpus gives our users a simple way to optionally improve RT performance.
When I review the cpusets documentation, it adds additional complexity
to configuration.
Our users are machinists, not IT professionals so would likely
struggle to configure a cpusets environment.
The LinuxCNC application is deployed on machine controllers so boot
time parameters are not an issue and likely preferred.

It would be appreciated if you could consult more widely before
removing isolcpus as it will affect our users
scattered through every country in the world.


Rod Webster
1300 896 832
+61 435 765 611
VMN=C2=AE
www.vmn.com.au

Rod Webster
1300 896 832
+61 435 765 611
VMN=C2=AE
www.vmn.com.au

Sole Queensland Distributor


On Thu, 28 Sept 2023 at 18:39, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
> > Hi All,
> Hi,
>
> > I have a question regarding the isolcpus parameter.  I've been seeing t=
his
> > parameter commonly used. However, in the kernel.org documentation[0],
> > isolcpus is listed as depreciated.
> >
> > Is it the case that isolcpus should not be used at all?  I've seen it u=
sed
> > in conjunction with taskset.  However, should we now be telling rt user=
s to
> > use only cpusets in cgroups?  I see that CPUAffinity can be set in
> > /etc/systemd/system.conf.  Is that the preferred method, so the process
> > scheduler will automatically migrate processes between the cpusets in t=
he
> > cgroup cpuset or the list set by CPUAffinity?
>
> Frederic might know if there is an actual timeline to remove it. The
> suggestions since then is to use cpusets which should be more flexible.
> There was also some work (which went into v6.1 I think) to be able to
> reconfigure the partitions at run-time while isolcpus=3D is a boot time
> option.
> From what I remember, you have a default/system cpuset which all tasks
> use by default and then you can add another cpuset for the "isolated"
> CPUs. Based on the partition it can be either the default one or
> isolated [0]. The latter would exclude the CPUs from load balancing
> which is what isolcpus=3D does.
>
> [0] f28e22441f353 ("cgroup/cpuset: Add a new isolated cpus.partition type=
")
>
> > Thanks,
> >
> > Joe
>
> Sebastian
>
