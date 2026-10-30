Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793375325;
	b=RKlvyzbiUuIpMbs+ZTrfyET4dSYxveHJYMg6tilyGAdaqSY7/oF1uyA7Ihc4gfmobisz
	 Dyp75seTy6cwD0EkYLmQQxjF+nApyvVoTKoNSJp0qC9HmncHu+sZyLwNf1V2cfhEhp7Nx
	 BMpFWfp99RQqRBb7HHgbh4hu7p87chKTsHSQNXDzOYVB2IJHLpia6otb8opJ0JtyumNV8
	 ddZgs6WEZexuBR5ucGBVp2FTL1nsEl+VogFzpl6Cx9IA+loBd4Vt6wcPQ3TRQXysZ2gMZ
	 X+7LKjD4AkJ13kmcPdRmEqQaR5MkSC/LQhD9dfPNxuKpWbdgKIMRY43ukiDwXlgpXiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1SdZaLdPak2FKD5fnDB1khWRjdwvVonI2nIK2N8FF88=;
	b=xLu8/OkjFcJTO0IYtkfiZKEg/xiDqeYP1shV+yMsnVTxw7Z3VmLTWM9l+ziAJ0rxHRtv
	 VA5u/GTnjqpZG6D7Nq0BZUE3CyWYls8vjO1vr025H/++9N+c4L2MImG7xCdOiEk8Ik0L6
	 S6xRam0qru2cIVPGmqvA5s8/UzO1LFyDJL0lJ0KyVkziB1sdWmJ5cOTmnFJRWfPvS5vz5
	 HBNPIpVzn1mZzovrZo37ehLS04pNFB+ZxeKw8rQqLdX+MbwS5s65grp4tfEZpSLlL29y1
	 fEVqWbMQcgHE/+gha/rddF96Ie+EUt941pppB9Wfl6O4mmYXs7RF82PpG5Wh/TKFP2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FoSgDxb1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C234606A31C
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 15:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C234606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FoSgDxb1
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1100073f8f.1
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 08:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793375324; cv=none;
        d=google.com; s=arc-20260327;
        b=NRwPhLDZg2DCAGZwt3VgPX4TflHCoIo3BXT4salOk3rQjLuU1beBuMGyd0cqu/fFha
         Ms2oxxZ6Vr3U9NxvMiuH9OTIRBgRjuQsy19TezjSR/QdIaLFXW79afRx6i0fmHKnAWbr
         4iMgfEhlhsRHKNv/9Sg3L9yPEXV4jQmHaoGX8LDwcZx5CvUkt3+9iKUIliuqo43Aouji
         +WFuAdc3ubzitJ4paaQqMlRszgQ6GCEmuRRW7Lq63iJJZM/b5Z7BAbwowyxdVYL9EvJv
         0AXFx1AFa/qnrdyn4UZfBgrXcjBYGuM3YmFqLAjR69wlVADzvszuffR6Tutm5TXu2ZPI
         e7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1SdZaLdPak2FKD5fnDB1khWRjdwvVonI2nIK2N8FF88=;
        fh=m1wjVorP4AltZKCYchZArwbMbiMV4qo5V2k3O7MogGg=;
        b=kYCb2je6meVMWYo7LnhdsHdKTqsizrYE7G9NsNA9fyc3AGcDW46MpkqmNt9F0x9w3Q
         ElPomLwfrOYM3lRwANnZ2njOMw5j8+8VSX3ibQb9haLN+H7n8yjYgleTinm900QdYRcW
         SFkaIUOhvFSD934fqwx/QBRJ7KdTrXdePzlz1jQldGZrrd6Nk/jGQQz372a/wKCWAHbV
         kZkr/QhtuOCHFPHDNProO4haflL8RjbWnIYg8vlX1CRPX9GZBpdr7d6IWMZ/xmKnXLLy
         tVSkZnaUGxrUNjurX7o8XeUEExAW4S8CeYg4SFBTGdqQPAGfGGn5fYvqJDkopDHOjb9U
         GJVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793375324; x=1793980124; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1SdZaLdPak2FKD5fnDB1khWRjdwvVonI2nIK2N8FF88=;
        b=FoSgDxb1/AUJvgrnmzZU/X9WmaTSJ8u0tEjdKqgvbA/fJSQ30+SG2wc5EhUAZBobus
         4AV5gBO5+alZS3l4U/ePOH6UZl3V0weYgjPdi/1US5hjE/h25EZgEJhFB0cfAQOlWMOo
         GxwdPdm88tyEA4NEDxI1546ZBMc5EjisbG8WazHLK72K5XgqN/9PyApULA9QmMf4kpuu
         LC0LcrK+PY4yuzO8YaV3IeCyyivuyqme5f3KVsNCUTqPqJhdOHVUJGxAaJYiEFngh86N
         MLMp+OyjDGIjAjmxwg9BVmvYs/WUZHUlAFzLGL2BXXlZoo30WE0EQbIlcJnyyQdo3APo
         Tp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375324; x=1793980124;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1SdZaLdPak2FKD5fnDB1khWRjdwvVonI2nIK2N8FF88=;
        b=X7f1F1eDqbpqDHXyjKR6dd+0UouPLhH/QjGyrhb2q5tobkXvsZD5GaP6AUTpK0ROhi
         2mcOn1BH0+L/LmGJTWhCBLDPmbKy+OzgV+4foxuJ9nKU2aEm8118ptU46K2ff77ch15B
         JwqzOUfSJ9iQyOhJI1X5W0fHx0orGXrQ+O2IdYHi5S3oRb+pNW77px3ZqawptqnqrmjO
         sqCeFuk60Lhwumt95/NMLpEeJjZemCOchKms6EFBgQB2JZCL0MDuTw7+MNJjFUWmycKa
         vt2YwqL6jF397sBcemIkQzVR1zwQ4gjyC85Z34JwOTZRvakqUPQ2SggahUNvkP49QLA7
         TXqw==
