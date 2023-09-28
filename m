Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE7B9CA6F
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 21:03:22 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBEB180
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 14:03:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d865db5b4c7so12225419276.1
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Sep 2023 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695934999; x=1696539799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gqvsSVA9D3JLwKD/rKokg+7J8uGdlY8IvswO5BZeoc=;
        b=aCUp1v+fE3K4h/sLEo8QjqyYDE/ODGCvRtcBUyQSVv7gHIhu8UAueg0v1yg5v+5J2u
         JstRjfb6OBSg1aP0LMzzhwPN0k+RICWVM1uWzZ1C0ifPtTYyC7NdcniOtG+IfqOj8A3q
         CE0gOLWLVdAbYpKub1Aem+DmnsYL6oYVaPjgJAd49XPucd78kwzdzTvLbjhiLP1ALPe6
         2ZlP7lc9f6xxpcoXYvBtfynX7+qECW90fb4zT5tAZ4Bi8sMvGtnXblPfDFLJi4580PxP
         rvKl9S8oJQJJQ0q7Jm0YdlDewcvwN3VvNaHyw+T9Lpx4ExD7btDIXmv/6rkATANdaVdT
         X/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934999; x=1696539799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gqvsSVA9D3JLwKD/rKokg+7J8uGdlY8IvswO5BZeoc=;
        b=KJMXhe4mmLbrXT3kPxh5inql8gnJFXtQcmsphbPhhT6QA9Zhf6GhrVoyA7U/kq1Ibk
         MTs2LgSG+KdyxES19WrDUjkAV60jzdMIkc1ViXcUokPn0uIErGDQJLllyDl91Hg2tOZB
         TshLyzmtdFhmxpKDtH+ycBCZTxVesgKuKpYEKnMGdFxrejN+hV9PAxUz5b5+3UolYrXb
         c1eVlQcxLwyOCmcKy23t4PhuGi/zmzuoMF3lu4KSiKE43gVO2U/kKhnfOc/WJfxRi0gz
         HvT0LxIl+GkFMGfvLzTX0aRLyroF/lP+kohdw0kmQc5l0hY0ilIZv50v1+VYI+FBjTy6
         1tFQ==
X-Gm-Message-State: AOJu0YxvaGUioUWAmmC58Awy8T/bm60J76qwfNx9lqBu95f1qLgLuHMg
	viksYJyIBb+uoS5yH70tCE/QRzHc+b1nfndYZ3w=
X-Google-Smtp-Source: AGHT+IGo5zNnrMPj3bPbvt+AgcTrI3tNNLwuhgvuYuB9RrpT+zkOeQnys6xoR6CXkqtSaRVFq2HnsJYR72wjYuwRg/U=
X-Received: by 2002:a25:da13:0:b0:d80:1344:3cd7 with SMTP id
 n19-20020a25da13000000b00d8013443cd7mr2566328ybf.4.1695934999373; Thu, 28 Sep
 2023 14:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
 <20230928083909.KySJvo1d@linutronix.de> <CANV1gkdPJ=gqT2nUuGzN=ytOxHN92opoS1aGEDqy3FmTWTmusw@mail.gmail.com>
In-Reply-To: <CANV1gkdPJ=gqT2nUuGzN=ytOxHN92opoS1aGEDqy3FmTWTmusw@mail.gmail.com>
From: Gautham <gautham.go@gmail.com>
Date: Thu, 28 Sep 2023 17:03:08 -0400
Message-ID: <CA+HXi8G7EgM4-KJLtw6FYM77G9D9W+vXUhqu95R=sw7OCyad6w@mail.gmail.com>
Subject: Re: Question Regarding isolcpus
To: Rod Webster <rod@vmn.com.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Joseph Salisbury <joseph.salisbury@canonical.com>, linux-rt-users@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, EMC developers <emc-developers@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+1
There are several applications ( high throughput, simple control
systems ) where isolcpus is used as a simple way to extract maximum
performance.

Request the team to please consult more widely before removing isolcpu.
Please let us know if a different venue/mailing list is the best site
for feedback regarding this topic.

Best
Gautham


On Thu, 28 Sept 2023 at 15:20, Rod Webster <rod@vmn.com.au> wrote:
>
> We in the linuxCNC community would not be in favour of removing isolcpus.
> In our application there are only one or sometimes two RT threads, a
> large user base deployed on a variety of platforms.
> isolcpus gives our users a simple way to optionally improve RT performanc=
e.
> When I review the cpusets documentation, it adds additional complexity
> to configuration.
> Our users are machinists, not IT professionals so would likely
> struggle to configure a cpusets environment.
> The LinuxCNC application is deployed on machine controllers so boot
> time parameters are not an issue and likely preferred.
>
> It would be appreciated if you could consult more widely before
> removing isolcpus as it will affect our users
> scattered through every country in the world.
>
>
> Rod Webster
> 1300 896 832
> +61 435 765 611
> VMN=C2=AE
> www.vmn.com.au
>
> Rod Webster
> 1300 896 832
> +61 435 765 611
> VMN=C2=AE
> www.vmn.com.au
>
> Sole Queensland Distributor
>
>
> On Thu, 28 Sept 2023 at 18:39, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2023-09-26 12:45:14 [-0400], Joseph Salisbury wrote:
> > > Hi All,
> > Hi,
> >
> > > I have a question regarding the isolcpus parameter.  I've been seeing=
 this
> > > parameter commonly used. However, in the kernel.org documentation[0],
> > > isolcpus is listed as depreciated.
> > >
> > > Is it the case that isolcpus should not be used at all?  I've seen it=
 used
> > > in conjunction with taskset.  However, should we now be telling rt us=
ers to
> > > use only cpusets in cgroups?  I see that CPUAffinity can be set in
> > > /etc/systemd/system.conf.  Is that the preferred method, so the proce=
ss
> > > scheduler will automatically migrate processes between the cpusets in=
 the
> > > cgroup cpuset or the list set by CPUAffinity?
> >
> > Frederic might know if there is an actual timeline to remove it. The
> > suggestions since then is to use cpusets which should be more flexible.
> > There was also some work (which went into v6.1 I think) to be able to
> > reconfigure the partitions at run-time while isolcpus=3D is a boot time
> > option.
> > From what I remember, you have a default/system cpuset which all tasks
> > use by default and then you can add another cpuset for the "isolated"
> > CPUs. Based on the partition it can be either the default one or
> > isolated [0]. The latter would exclude the CPUs from load balancing
> > which is what isolcpus=3D does.
> >
> > [0] f28e22441f353 ("cgroup/cpuset: Add a new isolated cpus.partition ty=
pe")
> >
> > > Thanks,
> > >
> > > Joe
> >
> > Sebastian
> >
>


--=20

Gautham Ponnu |  http://gauthamponnu.com