X-Forwarded-Encrypted: i=1; AKwUvBwj28+p7rWXwkSlhhCzkqmc4gSi92vsrecOxWM35e8yl1CqPJcw2i0TonKsGdJs3hFNaxwszoPFuYCyx8mEjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+vtlhyEWPEfqb+MkFXs9EO40D7iJgaiNGvoeTwYuJUTV5eCld
	YtxFZNUUc4DiOSZtE6WGeIs+oYfmmqhhg90WOpHyHL8eJWgOo1vlhEwLp/PdXaaUCDwzG6yZtjH
	Kvd7MKRk2HhclGvh02NhT8a8P2PXTDViPynbGBmviNZlhNSUc1Aht7nXCBQ==
X-Gm-Gg: AYBFou2mFXBDbyzc+JPKgVyxhKLUlKlqPKJ68UdkFaqR40Rrz6dHyDEpT5wR2Ljb0ra
	Qm0I1V4JiJBagsJypGWn/uBejruZTZvxbU7yK9WLNCmygRQXfpSjumoRtd/Xhyvp2+JIokmAsas
	TwCxuSTWBFZczKjz46ThW5D/xcLgruRv5yoUU6v81BEhmI8SA8FHotUs0TQCofecD4ptVORatYQ
	PRF5hYyVRVcM6GLTAcgrTFiVUYlnDFSroKDeEB7llEUPG8FykoHMoFq/czsMd8O3zcLdH4a6Usc
	2hU3odEsWcY4IZoeSgenxq3//0vCOu2INi9l1e9iQTf9VbMUZ3uXAyDHOeIGyn10oFIugYPhoU+
	4SjNIcMehd7P/xtvc8cmYB9R0ahvQ+Vg0pTq5AnOzUeKn4QYoPvME7xOqILGRfpN9NIoVMEb4rv
	DU5PZwiY02kx3IJR0q2Lx2UnFIXUYoLfrMMw==
X-Received: by 2002:a05:6000:40db:b0:48e:5d06:8b66 with SMTP id
 ffacd0b85a97d-48e6e2dbbc5mr6990214f8f.19.1793375323759; Fri, 30 Oct 2026
 08:48:43 -0700 (PDT)
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>
 <SJ0PR17MB4288FC2E7FFB577F5D6C6D9EBB9E2@SJ0PR17MB4288.namprd17.prod.outlook.com>
 <SJ0PR17MB4288C46458DCE2C015839D0FBB9E2@SJ0PR17MB4288.namprd17.prod.outlook.com>
 <CAPjX3Ff-zn2hda=deMvCGM1UMM6Zghh-ywabBMTqFUbzC69YEA@mail.gmail.com>
 <PH0PR17MB427723A82BCB2A6FCD37B329BB662@PH0PR17MB4277.namprd17.prod.outlook.com>
 <20261021155016.1isOptPI@linutronix.de> <PH0PR17MB4277D532F68355EEF5E4F8EDBB662@PH0PR17MB4277.namprd17.prod.outlook.com>
In-Reply-To: <PH0PR17MB4277D532F68355EEF5E4F8EDBB662@PH0PR17MB4277.namprd17.prod.outlook.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 30 Oct 2026 16:48:32 +0100
X-Gm-Features: AclHuK_-FcdAqoQLHCObxIK71YflbVTMDyBFVxGFqrn4PvFFk90oar9YPmFwNL4
Message-ID: <CAPjX3FfYBZUsP681PUyf53QRssi8Ceq=tPV=bWNT2+_t8Jfqtw@mail.gmail.com>
Subject: Re: Btrfs PREEMPT_RT transaction-waiter livelock: experimental
 mitigation in kernel 6.6.78
To: "Naulls, Peter" <PeterNaulls@eaton.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 19:48, Naulls, Peter <PeterNaulls@eaton.com> wrote:
>
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> > That sounds plausible. I did ask if RT tasks are involved and I think
> > the answer as no. With just SCHED_OTHER tasks it behaves as spinlock_t
> > on !PREEMPT_RT (except for the preemption which should have no impact).
>
> Yes, we are not doing anything special RT wise apart from the kernel enablement.
>
> I put Daniel's patch into 6.6 and ran it 100000 times against a ramfs btrfs image
> and then thousands more times against a flash backed btrfs mount and no problems.
>
> I'll await the final word from him on this before committing to it for our work.

I posted a refined version for review. My testing was OK with that one.

https://lore.kernel.org/linux-btrfs/20261030153617.329733-1-neelx@suse.com/

(Forgot to CC Sebastian, sorry. Though at least the linux-rt-users
list is there for reference.)

--nX

> As some background, it appears the bug was introduced in early 2022:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fd76bf31ccfecc06e2e6b29f8c809e934085b99
>
> And is present in all kernels from 5.15 on.
>
>
